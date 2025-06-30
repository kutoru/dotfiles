import { App, Astal } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./widget/Bar";

const monitors = App.get_monitors();

App.start({
  css: style,
  main: () => {
    Bar(monitors[0], Astal.WindowAnchor.LEFT);
    Bar(monitors[1], Astal.WindowAnchor.RIGHT);
  },
});
