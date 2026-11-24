# tmux

tmux configuration, plus an app launcher that opens ready-made pane layouts
such as a system monitor.

| File | What it is |
|---|---|
| `tmux.conf` | The main config: prefix is `;`, press `prefix ?` for a key cheatsheet |
| `tmux.conf.local` | Machine-local settings, like the accent colour picked with `prefix M-c` |
| `keys.txt` | The cheatsheet shown by `prefix ?` |
| `palette`, `palette.zsh` | The command palette (`prefix p`) |
| `launch`, `launcher.zsh` | The app launcher (`prefix d`) |
| `layouts/` | Layouts the launcher can open |
| `widgets/` | Small status panes that layouts are built from |


## 🚀 App launcher

Press `prefix d` to pick a layout, then:

| Key | Opens the layout as |
|---|---|
| `Enter` or `w` | a new window in this session |
| `s` | its own session, named after the layout |
| `f` | a floating pane over the current window. `prefix D` or a click outside closes it |

The session and the float leave the layout running in the background, so
opening it again is instant.

From a shell:

```sh
~/.config/tmux/launch sys        # as a window (needs to run inside tmux)
~/.config/tmux/launch -s sys     # as a session; works outside tmux too
~/.config/tmux/launch -f sys     # as a float
~/.config/tmux/launch -l         # list the layouts
```


## 🗂 Layouts

### `sys`: system monitor

```
┌ sysinfo ───────────┬ cpu ───────────────────────┐
│ user@host, uptime  │ htop, busiest first        │
├ net ───────────────┤                            │
│ network connection │                            │
├ updates ───────────┤                            │
│ pending updates    │                            │
├ notes ─────────────┤                            │
│ scratch pad (vim)  ├ disk ──────────────────────┤
│                    │ disk usage                 │
└────────────────────┴────────────────────────────┘
```

The notes pane is a vim buffer saved on every change, one file per tmux
session in `~/.local/share/scratchpad/<session>.md`, so notes survive the
session being closed.

### `services`: background services

```
┌ services ──────────┬ containers ────────────────┐
│ brew services or   │ podman containers          │
│ systemd units      ├ ports ─────────────────────┤
│                    │ listening ports            │
└────────────────────┴────────────────────────────┘
```

The containers pane only appears when podman is installed. Otherwise ports
takes the whole right side.

On Linux, every running user service is listed, but system services are only
counted, since most belong to the distro. To see particular units, running
or not, list them in `units=` near the top of `layouts/services`. Prefix user
units with `user:`:

```zsh
units='sshd nginx user:syncthing'
```


## 🧩 Widgets

A widget is a pane that refreshes itself every few seconds. Each works on
both macOS and Linux and leaves out whatever it can't find.

| Widget | Shows | Refreshes |
|---|---|---|
| `sysinfo` | User and host, OS and kernel, uptime and load | 30s |
| `net` | Connection status (green up, red down), interface, IPv4 and IPv6, Wi-Fi name, router and its hostname, DNS servers, firewall | 10s |
| `updates` | Pending package updates from brew (macOS) or apt (Debian, Ubuntu) | 1h |
| `disk` | Usage of the real filesystems, skipping system and pseudo ones | 30s |
| `ports` | Listening TCP ports, with the address and process for each | 10s |
| `services` | macOS: brew services and their status. Linux: every running user service with its description, failed units in red, and the system units you choose to watch | 30s |
| `containers` | Podman containers, running (green) or stopped (red), with their ports | 10s |

Every widget is also a plain script, so you can run one for a quick look:

```sh
~/.config/tmux/widgets/ports
```

### Good to know

- **Wi-Fi name on macOS:** macOS hides it from tools that don't have location
  access, so `net` shows "(hidden by macOS)".
- **Ports and permissions:** without root, macOS only lists your own
  processes, and Linux shows `-` for processes owned by other users.
- **apt freshness:** refreshing apt's package list needs root, so `updates`
  shows how old the list is instead (e.g. `index 5h old`). brew refreshes
  its own list about once a day.


## ✏️ Making your own

### A layout

A layout is a zsh script in `layouts/`. Its first line is the description
the picker shows. It builds the window with a few functions named after the
tmux commands they wrap:

| Function | Does |
|---|---|
| `split-window [-T title] [-t title] [flags] <command>` | Adds a pane running the command. The first one fills the window. Later ones split beside the previous pane, or beside the pane titled with `-t`. Other flags (`-h`, `-v`, `-b`, `-l size`, `-c dir`, `-e var=val`) go to tmux |
| `widget <name> [-n seconds] [flags]` | Adds a widget pane. `-n` changes how often it refreshes; other flags are as for `split-window` |
| `select-layout <name>` | Arranges the panes: `tiled`, `even-horizontal`, `main-vertical`, ... |
| `set-option <option> <value>` | Sets a tmux option for this window |

Panes added without any flags are tiled evenly. Since a layout is ordinary
zsh, it can check the platform or whether a program is installed:

```zsh
# Dev: an editor with tests and a shell beside it

set-option pane-border-status top
split-window -T editor vim
split-window -T tests -h -l 40% 'npm test -- --watch'
split-window -T shell -v zsh
(( $+commands[podman] )) && widget containers -t shell -v -l 8
```

A pane whose command fails stays open so you can see the error.

### A widget

A widget is an executable script in `widgets/` that prints a snapshot and
exits. The launcher reruns it under `watch`, which handles the refreshing
and redrawing. Colour codes are kept. A `# refresh: N` line sets how many
seconds to wait between runs (10 by default):

```zsh
#!/usr/bin/env zsh
# Logged-in users.
# refresh: 60

who
```

Make it executable (`chmod +x`) and add it to a layout with
`widget <name>`. Settings can be passed as environment variables with
`-e`, the way `services` reads `SERVICES_UNITS`.
