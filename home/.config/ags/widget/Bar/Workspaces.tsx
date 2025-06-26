import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland";

export function Workspaces() {
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
