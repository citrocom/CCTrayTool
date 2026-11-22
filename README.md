# CCTrayTool

**KeepAwake · AlwaysOnTop · ToolTime · CloseGuard** – a small, free tray tool for Windows.

**English** · [Deutsch](docs/README.de.md) · [Italiano](docs/README.it.md) · [Español](docs/README.es.md) · [Français](docs/README.fr.md) · [Polski](docs/README.pl.md) · [Magyar](docs/README.hu.md) · [Русский](docs/README.ru.md)

## Overview

CCTrayTool is a small Windows tool that runs as an icon in the system tray (bottom right, next to the clock). It combines four useful functions in one program:

1. **KeepAwake** – prevents the PC from entering power-saving mode or the screen from turning off
2. **AlwaysOnTop** – keeps any window in the foreground using a keyboard shortcut
3. **Tools Quick Start** – launches frequently used programs directly from the tray menu
4. **CloseGuard** – locks the close button (X) of selected windows, by keyboard shortcut or by rules

All functions are operated via a right-click menu on the tray icon. No installation is required; the program can be started directly.

CCTrayTool supports the languages English, German, Italian, Spanish, French, Polish, Hungarian, and Russian. The language is set automatically based on the computer's system language.

System requirement: A 64-bit version of Windows 10 or newer is required. The program does not run on 32-bit Windows.

## Download

Compiled and code-signed versions are published on the [Releases](../../releases/latest) page of this
repository. Download the ZIP file (for example `CCTrayTool_2026.0.0.109.zip`), unpack it into any folder and
start `CCTrayTool.exe` – there is nothing to install. The ZIP file contains the program, the user guide
(`README.txt`), the license (`LICENSE`, `NOTICE`) and a note about the source code.

Every release also contains a `.sha256` file with the checksum of the ZIP file. To check your download,
compare it with the result of `Get-FileHash .\CCTrayTool_2026.0.0.109.zip` in PowerShell.

CCTrayTool keeps its settings, the log file and the ToolTime folder in `%LocalAppData%\CCTrayTool`
(see section 8 of the user guide). The program does not write anywhere else.

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

The "Save Status" menu item in the "Settings" submenu of the KeepAwake section makes CCTrayTool remember the last selected KeepAwake setting and automatically restore it on the next start.

When CCTrayTool is closed, normal Windows power-saving behavior is automatically restored.

### 3. AlwaysOnTop - keeping a window in the foreground

The keyboard shortcut SHIFT + ALT + T (default) permanently keeps the currently active window in the foreground - even when other windows are clicked. Pressing it again removes this pinning.

When toggling, a small notification briefly appears near the mouse cursor, confirming whether the window now "stays in the foreground" or is "back to normal". This notification can be turned on or off via the "Show ToolTip" menu item.

The "AlwaysOnTop" menu offers the following options:

- **Hotkey Active**: Turns the keyboard shortcut on or off completely
- **Settings**: Submenu (gear icon) with the following entries:
  - **Change Hotkey**: Opens a dialog where a custom keyboard shortcut can be defined (a combination of Ctrl, Alt, Shift, Win plus a letter, a number, or a function key F1-F12)
  - **Show ToolTip**: Turns the brief on-screen notification on or off when toggling

Note: The Windows desktop itself ("Program Manager") cannot be set to "always on top". Not every keyboard combination is available - some are already reserved by the system or other programs. In this case, a notice appears and a different combination must be chosen.

### 4. CloseGuard - locking the close button

CloseGuard protects windows against being closed by accident. For the windows you choose, it locks the close button (the "X" at the top right of the window): the button is grayed out and a click on it does nothing. This is useful for programs that have to keep running, or for windows that keep getting closed by mistake.

A window can be locked in two ways:

- **By hand, with a keyboard shortcut**: Click the window, then press CTRL + ALT + X (default). The close button of this window is now locked. Pressing the shortcut again releases it. A window released this way stays free, even if a rule matches, until it is closed. A short notification confirms each change. The lock lasts until the window is closed or released.
- **Automatically, with rules**: Click the window, then press CTRL + ALT + SHIFT + X (default). CCTrayTool saves a rule made of the window title and the window class in the rules file and locks the window. From then on, every window that matches the rule is locked automatically as soon as it appears - also after the program or CCTrayTool has been restarted.

In the tray menu, the "CloseGuard" section offers these entries:

- **Lock/unlock the close button of the active window**: Does the same as the first shortcut. While the tray menu is open it has the focus itself, so CloseGuard uses the window that was active just before.
- **Create rule for the active window**: Does the same as the second shortcut.
- **Show locked windows**: Shows which windows are locked at the moment (by rule or by hand, with the window class in square brackets) and how many rules exist.

Below them, the submenu "Settings" (gear icon) contains:

- **Check new windows automatically**: On: CloseGuard keeps watching and locks every new window that matches a rule. Off: new windows are not locked automatically.
- **Check windows open at program start**: On: windows that are already open when CCTrayTool starts are checked against the rules right away. Off: these windows are left alone; only windows opened later are checked.
- **Minimize window when locked X is clicked**: On: a click on the grayed-out close button minimizes the window instead of doing nothing. As with a real button, the window is minimized only if the mouse button is released on the X as well; pressing the button and moving away cancels the click. Off (default): a click does nothing.
- **Change hotkey: lock/unlock** / **Change hotkey: create rule**: Opens the same dialog as for AlwaysOnTop, to define another keyboard shortcut. A combination that another function of CCTrayTool already uses is refused.
- **Edit rules...**: Opens the rules file in Notepad (see below). After saving and closing Notepad, the changed rules are applied at once: windows locked by a rule that no longer matches are released, and new rules are applied to the open windows.

CloseGuard as a whole can be turned on and off with "Enable CloseGuard" in the "Settings" menu of the "CCTrayTool" section (see Section 7).

Rules (own file `CloseGuardRules.ini`, section `[Rules]`):

The rules are not kept in the settings file but in a file of their own: `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`. It is created automatically. It is a Unicode file, so window titles with umlauts or other special characters work. Notepad keeps this format; if you edit the file with another program, save it as Unicode (UTF-16) as well, otherwise special characters may be lost. The rules are read again when Notepad is closed after "Edit rules..." and at every start of CCTrayTool.

Each line is one rule in the form `number=title|class`. The title is a text that must appear somewhere in the window title. The class is the technical name of the window type and must match exactly. Upper and lower case do not matter. One of the two parts may be empty (the "|" must stay); if both are filled in, both must match. Examples:

- `1=Calculator|`: every window with "Calculator" in its title
- `2=|Notepad`: every window of the class "Notepad"
- `3=Untitled|Notepad`: windows of the class "Notepad" with "Untitled" in the title

The shortcut "create rule" uses the complete current title of the window. If the title changes (for example with the name of an open document), shorten it afterwards with "Edit rules..." to the part that stays the same, or leave the title empty and keep only the class. The class of a locked window is shown by "Show locked windows". A rule with an empty title and an empty class is ignored; at most 200 rules are used.

Settings in the settings file (section `[CloseGuard]`):

```ini
[CloseGuard]
Enabled=1
HotkeyToggle=^!x
HotkeyAddRule=^!+x
ApplyOnStartup=1
AutoApply=1
PollInterval=500
MinimizeOnClick=0
ClickPollInterval=30
ClickGeometryFallback=1
ClickGeometryExtendLeft=0
ClickGeometryExtendDown=87
ClickDebugOverlay=0
ClickShieldClasses=Chrome_WidgetWin_1,MozillaWindowClass
```

- `Enabled`: 1 = CloseGuard on, 0 = off (same as the menu item "Enable CloseGuard").
- `HotkeyToggle`: Keyboard shortcut for lock/unlock. `^` = Ctrl, `!` = Alt, `+` = Shift, `#` = Win, followed by the key. It is easier to change it with the menu item "Change hotkey".
- `HotkeyAddRule`: Keyboard shortcut for "create rule".
- `ApplyOnStartup`: 1 = windows that are open at program start are checked against the rules, 0 = they are left alone.
- `AutoApply`: 1 = new windows are checked automatically, 0 = not.
- `PollInterval`: How often the windows are checked, in milliseconds: 250 to 5000 (default: 500). Other values are corrected automatically.
- `MinimizeOnClick`: 1 = a click on the locked close button minimizes the window, 0 = it does nothing (default). Same as the menu item.
- `ClickPollInterval`: How often the mouse button is checked for this, in milliseconds: 10 to 100 (default: 30). A smaller value notices very short clicks more reliably, a larger one needs less computing time. Other values are corrected automatically. There is no menu item for this setting.
- `ClickGeometryFallback`: 1 = if a window with its own title bar (for example Outlook) does not report its X to Windows, the X is recognized by its position (default). 0 = only an X that the window reports itself is recognized.
- `ClickGeometryExtendLeft`: How far the area in which the X is recognized by its position reaches to the left, in percent of the width of the X: 0 to 100 (default: 0). Some programs draw their X further left than Windows reports. A value that is too large reaches into the neighbouring maximize button.
- `ClickGeometryExtendDown`: How far that area reaches downwards, in percent of the height of the X: 0 to 100 (default: 87). Some programs draw their X lower than Windows reports. Same purpose and same limits as `ClickGeometryExtendLeft`.
- `ClickDebugOverlay`: 1 = shows the areas that are used to recognize the X as colored, transparent rectangles on the screen: red = the area in which a click counts as a click on the X, blue = the close button area that Windows reports (or, if Windows reports none, the X area that was found by asking the window), green = the shield over the X (see `ClickShieldClasses`). Only for troubleshooting. 0 = off (default).
- `ClickShieldClasses`: Window classes (separated by commas) of programs that close themselves when the mouse button is released, for example Edge and Chrome (`Chrome_WidgetWin_1`) and Firefox (`MozillaWindowClass`). Default: both. The X of such a window is covered by an almost invisible window that takes the click, so the window cannot be closed with the X. Empty = none.

The two CloseGuard shortcuts and the AlwaysOnTop shortcut must differ from each other. If they do not, the default shortcuts are used instead.

Good to know:

- The lock protects against clicking the X by mistake. Depending on the program, a window can still be closed in other ways: with ALT + F4, with "Close window" in the taskbar, with an Exit command in the program's own menu or with the Task Manager.
- Only windows with a normal title bar and system menu can be locked. Programs that draw their own title bar (many modern apps, some browsers, apps from the Microsoft Store) may keep a working X even though CloseGuard reports the window as locked. If a window has no system menu at all, a notice appears.
- Minimize on click: CCTrayTool checks the mouse button briefly and regularly (default: every 30 ms), and only while at least one locked window is visible. It does not use a mouse hook, so it cannot slow down the mouse or the system. In the unlikely case that a very short click falls into a moment in which CCTrayTool is busy, it is simply not noticed: the window stays as it is and its X stays locked.
- Minimize on click reacts to the primary mouse button (the right one if the buttons are swapped in Windows) and only to the X of locked windows. Touch and pen input are not detected. If a program ignores the minimize command, CCTrayTool minimizes the window directly.
- Some programs draw their own title bar (for example Outlook). They do not tell Windows where their X is, so for the click detection CCTrayTool works out the position of the X in the top right corner of the window (INI key `ClickGeometryFallback`). The log file then says "recognized by its position".
- Edge, Chrome and other Chromium programs and Firefox draw their own X and close the window themselves when the mouse button is released, so the locked system menu cannot stop them. For such windows (INI key `ClickShieldClasses`, default `Chrome_WidgetWin_1,MozillaWindowClass`) CCTrayTool puts an almost invisible window, a shield, over the X. The click lands on the shield and the program never sees it: nothing happens, or the window is minimized if minimizing on click is on. The shield follows the window and is gone while the window is minimized, unlocked, fullscreen or covered by another window at its X. With `ClickDebugOverlay=1` it is shown in green. While a window of such a class is visible, the mouse button is checked every 10 ms, even if minimizing on click is off. Firefox draws its title bar itself and Windows reports no position for its X, so CCTrayTool finds the X by asking the window (log file: "found by asking the window"). The position fallback (`ClickGeometryFallback`) is only used for windows that do not report their X to Windows, such as Outlook and Word; CCTrayTool asks each window once and writes the result to the log file ("probe of the X").
- Windows of programs that run as administrator cannot be locked as long as CCTrayTool does not run as administrator itself (a Windows security rule). A notice appears.
- The desktop, the taskbar and the windows of CCTrayTool itself are never locked.
- When a window is released, its system menu is reset to the Windows default. Entries that the program itself added to this menu may be missing until the program is restarted.
- A lock lasts only while CCTrayTool is running: when the program is closed or CloseGuard is turned off, all windows get their close button back. If CCTrayTool is ended forcibly (for example with the Task Manager), locked windows stay locked. Then press the lock/unlock shortcut in such a window (CCTrayTool must be running again), or close the window and open it again.

### 5. Quick start menu for your own programs

Above KeepAwake, the tray menu shows the "ToolTime" section: a list of programs that can be started with a single click. The entries come from a folder on your PC (see Section 6): every shortcut (`.lnk` file) in this folder becomes a menu entry and every sub folder becomes a submenu.

By default, several Windows built-in tools are already set up, including:

- Calculator, Notepad (folder "Office")
- Explorer (directly in the main menu)
- Command Prompt, Registry Editor, Network Settings, Control Panel, Resource Monitor, Performance Monitor, Manage Services, Disk Cleanup (folder "System")

Shortcuts whose program cannot be found on the respective PC automatically do not appear in the menu - so no error message occurs if a tool is missing on a system.

Some entries (e.g., Command Prompt, Registry Editor) are set up to start automatically with administrator rights (in this case, Windows asks for confirmation via User Account Control).

### 6. Adding your own tools and folders

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

### 7. Additional settings

The "Settings" submenu also offers:

- **Enable ToolTime**: Turns the entire tool quick-start section (see Section 5) on or off. When turned off, none of its entries appear in the tray menu, no matter what is in the ToolTime folder.
- **Open ToolTime Folder**: Opens the ToolTime folder in Windows Explorer, so that shortcuts can be added, renamed or removed (see Section 6).
- **Reload Tools**: Reads the ToolTime folder again and rebuilds the menu. Normally not necessary, as changes in the folder are detected automatically.
- **Enable KeepAwake**: Turns the entire KeepAwake section (see Section 2) on or off. When turned off, its entries disappear from the tray menu and normal Windows power-saving behavior applies.
- **Enable AlwaysOnTop**: Turns the entire AlwaysOnTop section (see Section 3) on or off. When turned off, its entries disappear from the tray menu and the keyboard shortcut is deactivated.
- **Enable CloseGuard**: Turns the entire CloseGuard section (see Section 4) on or off. When turned off, its entries disappear from the tray menu, its keyboard shortcuts are deactivated and all locked windows get their close button back.
- **Start Automatically**: CCTrayTool will start automatically at Windows logon in the future.
- **Create Logfile**: Writes a detailed log of all actions to a log file. Helpful for troubleshooting, not required during normal operation. In the settings file this is the entry "`UseLog`" in the `[Main]` section: 1 = on; 0, an empty or missing entry, or any other value = off.
- **View Logfile**: Opens the current log file in Notepad.
- **Use Large Icons**: Displays the icons in the tray menu larger (32 instead of 16 pixels).
- **Edit Settings File**: Opens the configuration file directly for editing (see Section 6).

### 8. Storage locations

CCTrayTool stores its files in the user profile:

- **Configuration:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Logfile:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **ToolTime folder:** `%LocalAppData%\CCTrayTool\ToolTime\`
- **CloseGuard rules:** `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`

(The path can be pasted into Windows Explorer's address bar to go directly to the folder.)

### 9. Closing the program

CCTrayTool is closed via the "Exit" menu item. This automatically restores normal Windows power-saving behavior and saves the current configuration.

All windows whose close button is locked by CloseGuard get their close button back when the program is closed.

### 10. About / Contact

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
