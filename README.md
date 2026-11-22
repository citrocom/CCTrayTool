# CCTrayTool

**KeepAwake · AlwaysOnTop · ToolTime quick start** – a small, free tray tool for Windows.

**English** · [Deutsch](docs/README.de.md) · [Italiano](docs/README.it.md) · [Español](docs/README.es.md) · [Français](docs/README.fr.md) · [Polski](docs/README.pl.md) · [Magyar](docs/README.hu.md) · [Русский](docs/README.ru.md)

## Overview

CCTrayTool is a small Windows tool that runs as an icon in the system tray (bottom right, next to the clock). It combines three useful functions in one program:

1. **KeepAwake** – prevents the PC from entering power-saving mode or the screen from turning off
2. **AlwaysOnTop** – keeps any window in the foreground using a keyboard shortcut
3. **Tools Quick Start** – launches frequently used programs directly from the tray menu

All functions are operated via a right-click menu on the tray icon. No installation is required; the program can be started directly.

CCTrayTool supports the languages English, German, Italian, Spanish, French, Polish, Hungarian, and Russian. The language is set automatically based on the computer's system language.

System requirement: A 64-bit version of Windows 10 or newer is required. The program does not run on 32-bit Windows.

## Download

Compiled and code-signed versions are published on the [Releases](../../releases/latest) page of this
repository. Download `CCTrayTool.exe`, copy it to any folder and start it – there is nothing to install.
Next to the program, every release contains a `.sha256` file with the checksum of the download.

CCTrayTool keeps its settings, the log file and the ToolTime folder in `%LocalAppData%\CCTrayTool`
(see section 7 of the user guide). The program does not write anywhere else.

## User guide

### 1. Starting and the first icon

After starting, an icon appears in the tray area of the Windows taskbar. The color of the icon immediately shows the current KeepAwake status:

- White = KeepAwake disabled (normal Windows behavior)
- Red = KeepAwake active for monitors
- Blue = KeepAwake active for system
- Green = KeepAwake active for monitors and system

A right-click on the icon opens the menu with all functions. If the icon is not visible, check the "hidden icons" area (small arrow in the taskbar).

Note: CCTrayTool can only be started once at a time. Starting it a second time has no effect if the program is already running.

### 2. KeepAwake - preventing power saving

In the "KeepAwake" menu section, you can select what the PC should NOT do while CCTrayTool is running:

- **Monitors and System**: Neither does the screen turn off, nor does the PC enter standby/power-saving mode. Ideal for presentations or long-running processes where the screen needs to stay visible.
- **Monitors**: Only the screen stays on (no turning off, no screen saver). The PC itself can still enter standby after its own timeout.
- **System**: The PC does not enter standby/power-saving mode, but the screen can still turn off according to the Windows setting. Useful, for example, for long downloads or background calculations.
- **Disabled**: CCTrayTool does not intervene; normal Windows power-saving behavior applies.

The "Save Status" menu item makes CCTrayTool remember the last selected KeepAwake setting and automatically restore it on the next start.

When CCTrayTool is closed, normal Windows power-saving behavior is automatically restored.

### 3. AlwaysOnTop - keeping a window in the foreground

The keyboard shortcut SHIFT + ALT + T (default) permanently keeps the currently active window in the foreground - even when other windows are clicked. Pressing it again removes this pinning.

When toggling, a small notification briefly appears near the mouse cursor, confirming whether the window now "stays in the foreground" or is "back to normal". This notification can be turned on or off via the "Show ToolTip" menu item.

The "AlwaysOnTop" menu offers the following options:

- **Hotkey Active**: Turns the keyboard shortcut on or off completely
- **Change Hotkey**: Opens a dialog where a custom keyboard shortcut can be defined (a combination of Ctrl, Alt, Shift, Win plus a letter, a number, or a function key F1-F12)
- **Show ToolTip**: Turns the brief on-screen notification on or off when toggling

Note: The Windows desktop itself ("Program Manager") cannot be set to "always on top". Not every keyboard combination is available - some are already reserved by the system or other programs. In this case, a notice appears and a different combination must be chosen.

### 4. Quick start menu for your own programs

Above KeepAwake, the tray menu shows the "ToolTime" section: a list of programs that can be started with a single click. The entries come from a folder on your PC (see Section 5): every shortcut (`.lnk` file) in this folder becomes a menu entry and every sub folder becomes a submenu.

By default, several Windows built-in tools are already set up, including:

- Calculator, Notepad (folder "Office")
- Explorer (directly in the main menu)
- Command Prompt, Registry Editor, Network Settings, Control Panel, Resource Monitor, Performance Monitor, Manage Services, Disk Cleanup (folder "System")

Shortcuts whose program cannot be found on the respective PC automatically do not appear in the menu - so no error message occurs if a tool is missing on a system.

Some entries (e.g., Command Prompt, Registry Editor) are set up to start automatically with administrator rights (in this case, Windows asks for confirmation via User Account Control).

### 5. Adding your own tools and folders

The tools in the quick start menu are simply shortcuts in a folder. To add a tool, select "Open ToolTime Folder" in the "Settings" menu and place a shortcut (`.lnk` file) in the folder that opens. CCTrayTool notices the change by itself and updates the tray menu a moment later. (If this does not happen, use "Reload Tools" in the "Settings" menu.)

A quick way to create a shortcut: drag a program into the folder with the right mouse button and choose "Create shortcuts here".

Default folder: `%LocalAppData%\CCTrayTool\ToolTime` (Another folder can be set in the settings file, see below.)

When CCTrayTool creates the ToolTime folder, it also places a short information file in it ("`ToolTime_Info.txt`", in the language of the system). It briefly explains the limits and how to sort entries with a leading number. The menu ignores the file; it can be deleted at any time.

How the folder is turned into a menu:

- **Shortcut (`.lnk`)**: becomes a menu entry. The name is the file name; the icon is the icon of the shortcut (or, if it has none, of the program it points to).
- **Sub folder**: becomes a submenu. Its icon can be changed in Windows Explorer as usual (Properties > Customize > Change Icon).
- **Order**: Folders come first, then shortcuts, each sorted alphabetically. To set your own order, start the name with two or three digits and an underscore, e.g. "`01_Notepad.lnk`". The number is only used for sorting and is not shown.
- **Administrator**: Enable "Run as administrator" in the properties of the shortcut (Shortcut > Advanced). Windows then asks for confirmation when the entry is started.
- **Not shown**: Hidden files, files that are not shortcuts, shortcuts whose program does not exist, and empty folders.

Limits - so that the menu stays usable:

A tray menu cannot be scrolled with the mouse wheel, only with two small arrow buttons, and a long menu would push KeepAwake, AlwaysOnTop and the settings out of view. Therefore:

- A maximum of 15 entries (folders and shortcuts together) is shown per menu. This limit can be changed in the settings file to a value between 10 and 20 (see below).
- A maximum of 3 menu levels: the ToolTime menu plus two levels of submenus. Deeper folders are ignored.
- A maximum of 400 entries in total.

Tip: sort many tools into sub folders instead of one long list.

If a limit is exceeded, nothing is lost silently:

- The surplus entries are not shown. Instead, the menu contains a grayed-out line such as "... 3 more not shown (limit 15)".
- A notification appears, and the ToolTime section shows the entry "(!) ToolTime: problems found - click for details". Clicking it lists exactly what was ignored and why. The same information is written to the log file (if "Create Logfile" is turned on).
- Folders nested too deeply and shortcuts that cannot be read are reported in the same way.

Settings in the settings file (section `[ToolTime]`):

```ini
[ToolTime]
Enabled=1
MaxEntries=15
Folder=
```

- `Enabled`: 1 = show ToolTime, 0 = hide it (same as the menu item "Enable ToolTime")
- `MaxEntries`: Maximum number of entries per menu, 10 to 20 (default: 15). Other values are corrected automatically.
- `Folder`: Optional: path of another ToolTime folder. Environment variables such as `%USERPROFILE%` are allowed. Empty = default folder. If the folder does not exist, it is created.

To edit the file, select "Edit Settings File" in the "Settings" menu. After saving and closing Notepad, CCTrayTool reads the file again, applies all changes immediately (no restart needed) and rebuilds the tray menu.

Restoring the default tools: exit CCTrayTool, delete the ToolTime folder and start the program again - the default tools and the information file are created anew.

### 6. Additional settings

The "Settings" submenu also offers:

- **Enable ToolTime**: Turns the entire tool quick-start section (see Section 4) on or off. When turned off, none of its entries appear in the tray menu, no matter what is in the ToolTime folder.
- **Open ToolTime Folder**: Opens the ToolTime folder in Windows Explorer, so that shortcuts can be added, renamed or removed (see Section 5).
- **Reload Tools**: Reads the ToolTime folder again and rebuilds the menu. Normally not necessary, as changes in the folder are detected automatically.
- **Enable KeepAwake**: Turns the entire KeepAwake section (see Section 2) on or off. When turned off, its entries disappear from the tray menu and normal Windows power-saving behavior applies.
- **Enable AlwaysOnTop**: Turns the entire AlwaysOnTop section (see Section 3) on or off. When turned off, its entries disappear from the tray menu and the keyboard shortcut is deactivated.
- **Start Automatically**: CCTrayTool will start automatically at Windows logon in the future.
- **Create Logfile**: Writes a detailed log of all actions to a log file. Helpful for troubleshooting, not required during normal operation. In the settings file this is the entry "`UseLog`" in the `[Main]` section: 1 = on; 0, an empty or missing entry, or any other value = off.
- **View Logfile**: Opens the current log file in Notepad.
- **Use Large Icons**: Displays the icons in the tray menu larger (32 instead of 16 pixels).
- **Edit Settings File**: Opens the configuration file directly for editing (see Section 5).

### 7. Storage locations

CCTrayTool stores its files in the user profile:

- **Configuration:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Logfile:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **ToolTime folder:** `%LocalAppData%\CCTrayTool\ToolTime\`

(The path can be pasted into Windows Explorer's address bar to go directly to the folder.)

### 8. Closing the program

CCTrayTool is closed via the "Exit" menu item. This automatically restores normal Windows power-saving behavior and saves the current configuration.

### 9. About / Contact

The currently installed version can be viewed at any time via the "About" menu item.

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

License: GNU General Public License, version 3 or later (GPL-3.0-or-later), with an additional attribution term; see the files [LICENSE](LICENSE) and [NOTICE](NOTICE).

## Build from source

The program is written in [AutoIt](https://www.autoitscript.com). How to compile it, sign it and publish a
release is described in [docs/BUILDING.md](docs/BUILDING.md).

## License

CCTrayTool is free software: you can redistribute it and/or modify it under the terms of the
[GNU General Public License](LICENSE) as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version (SPDX identifier: `GPL-3.0-or-later`).

In short: you may use the program for any purpose, study how it works, change it and pass it on – changed or
not – as long as you pass it on under the same license, make the source code available and name the project
and its author.

The last point is the *additional term under section 7(b) of the GPL* that is written down in the file
[NOTICE](NOTICE): the copyright notice and the attribution to the author and the project must be preserved,
also in the "About" dialog of the program. The NOTICE file also lists the third-party components.

This program comes with ABSOLUTELY NO WARRANTY; see the license for details.

## About this project

Parts of this project were created with AI assistance: the tray icon artwork, the translations into the
supported languages, the README, and portions of the AutoIt source code (including debugging and cleanup
work) were produced or refined with the help of an AI assistant. The author is responsible for the result.

Author: Markus Debus – [info@markus-debus.de](mailto:info@markus-debus.de)
