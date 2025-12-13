#!/usr/bin/env python3
import argparse
import os
import socket
from pathlib import Path

HOME = str(Path.home())
CONFIG_BASE = f"{HOME}/.config"
HOSTNAME = socket.gethostname()

# Map for registering target handlers. Each target handler is a function that takes
# a mode ('light' or 'dark') as it's first argument.
TARGET_HANDLERS = {}

# ========================= HANDLERS =========================
# The foot config file should be set to load a theme file with the name "colors-dark.ini" or
# "colors-light.ini", each of which is a symlink to the actual theme file for that mode.
# Switching the theme consists of replacing the string "colors-dark.ini" with "colors-light.ini"
# or the other way around in foot.ini. To change the actual backing theme, the symlink
# should be updated to point to the new theme file.
FOOT_CONF       = f"{CONFIG_BASE}/foot/foot.ini"
FOOT_DARK       = "colors-dark.ini"
FOOT_LIGHT      = "colors-light.ini"
def switch_foot_colors(mode: str) -> bool:
    did_change = False
    foot_conf = FOOT_CONF
    if not os.path.exists(foot_conf):
        print(f"Error: Foot config file {foot_conf} does not exist.")
        return

    cdata = ""
    with open(foot_conf, "r") as cfile:
        cdata = cfile.read()

    # dark -> light
    if mode == "dark" and FOOT_LIGHT in cdata:
        new_conf = cdata.replace(FOOT_LIGHT, FOOT_DARK)
        with open(foot_conf, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched foot colors from {FOOT_LIGHT} -> {FOOT_DARK}")
        did_change = True
    # light -> dark
    if mode == "light" and FOOT_DARK in cdata:
        new_conf = cdata.replace(FOOT_DARK, FOOT_LIGHT)
        with open(foot_conf, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched foot colors from {FOOT_DARK} -> {FOOT_LIGHT}")
        did_change = True
    return did_change
TARGET_HANDLERS['foot'] = switch_foot_colors

# Current sway setup uses host-specific config snippet in config.d/<hostname>.config and this is
# where the active theme for that host is defined via include. The sway config directory is expected
# to contain two theme files, "colors.dark-mode" and "colors.light-mode", which are symlinks to
# the actual theme files for dark and light mode, respectively. The switch consists of rewriting
# the host config file to replace the string "colors.light-mode" with "colors.dark-mode" and vice versa.
# Note that the config file must start out with one of the defined dark/light themes used in the
# checks for this to work.
SWAY_HOST_CONFIG = f"{CONFIG_BASE}/sway/config.d/{HOSTNAME}.config"
SWAY_DARK = "colors.dark-mode"
SWAY_LIGHT = "colors.light-mode"
def switch_sway_colors(mode: str) -> bool:
    if os.path.exists(SWAY_HOST_CONFIG) is False:
        print(f"Error: Sway host config file {SWAY_HOST_CONFIG} does not exist.")
        return
    cfile = open(SWAY_HOST_CONFIG, "r")
    cdata = cfile.read()
    did_change = False

    # dark -> light
    if mode == "dark" and SWAY_LIGHT in cdata:
        new_conf = cdata.replace(SWAY_LIGHT, SWAY_DARK)
        with open(SWAY_HOST_CONFIG, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched sway colors from {SWAY_LIGHT} -> {SWAY_DARK}")
        did_change = True
    # light -> dark
    if mode == "light" and SWAY_DARK in cdata:
        new_conf = cdata.replace(SWAY_DARK, SWAY_LIGHT)
        with open(SWAY_HOST_CONFIG, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched sway colors from {SWAY_DARK} -> {SWAY_LIGHT}")
        did_change = True

    if did_change:
        print("WARN: Sway must be reloaded for changes to take effect.")
    return did_change
TARGET_HANDLERS['sway'] = switch_sway_colors

# The nvim config dir should be set up to contain the files "colors-light.lua" and "colors-dark.lua"
# under the lua/ directory; one of these should be imported by lua/*/colors.lua using require().
# Changing the active theme consists of rewriting colors.lua to replace the string "colors-light" with
# "colors-dark" or the other way around.
# Each of the color files should contain the actual color definitions for the light and dark themes
# (i.e. settings colorscheme, background, etc.). This means changing the backend themes doesn't require
# changing this script, just the color files.
VIM_COLOR_CONF  = f"{CONFIG_BASE}/nvim/lua/hyper/colors.lua"
VIM_DARK        = "colors-dark"
VIM_LIGHT       = "colors-light"
def switch_vim_colors(mode: str) -> bool:
    if mode not in ['light', 'dark']:
        print("Invalid mode. Use 'light' or 'dark'")
        return
    cfile = open(VIM_COLOR_CONF, "r")
    cdata = cfile.read()
    did_change = False

    # light -> dark
    if mode == "dark" and VIM_LIGHT in cdata:
        new_conf = cdata.replace(VIM_LIGHT, VIM_DARK)
        with open(VIM_COLOR_CONF, "w") as new_file:
            new_file.write(new_conf)
        print(f"rewrote {VIM_COLOR_CONF} from light -> dark")
        did_change = True
    # dark -> light
    if mode == "light" and VIM_DARK in cdata:
        # switch colorscheme
        new_conf = cdata.replace(VIM_DARK, VIM_LIGHT)
        with open(VIM_COLOR_CONF, "w") as new_file:
            new_file.write(new_conf)
        print(f"rewrote {VIM_COLOR_CONF} from dark -> light")
        did_change = True

    if did_change:
        print("NOTE: Only new instances of nvim will see the changes.")
    return did_change
TARGET_HANDLERS['nvim'] = switch_vim_colors

# The qutebrowser config file is expected to contain a line that sources one of the themes, either
# "colors-dark.py" for dark or "colors-light.py" for light, each of which is a symlink to the actual
# theme file. The switch consists of rewriting the config file to replace the string "colors-light.py"
# with "colors-dark.py" or the other way around. The backing theme can be changed by updating the
# symlink to point to the new theme file.
QUTE_CONFIG = f"{CONFIG_BASE}/qutebrowser/config.py"
QUTE_DARK = "colors-dark.py"
QUTE_LIGHT = "colors-light.py"
def switch_qutebrowser_colors(mode: str) -> bool:
    if not os.path.exists(QUTE_CONFIG):
        print(f"Error: Qutebrowser config file {QUTE_CONFIG} does not exist.")
        return

    cdata = ""
    with open(QUTE_CONFIG, "r") as cfile:
        cdata = cfile.read()

    did_change = False
    if mode == "dark" and QUTE_LIGHT in cdata:
        new_conf = cdata.replace(QUTE_LIGHT, QUTE_DARK)
        with open(QUTE_CONFIG, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched qutebrowser theme to {QUTE_DARK}")
        did_change = True
    elif mode == "light" and QUTE_DARK in cdata:
        new_conf = cdata.replace(QUTE_DARK, QUTE_LIGHT)
        with open(QUTE_CONFIG, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched qutebrowser theme to {QUTE_LIGHT}")
        did_change = True

    if did_change:
        print("NOTE: run ':config-source' in active sessions to load new theme.")
    return did_change
TARGET_HANDLERS['qute'] = switch_qutebrowser_colors

# Switch modes for fuzzel. The fuzzel config is expected to contain an include statement
# that points one of either "colors-dark.ini" or "colors-light.ini", each of which is a symlink
# to the actual theme file. The switch consists of rewriting the config file to replace the
# string dark with light and vice versa. The backing theme can be changed by updating the
# symlink to point to the new theme file.
FUZZEL_CONF = f"{CONFIG_BASE}/fuzzel/fuzzel.ini"
FUZZEL_DARK = "colors-dark.ini"
FUZZEL_LIGHT = "colors-light.ini"
def switch_fuzzel_colors(mode: str) -> bool:
    if not os.path.exists(FUZZEL_CONF):
        print(f"Error: Fuzzel config file {FUZZEL_CONF} does not exist.")
        return

    cdata = ""
    with open(FUZZEL_CONF, "r") as cfile:
        cdata = cfile.read()

    did_change = False
    if mode == "dark" and FUZZEL_LIGHT in cdata:
        new_conf = cdata.replace(FUZZEL_LIGHT, FUZZEL_DARK)
        with open(FUZZEL_CONF, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched fuzzel theme to {FUZZEL_DARK}")
        did_change = True
    elif mode == "light" and FUZZEL_DARK in cdata:
        new_conf = cdata.replace(FUZZEL_DARK, FUZZEL_LIGHT)
        with open(FUZZEL_CONF, "w") as new_file:
            new_file.write(new_conf)
        print(f"Switched fuzzel theme to {FUZZEL_LIGHT}")
        did_change = True
    return did_change
TARGET_HANDLERS['fuzzel'] = switch_fuzzel_colors

# Get the final list of supported targets based on the registered handlers
SUPPORTED_TARGETS = list(TARGET_HANDLERS.keys())

# Function to handle command line arguments
def handle_args():
    parser = argparse.ArgumentParser(description='light/dark theme switcher')

    # add argument to set light or dark mode
    parser.add_argument(
        'mode',
        choices=['light', 'dark'],
        help='Set the theme mode to light or dark'
    )

    # add argument to set target for the change
    parser.add_argument(
        '-t',
        action='append',
        dest='target',
        choices=SUPPORTED_TARGETS + ['all'],
        default=['all'],
        help='Set the target(s) for the change (default: all)'
    )

    args = parser.parse_args()
    targets = args.target
    if len(targets) == 1 and targets[0] == 'all':
        targets = TARGET_HANDLERS.keys()
    if len(targets) > 1 and 'all' in targets:
        targets.remove('all')

    args.target = targets
    return args

if __name__ == "__main__":
    args = handle_args()
    mode = args.mode
    targets = args.target

    print(f"Setting mode to {mode} for target(s): {', '.join(targets)}")
    for target in targets:
        if target not in TARGET_HANDLERS:
            print(f"Warning: Target '{target}' is not supported.")
            continue
        TARGET_HANDLERS[target](mode)

    print("Theme switch complete.")
