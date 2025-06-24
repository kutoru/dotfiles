import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { bind, exec, GLib, Variable } from "astal";
import AstalHyprland from "gi://AstalHyprland";
import { Popover } from "astal/gtk4/widget";

function Workspaces() {
    const hypr = AstalHyprland.get_default();

    const workspaces = bind(hypr, "workspaces").as((wss) =>
        wss
            .sort((a, b) => a.id - b.id)
            .map((ws) => ({
                label: String(ws.id),
                cssClasses: bind(hypr, "focusedWorkspace").as((fws) => [
                    fws.id === ws.id ? "focused" : "",
                ]),
            })),
    );

    return (
        <box
            halign={Gtk.Align.CENTER}
            orientation={Gtk.Orientation.VERTICAL}
            cssName="Workspaces"
            spacing={8}
        >
            {workspaces.as((wss) =>
                wss.map((ws) => (
                    <label
                        label={ws.label}
                        halign={Gtk.Align.CENTER}
                        cssClasses={ws.cssClasses}
                    />
                )),
            )}
        </box>
    );
}

type VolumeState = {
    left: number;
    right: number;
    balance: number;
};

function getVolume(): VolumeState {
    const out = exec(["bash", "-c", "~/.config/ags/scripts/get-volume.sh"]);

    console.log("get", out);

    const [left, right, balance] = out
        .split(" ")
        .map(Number)
        .map((value) => (value > 1 ? value / 100 : value));

    console.log(left, right, balance);

    return { left, right, balance };
}

function setBalancedVolume(left: number, balance: number) {
    const newLeft = Math.round(left * 100);
    const newRight = Math.round(left * 100 * (1 + balance));

    console.log("set", left, balance, newLeft, newRight);

    const out = exec([
        "bash",
        "-c",
        `pactl set-sink-volume @DEFAULT_SINK@ ${newLeft}% ${newRight}%`,
    ]);

    console.log("set", out);
}

function setVolume(left: number, right: number) {
    const newLeft = Math.round(left * 100);
    const newRight = Math.round(right * 100);

    exec([
        "bash",
        "-c",
        `pactl set-sink-volume @DEFAULT_SINK@ ${newLeft}% ${newRight}%`,
    ]);
}

function VolumePopover() {
    const volume = Variable<VolumeState>(getVolume()).poll(1000, getVolume);

    return (
        <box
            halign={Gtk.Align.CENTER}
            cssName="VolumePopover"
            onDestroy={() => volume.drop()}
            spacing={8}
        >
            <box orientation={Gtk.Orientation.VERTICAL}>
                <label
                    label={volume().as((value) => `${Math.round(value.left * 100)}`)}
                />
                <slider
                    inverted
                    orientation={Gtk.Orientation.VERTICAL}
                    value={volume().as((value) => value.left)}
                    onChangeValue={({ value }) => {
                        setVolume(value, volume.get().right);
                    }}
                />
            </box>

            <box orientation={Gtk.Orientation.VERTICAL}>
                <label
                    label={volume().as((value) => `${Math.round(value.right * 100)}`)}
                />
                <slider
                    inverted
                    orientation={Gtk.Orientation.VERTICAL}
                    value={volume().as((value) => value.right)}
                    onChangeValue={({ value }) => {
                        setVolume(volume.get().left, value);
                    }}
                />
            </box>
        </box>
    );
}

function Volume() {
    return (
        <menubutton halign={Gtk.Align.CENTER} cssName="Volume">
            <label label="V" />
            <popover>
                <VolumePopover />
            </popover>
        </menubutton>
    );
}

function getPopoverWithResettableCalendar(datetime: Variable<GLib.DateTime>) {
    const popover = Popover();
    const calendar = new Gtk.Calendar();

    popover.set_child(calendar);

    popover.connect("show", () => {
        const day = datetime.get().get_day_of_month();
        const month = datetime.get().get_month() - 1;
        const year = datetime.get().get_year();

        calendar.set_day(day);
        calendar.set_month(month);
        calendar.set_year(year);
    });

    return popover;
}

function Time() {
    const datetime = Variable(GLib.DateTime.new_now_local()).poll(1000, () =>
        GLib.DateTime.new_now_local(),
    );

    const time = datetime((value) => value.format("%H:%M") ?? "?");
    const date = datetime((value) => value.format("%m/%d") ?? "?");

    const calendar = getPopoverWithResettableCalendar(datetime);

    return (
        <menubutton
            halign={Gtk.Align.CENTER}
            cssName="Time"
            onDestroy={() => datetime.drop()}
        >
            <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
                <label label={time} />
                <label label={date} />
            </box>
            {calendar}
        </menubutton>
    );
}

export default function Bar(
    gdkmonitor: Gdk.Monitor,
    alignTo: Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT,
) {
    const { TOP, BOTTOM } = Astal.WindowAnchor;

    return (
        <window
            visible
            cssName="Bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={alignTo | TOP | BOTTOM}
            application={App}
        >
            <centerbox orientation={Gtk.Orientation.VERTICAL}>
                <Workspaces />
                <box />
                <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
                    <Volume />
                    <Time />
                </box>
            </centerbox>
        </window>
    );
}
