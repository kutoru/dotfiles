import { Gtk } from "astal/gtk4";
import { GLib, Variable } from "astal";
import { Popover } from "astal/gtk4/widget";

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

export function Time() {
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
