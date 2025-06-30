import { Gtk } from "astal/gtk4";
import { exec, Variable } from "astal";

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

export function Volume() {
  return (
    <menubutton halign={Gtk.Align.CENTER} cssName="Volume">
      <label label="V" />
      <popover>
        <VolumePopover />
      </popover>
    </menubutton>
  );
}
