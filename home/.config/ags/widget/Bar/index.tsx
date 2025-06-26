import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { Workspaces } from "./Workspaces";
import { Volume } from "./Volume";
import { Time } from "./Time";

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
