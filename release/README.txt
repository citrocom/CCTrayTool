===================================================================
 CCTrayTool - Multilingual User Guide / Mehrsprachige Anleitung
===================================================================

Note: This document contains the manual in 8 languages, one after
another. Use the list below to jump to your language.

Languages in this document:
  1. English
  2. Deutsch (German)
  3. Italiano (Italian)
  4. Español (Spanish)
  5. Français (French)
  6. Polski (Polish)
  7. Magyar (Hungarian)
  8. Русский (Russian)



===================================================================
 CCTrayTool - User Guide
===================================================================

CCTrayTool is a small Windows tool that runs as an icon in the
system tray (bottom right, next to the clock). It combines four
useful functions in one program:

  1. KeepAwake         - prevents the PC from entering power-saving
                          mode or the screen from turning off
  2. AlwaysOnTop        - keeps any window in the foreground using
                          a keyboard shortcut
  3. Tools Quick Start  - launches frequently used programs directly
                          from the tray menu
  4. CloseGuard         - locks the close button (X) of selected
                          windows, by keyboard shortcut or by rules

All functions are operated via a right-click menu on the tray icon.
No installation is required; the program can be started directly.

CCTrayTool supports the languages English, German, Italian,
Spanish, French, Polish, Hungarian, and Russian.
The language is set automatically based on the computer's system
language.

System requirement: A 64-bit version of Windows 10 or newer is
required. The program does not run on 32-bit Windows.

-------------------------------------------------------------------
 1. Starting and the first icon
-------------------------------------------------------------------

After starting, an icon appears in the tray area of the Windows
taskbar. The color of the icon immediately shows the current
KeepAwake status:

  - White = KeepAwake disabled (normal Windows behavior)
  - Red   = KeepAwake active for monitors
  - Blue  = KeepAwake active for system
  - Green = KeepAwake active for monitors and system

A right-click on the icon opens the menu with all functions. If the
icon is not visible, check the "hidden icons" area (small arrow in
the taskbar).

Note: CCTrayTool can only be started once at a time. Starting it a
second time has no effect if the program is already running.


-------------------------------------------------------------------
 2. KeepAwake - preventing power saving
-------------------------------------------------------------------

In the "KeepAwake" menu section, you can select what the PC should
NOT do while CCTrayTool is running:

  - Monitors and System
      Neither does the screen turn off, nor does the PC enter
      standby/power-saving mode. Ideal for presentations or long-
      running processes where the screen needs to stay visible.

  - Monitors
      Only the screen stays on (no turning off, no screen saver).
      The PC itself can still enter standby after its own timeout.

  - System
      The PC does not enter standby/power-saving mode, but the
      screen can still turn off according to the Windows setting.
      Useful, for example, for long downloads or background
      calculations.

  - Disabled
      CCTrayTool does not intervene; normal Windows power-saving
      behavior applies.

The "Save Status" menu item in the "Settings" submenu of the
KeepAwake section makes CCTrayTool remember the last selected
KeepAwake setting and automatically restore it on the next start.

When CCTrayTool is closed, normal Windows power-saving behavior is
automatically restored.


-------------------------------------------------------------------
 3. AlwaysOnTop - keeping a window in the foreground
-------------------------------------------------------------------

The keyboard shortcut SHIFT + ALT + T (default) permanently keeps
the currently active window in the foreground - even when other
windows are clicked. Pressing it again removes this pinning.

When toggling, a small notification briefly appears near the mouse
cursor, confirming whether the window now "stays in the foreground"
or is "back to normal". This notification can be turned on or off
via the "Show ToolTip" menu item.

The "AlwaysOnTop" menu offers the following options:

  - Hotkey Active   Turns the keyboard shortcut on or off
                    completely
  - Settings        Submenu (gear icon) with the following entries:
      - Change Hotkey   Opens a dialog where a custom keyboard
                        shortcut can be defined (a combination of
                        Ctrl, Alt, Shift, Win plus a letter, a
                        number, or a function key F1-F12)
      - Show ToolTip    Turns the brief on-screen notification on
                        or off when toggling

Note: The Windows desktop itself ("Program Manager") cannot be set
to "always on top". Not every keyboard combination is available -
some are already reserved by the system or other programs. In this
case, a notice appears and a different combination must be chosen.


-------------------------------------------------------------------
 4. CloseGuard - locking the close button
-------------------------------------------------------------------

CloseGuard protects windows against being closed by accident. For
the windows you choose, it locks the close button (the "X" at the
top right of the window): the button is grayed out and a click on
it does nothing. This is useful for programs that have to keep
running, or for windows that keep getting closed by mistake.

A window can be locked in two ways:

  - By hand, with a keyboard shortcut
      Click the window, then press CTRL + ALT + X (default). The
      close button of this window is now locked. Pressing the
      shortcut again releases it. A window released this way stays
      free, even if a rule matches, until it is closed. A short
      notification confirms each change. The lock lasts until the
      window is closed or released.

  - Automatically, with rules
      Click the window, then press CTRL + ALT + SHIFT + X
      (default). CCTrayTool saves a rule made of the window title
      and the window class in the rules file and locks the window.
      From then on, every window that matches the rule is locked
      automatically as soon as it appears - also after the program
      or CCTrayTool has been restarted.

In the tray menu, the "CloseGuard" section offers these entries:

  - Lock/unlock the close button of the active window
      Does the same as the first shortcut. While the tray menu is
      open it has the focus itself, so CloseGuard uses the window
      that was active just before.

  - Create rule for the active window
      Does the same as the second shortcut.

  - Show locked windows
      Shows which windows are locked at the moment (by rule or by
      hand, with the window class in square brackets) and how many
      rules exist.

Below them, the submenu "Settings" (gear icon) contains:

  - Check new windows automatically
      On: CloseGuard keeps watching and locks every new window that
      matches a rule. Off: new windows are not locked
      automatically.

  - Check windows open at program start
      On: windows that are already open when CCTrayTool starts are
      checked against the rules right away. Off: these windows are
      left alone; only windows opened later are checked.

  - Minimize window when locked X is clicked
      On: a click on the grayed-out close button minimizes the
      window instead of doing nothing. As with a real button, the
      window is minimized only if the mouse button is released on
      the X as well; pressing the button and moving away cancels
      the click. Off (default): a click does nothing.

  - Change hotkey: lock/unlock
    Change hotkey: create rule
      Opens the same dialog as for AlwaysOnTop, to define another
      keyboard shortcut. A combination that another function of
      CCTrayTool already uses is refused.

  - Edit rules...
      Opens the rules file in Notepad (see below). After saving and
      closing Notepad, the changed rules are applied at once:
      windows locked by a rule that no longer matches are released,
      and new rules are applied to the open windows.

CloseGuard as a whole can be turned on and off with "Enable
CloseGuard" in the "Settings" menu of the "CCTrayTool" section (see
Section 7).

Rules (own file CloseGuardRules.ini, section [Rules]):

The rules are not kept in the settings file but in a file of their
own: %LocalAppData%\CCTrayTool\CloseGuardRules.ini. It is created
automatically. It is a Unicode file, so window titles with umlauts
or other special characters work. Notepad keeps this format; if you
edit the file with another program, save it as Unicode (UTF-16) as
well, otherwise special characters may be lost. The rules are read
again when Notepad is closed after "Edit rules..." and at every
start of CCTrayTool.

Each line is one rule in the form  number=title|class.  The title
is a text that must appear somewhere in the window title. The class
is the technical name of the window type and must match exactly.
Upper and lower case do not matter. One of the two parts may be
empty (the "|" must stay); if both are filled in, both must match.
Examples:

  1=Calculator|       every window with "Calculator" in its title
  2=|Notepad          every window of the class "Notepad"
  3=Untitled|Notepad  windows of the class "Notepad" with
                      "Untitled" in the title

The shortcut "create rule" uses the complete current title of the
window. If the title changes (for example with the name of an open
document), shorten it afterwards with "Edit rules..." to the part
that stays the same, or leave the title empty and keep only the
class. The class of a locked window is shown by "Show locked
windows". A rule with an empty title and an empty class is ignored;
at most 200 rules are used.

Settings in the settings file (section [CloseGuard]):

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

  Enabled                  1 = CloseGuard on, 0 = off (same as the
                           menu item "Enable CloseGuard").
  HotkeyToggle             Keyboard shortcut for lock/unlock.
                           ^ = Ctrl, ! = Alt, + = Shift, # = Win,
                           followed by the key. It is easier to
                           change it with the menu item "Change
                           hotkey".
  HotkeyAddRule            Keyboard shortcut for "create rule".
  ApplyOnStartup           1 = windows that are open at program
                           start are checked against the rules,
                           0 = they are left alone.
  AutoApply                1 = new windows are checked
                           automatically, 0 = not.
  PollInterval             How often the windows are checked, in
                           milliseconds: 250 to 5000 (default:
                           500). Other values are corrected
                           automatically.
  MinimizeOnClick          1 = a click on the locked close button
                           minimizes the window, 0 = it does
                           nothing (default). Same as the menu
                           item.
  ClickPollInterval        How often the mouse button is checked
                           for this, in milliseconds: 10 to 100
                           (default: 30). A smaller value notices
                           very short clicks more reliably, a
                           larger one needs less computing time.
                           Other values are corrected
                           automatically. There is no menu item for
                           this setting.
  ClickGeometryFallback    1 = if a window with its own title bar
                           (for example Outlook) does not report
                           its X to Windows, the X is recognized by
                           its position (default). 0 = only an X
                           that the window reports itself is
                           recognized.
  ClickGeometryExtendLeft  How far the area in which the X is
                           recognized by its position reaches to
                           the left, in percent of the width of the
                           X: 0 to 100 (default: 0). Some programs
                           draw their X further left than Windows
                           reports. A value that is too large
                           reaches into the neighbouring maximize
                           button.
  ClickGeometryExtendDown  How far that area reaches downwards, in
                           percent of the height of the X: 0 to 100
                           (default: 87). Some programs draw their
                           X lower than Windows reports. Same
                           purpose and same limits as
                           ClickGeometryExtendLeft.
  ClickDebugOverlay        1 = shows the areas that are used to
                           recognize the X as colored, transparent
                           rectangles on the screen: red = the area
                           in which a click counts as a click on
                           the X, blue = the close button area that
                           Windows reports (or, if Windows reports
                           none, the X area that was found by
                           asking the window), green = the shield
                           over the X (see ClickShieldClasses).
                           Only for troubleshooting. 0 = off
                           (default).
  ClickShieldClasses       Window classes (separated by commas) of
                           programs that close themselves when the
                           mouse button is released, for example
                           Edge and Chrome (Chrome_WidgetWin_1) and
                           Firefox (MozillaWindowClass). Default:
                           both. The X of such a window is covered
                           by an almost invisible window that takes
                           the click, so the window cannot be
                           closed with the X. Empty = none.

The two CloseGuard shortcuts and the AlwaysOnTop shortcut must
differ from each other. If they do not, the default shortcuts are
used instead.

Good to know:

  - The lock protects against clicking the X by mistake. Depending
    on the program, a window can still be closed in other ways:
    with ALT + F4, with "Close window" in the taskbar, with an Exit
    command in the program's own menu or with the Task Manager.

  - Only windows with a normal title bar and system menu can be
    locked. Programs that draw their own title bar (many modern
    apps, some browsers, apps from the Microsoft Store) may keep a
    working X even though CloseGuard reports the window as locked.
    If a window has no system menu at all, a notice appears.

  - Minimize on click: CCTrayTool checks the mouse button briefly
    and regularly (default: every 30 ms), and only while at least
    one locked window is visible. It does not use a mouse hook, so
    it cannot slow down the mouse or the system. In the unlikely
    case that a very short click falls into a moment in which
    CCTrayTool is busy, it is simply not noticed: the window stays
    as it is and its X stays locked.

  - Minimize on click reacts to the primary mouse button (the right
    one if the buttons are swapped in Windows) and only to the X of
    locked windows. Touch and pen input are not detected. If a
    program ignores the minimize command, CCTrayTool minimizes the
    window directly.

  - Some programs draw their own title bar (for example Outlook).
    They do not tell Windows where their X is, so for the click
    detection CCTrayTool works out the position of the X in the top
    right corner of the window (INI key ClickGeometryFallback). The
    log file then says "recognized by its position".

  - Edge, Chrome and other Chromium programs and Firefox draw their
    own X and close the window themselves when the mouse button is
    released, so the locked system menu cannot stop them. For such
    windows (INI key ClickShieldClasses, default
    Chrome_WidgetWin_1,MozillaWindowClass) CCTrayTool puts an
    almost invisible window, a shield, over the X. The click lands
    on the shield and the program never sees it: nothing happens,
    or the window is minimized if minimizing on click is on. The
    shield follows the window and is gone while the window is
    minimized, unlocked, fullscreen or covered by another window at
    its X. With ClickDebugOverlay=1 it is shown in green. While a
    window of such a class is visible, the mouse button is checked
    every 10 ms, even if minimizing on click is off. Firefox draws
    its title bar itself and Windows reports no position for its X,
    so CCTrayTool finds the X by asking the window (log file:
    "found by asking the window"). The position fallback
    (ClickGeometryFallback) is only used for windows that do not
    report their X to Windows, such as Outlook and Word; CCTrayTool
    asks each window once and writes the result to the log file
    ("probe of the X").

  - Windows of programs that run as administrator cannot be locked
    as long as CCTrayTool does not run as administrator itself (a
    Windows security rule). A notice appears.

  - The desktop, the taskbar and the windows of CCTrayTool itself
    are never locked.

  - When a window is released, its system menu is reset to the
    Windows default. Entries that the program itself added to this
    menu may be missing until the program is restarted.

  - A lock lasts only while CCTrayTool is running: when the program
    is closed or CloseGuard is turned off, all windows get their
    close button back. If CCTrayTool is ended forcibly (for example
    with the Task Manager), locked windows stay locked. Then press
    the lock/unlock shortcut in such a window (CCTrayTool must be
    running again), or close the window and open it again.


-------------------------------------------------------------------
 5. Quick start menu for your own programs
-------------------------------------------------------------------

Above KeepAwake, the tray menu shows the "ToolTime" section: a list
of programs that can be started with a single click. The entries
come from a folder on your PC (see Section 6): every shortcut
(.lnk file) in this folder becomes a menu entry and every sub folder
becomes a submenu.

By default, several Windows built-in tools are already set up,
including:

  - Calculator, Notepad  (folder "Office")
  - Explorer  (directly in the main menu)
  - Command Prompt, Registry Editor, Network Settings, Control
    Panel, Resource Monitor, Performance Monitor, Manage Services,
    Disk Cleanup  (folder "System")

Shortcuts whose program cannot be found on the respective PC
automatically do not appear in the menu - so no error message
occurs if a tool is missing on a system.

Some entries (e.g., Command Prompt, Registry Editor) are set up to
start automatically with administrator rights (in this case,
Windows asks for confirmation via User Account Control).


-------------------------------------------------------------------
 6. Adding your own tools and folders
-------------------------------------------------------------------

The tools in the quick start menu are simply shortcuts in a folder.
To add a tool, select "Open ToolTime Folder" in the "Settings" menu
and place a shortcut (.lnk file) in the folder that opens.
CCTrayTool notices the change by itself and updates the tray menu a
moment later. (If this does not happen, use "Reload Tools" in the
"Settings" menu.)

A quick way to create a shortcut: drag a program into the folder
with the right mouse button and choose "Create shortcuts here".

Default folder:  %LocalAppData%\CCTrayTool\ToolTime
(Another folder can be set in the settings file, see below.)

When CCTrayTool creates the ToolTime folder, it also places a short
information file in it ("ToolTime_Info.txt", in the language of the
system). It briefly explains the limits and how to sort entries
with a leading number. The menu ignores the file; it can be deleted
at any time.

How the folder is turned into a menu:

  Shortcut (.lnk)  becomes a menu entry. The name is the file
                   name; the icon is the icon of the shortcut (or,
                   if it has none, of the program it points to).
  Sub folder       becomes a submenu. Its icon can be changed in
                   Windows Explorer as usual (Properties >
                   Customize > Change Icon).
  Order            Folders come first, then shortcuts, each sorted
                   alphabetically. To set your own order, start the
                   name with two or three digits and an underscore,
                   e.g. "01_Notepad.lnk". The number is only used
                   for sorting and is not shown.
  Administrator    Enable "Run as administrator" in the
                   properties of the shortcut (Shortcut >
                   Advanced). Windows then asks for confirmation
                   when the entry is started.
  Not shown        Hidden files, files that are not shortcuts,
                   shortcuts whose program does not exist, and
                   empty folders.

Limits - so that the menu stays usable:

A tray menu cannot be scrolled with the mouse wheel, only with two
small arrow buttons, and a long menu would push KeepAwake,
AlwaysOnTop and the settings out of view. Therefore:

  - A maximum of 15 entries (folders and shortcuts together) is
    shown per menu. This limit can be changed in the settings
    file to a value between 10 and 20 (see below).
  - A maximum of 3 menu levels: the ToolTime menu plus two levels
    of submenus. Deeper folders are ignored.
  - A maximum of 400 entries in total.

Tip: sort many tools into sub folders instead of one long list.

If a limit is exceeded, nothing is lost silently:

  - The surplus entries are not shown. Instead, the menu contains
    a grayed-out line such as "... 3 more not shown (limit 15)".
  - A notification appears, and the ToolTime section shows the
    entry "(!) ToolTime: problems found - click for details".
    Clicking it lists exactly what was ignored and why. The same
    information is written to the log file (if "Create Logfile"
    is turned on).
  - Folders nested too deeply and shortcuts that cannot be read
    are reported in the same way.

Settings in the settings file (section [ToolTime]):

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = show ToolTime, 0 = hide it (same as the menu
               item "Enable ToolTime")
  MaxEntries   Maximum number of entries per menu, 10 to 20
               (default: 15). Other values are corrected
               automatically.
  Folder       Optional: path of another ToolTime folder.
               Environment variables such as %USERPROFILE% are
               allowed. Empty = default folder. If the folder
               does not exist, it is created.

To edit the file, select "Edit Settings File" in the "Settings"
menu. After saving and closing Notepad, CCTrayTool reads the file
again, applies all changes immediately (no restart needed) and
rebuilds the tray menu.

Restoring the default tools: exit CCTrayTool, delete the ToolTime
folder and start the program again - the default tools and the
information file are created anew.


-------------------------------------------------------------------
 7. Additional settings
-------------------------------------------------------------------

The "Settings" submenu also offers:

  - Enable ToolTime
      Turns the entire tool quick-start section (see Section 5) on
      or off. When turned off, none of its entries appear in the
      tray menu, no matter what is in the ToolTime folder.

  - Open ToolTime Folder
      Opens the ToolTime folder in Windows Explorer, so that
      shortcuts can be added, renamed or removed (see Section 6).

  - Reload Tools
      Reads the ToolTime folder again and rebuilds the menu.
      Normally not necessary, as changes in the folder are
      detected automatically.

  - Enable KeepAwake
      Turns the entire KeepAwake section (see Section 2) on or off.
      When turned off, its entries disappear from the tray menu and
      normal Windows power-saving behavior applies.

  - Enable AlwaysOnTop
      Turns the entire AlwaysOnTop section (see Section 3) on or
      off. When turned off, its entries disappear from the tray
      menu and the keyboard shortcut is deactivated.

  - Enable CloseGuard
      Turns the entire CloseGuard section (see Section 4) on or
      off. When turned off, its entries disappear from the tray
      menu, its keyboard shortcuts are deactivated and all locked
      windows get their close button back.

  - Start Automatically
      CCTrayTool will start automatically at Windows logon in the
      future.

  - Create Logfile
      Writes a detailed log of all actions to a log file. Helpful
      for troubleshooting, not required during normal operation.
      In the settings file this is the entry "UseLog" in the [Main]
      section: 1 = on; 0, an empty or missing entry, or any other
      value = off.

  - View Logfile
      Opens the current log file in Notepad.

  - Use Large Icons
      Displays the icons in the tray menu larger (32 instead of 16
      pixels).

  - Edit Settings File
      Opens the configuration file directly for editing (see
      Section 6).


-------------------------------------------------------------------
 8. Storage locations
-------------------------------------------------------------------

CCTrayTool stores its files in the user profile:

  Configuration:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Logfile:          %LocalAppData%\CCTrayTool\CCTrayTool.log
  ToolTime folder:  %LocalAppData%\CCTrayTool\ToolTime\

The CloseGuard rules are kept in a file of their own:

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(The path can be pasted into Windows Explorer's address bar to go
directly to the folder.)


-------------------------------------------------------------------
 9. Closing the program
-------------------------------------------------------------------

CCTrayTool is closed via the "Exit" menu item. This automatically
restores normal Windows power-saving behavior and saves the current
configuration.

All windows whose close button is locked by CloseGuard get their
close button back when the program is closed.


-------------------------------------------------------------------
 10. About / Contact
-------------------------------------------------------------------

The currently installed version can be viewed at any time via the
"About" menu item.

CCTrayTool - Markus Debus
info@markus-debus.de
License: GNU General Public License, version 3 or later
(GPL-3.0-or-later), with an additional attribution term; see the
files LICENSE and NOTICE.



===================================================================
 CCTrayTool - Bedienungsanleitung
===================================================================

CCTrayTool ist ein kleines Windows-Tool, das als Symbol im
System-Tray (unten rechts neben der Uhr) läuft. Es vereint vier
nützliche Funktionen in einem Programm:

  1. KeepAwake        - verhindert, dass der PC in den Energiesparmodus
                         wechselt oder der Bildschirm sich abschaltet
  2. AlwaysOnTop       - hält per Tastenkombination ein beliebiges
                         Fenster im Vordergrund
  3. Tools-Schnellstart - startet häufig genutzte Programme direkt
                         über das Traymenü
  4. CloseGuard        - sperrt den Schließen-Button (X)
                         ausgewählter Fenster, per
                         Tastenkombination oder über Regeln

Alle Funktionen werden über ein Rechtsklick-Menü auf das Tray-Symbol
bedient. Eine Installation ist nicht nötig, das Programm kann direkt
gestartet werden.

CCTrayTool unterstützt die Sprachen Englisch, Deutsch, Italienisch,
Spanisch, Französisch, Polnisch, Ungarisch und Russisch.
Die Sprache wird basierend auf der Systemsprache des Computers
automatisch eingestellt.

Systemvoraussetzung: Ein 64-Bit-Windows 10 oder neuer ist
erforderlich. Auf 32-Bit-Windows läuft das Programm nicht.

-------------------------------------------------------------------
 1. Start und erstes Symbol
-------------------------------------------------------------------

Nach dem Start erscheint ein Symbol im Tray-Bereich der Windows-
Taskleiste. Die Farbe des Symbols zeigt sofort den aktuellen
KeepAwake-Status an:

  - Weiß  = KeepAwake deaktiviert (normales Windows-Verhalten)
  - Rot   = KeepAwake für Monitore aktiv
  - Blau  = KeepAwake für System aktiv
  - Grün  = KeepAwake für Monitore und System aktiv

Ein Klick mit der rechten Maustaste auf das Symbol öffnet das
Menü mit allen Funktionen. Falls das Symbol nicht sichtbar ist,
lohnt ein Blick in die "ausgeblendeten Symbole" (kleiner Pfeil in
der Taskleiste).

Hinweis: CCTrayTool kann nur einmal gleichzeitig gestartet werden.
Ein zweiter Start hat keine Wirkung, falls das Programm bereits
läuft.


-------------------------------------------------------------------
 2. KeepAwake - Energiesparen unterbinden
-------------------------------------------------------------------

Im Menüabschnitt "KeepAwake" lässt sich auswählen, was der PC NICHT
tun soll, während CCTrayTool läuft:

  - Monitore und System
      Weder der Bildschirm schaltet sich ab, noch geht der PC in
      den Energiesparmodus/Standby. Ideal für Präsentationen oder
      lang laufende Vorgänge, bei denen der Bildschirm sichtbar
      bleiben muss.

  - Monitore
      Nur der Bildschirm bleibt an (kein Abschalten, kein
      Bildschirmschoner). Der PC selbst kann trotzdem nach seiner
      eigenen Zeit in den Standby wechseln.

  - System
      Der PC geht nicht in den Standby/Energiesparmodus, der
      Bildschirm kann sich aber nach der Windows-Einstellung
      trotzdem abschalten. Praktisch z. B. für lange Downloads
      oder Berechnungen im Hintergrund.

  - Deaktiviert
      CCTrayTool greift nicht ein, es gilt das normale
      Energiespar-Verhalten von Windows.

Über den Menüpunkt "Status speichern" im Untermenü "Einstellungen"
des KeepAwake-Bereichs merkt sich CCTrayTool die zuletzt gewählte
KeepAwake-Einstellung und stellt sie beim nächsten Start
automatisch wieder her.

Beim Beenden von CCTrayTool wird das normale Energiesparverhalten
von Windows automatisch wiederhergestellt.


-------------------------------------------------------------------
 3. AlwaysOnTop - Fenster im Vordergrund halten
-------------------------------------------------------------------

Mit der Tastenkombination SHIFT + ALT + T (Standardbelegung) wird
das aktuell aktive Fenster dauerhaft im Vordergrund gehalten - auch
wenn andere Fenster angeklickt werden. Ein erneutes Drücken hebt
diese Fixierung wieder auf.

Beim Umschalten erscheint kurz ein kleiner Hinweis in der Nähe des
Mauszeigers, der bestätigt, ob das Fenster nun "im Vordergrund
bleibt" oder "wieder normal" ist. Dieser Hinweis lässt sich über
den Menüpunkt "ToolTip anzeigen" ein- oder ausschalten.

Im Menü "AlwaysOnTop" stehen folgende Optionen zur Verfügung:

  - Hotkey aktiv    Schaltet die Tastenkombination komplett ein
                    oder aus
  - Einstellungen   Untermenü (Zahnrad-Symbol) mit folgenden
                    Einträgen:
      - Hotkey ändern      Öffnet einen Dialog, in dem eine eigene
                           Tastenkombination festgelegt werden kann
                           (Kombination aus Strg/Ctrl, Alt, Shift,
                           Win + einem Buchstaben, einer Zahl oder
                           einer Funktionstaste F1-F12)
      - ToolTip anzeigen   Schaltet den kurzen Bildschirmhinweis
                           beim Umschalten ein oder aus

Hinweis: Der Windows-Desktop selbst ("Program Manager") kann nicht
auf "immer im Vordergrund" gesetzt werden. Nicht jede Tastenkombi-
nation ist frei - manche sind bereits vom System oder anderen
Programmen belegt. In diesem Fall erscheint ein Hinweis, und es
muss eine andere Kombination gewählt werden.


-------------------------------------------------------------------
 4. CloseGuard - Schließen-Button sperren
-------------------------------------------------------------------

CloseGuard schützt Fenster davor, versehentlich geschlossen zu
werden. Bei den Fenstern, die Sie auswählen, sperrt es den
Schließen-Button (das "X" oben rechts im Fenster): Der Button wird
ausgegraut, und ein Klick darauf bewirkt nichts. Das ist nützlich
für Programme, die dauerhaft laufen müssen, oder für Fenster, die
immer wieder aus Versehen geschlossen werden.

Ein Fenster lässt sich auf zwei Arten sperren:

  - Von Hand, per Tastenkombination
      Das Fenster anklicken und dann STRG + ALT + X
      (Standardbelegung) drücken. Der Schließen-Button dieses
      Fensters ist nun gesperrt. Erneutes Drücken gibt ihn wieder
      frei. Ein so freigegebenes Fenster bleibt frei, auch wenn
      eine Regel passt, bis es geschlossen wird. Ein kurzer Hinweis
      bestätigt jede Änderung. Die Sperre gilt, bis das Fenster
      geschlossen oder freigegeben wird.

  - Automatisch, über Regeln
      Das Fenster anklicken und dann STRG + ALT + UMSCHALT + X
      (Standardbelegung) drücken. CCTrayTool speichert eine Regel
      aus Fenstertitel und Fensterklasse in der Regeldatei und
      sperrt das Fenster. Ab dann wird jedes Fenster, auf das die
      Regel passt, automatisch gesperrt, sobald es erscheint - auch
      nach einem Neustart des Programms oder von CCTrayTool.

Im Traymenü bietet der Bereich "CloseGuard" diese Einträge:

  - Schließen-Button des aktiven Fensters sperren/freigeben
      Macht dasselbe wie die erste Tastenkombination. Solange das
      Traymenü offen ist, hat es selbst den Fokus; CloseGuard
      verwendet daher das Fenster, das unmittelbar davor aktiv war.

  - Regel für aktives Fenster anlegen
      Macht dasselbe wie die zweite Tastenkombination.

  - Gesperrte Fenster anzeigen
      Zeigt, welche Fenster gerade gesperrt sind (per Regel oder
      von Hand, mit der Fensterklasse in eckigen Klammern) und wie
      viele Regeln es gibt.

Darunter enthält das Untermenü "Einstellungen" (Zahnrad-Symbol):

  - Neue Fenster automatisch prüfen
      Ein: CloseGuard beobachtet dauerhaft und sperrt jedes neue
      Fenster, auf das eine Regel passt. Aus: Neue Fenster werden
      nicht automatisch gesperrt.

  - Beim Start offene Fenster prüfen
      Ein: Fenster, die beim Start von CCTrayTool schon offen sind,
      werden sofort mit den Regeln verglichen. Aus: Diese Fenster
      bleiben unberührt; nur später geöffnete Fenster werden
      geprüft.

  - Fenster minimieren bei Klick auf gesperrtes X
      Ein: Ein Klick auf den ausgegrauten Schließen-Button
      minimiert das Fenster, statt nichts zu bewirken. Wie bei
      einem echten Button wird das Fenster nur minimiert, wenn die
      Maustaste ebenfalls auf dem X losgelassen wird; wer die Taste
      drückt und wegzieht, bricht den Klick ab. Aus (Standard): Ein
      Klick bewirkt nichts.

  - Hotkey ändern: Sperren/Freigeben
    Hotkey ändern: Regel anlegen
      Öffnet denselben Dialog wie bei AlwaysOnTop, um eine andere
      Tastenkombination festzulegen. Eine Kombination, die eine
      andere Funktion von CCTrayTool bereits verwendet, wird
      abgelehnt.

  - Regeln bearbeiten...
      Öffnet die Regeldatei in Notepad (siehe unten). Nach dem
      Speichern und Schließen von Notepad werden die geänderten
      Regeln sofort angewendet: Fenster, die wegen einer nicht mehr
      passenden Regel gesperrt waren, werden freigegeben, neue
      Regeln gelten sofort für die offenen Fenster.

CloseGuard insgesamt lässt sich mit "CloseGuard aktivieren" im Menü
"Einstellungen" des Bereichs "CCTrayTool" ein- und ausschalten
(siehe Abschnitt 7).

Regeln (eigene Datei CloseGuardRules.ini, Abschnitt [Rules]):

Die Regeln stehen nicht in der Einstellungsdatei, sondern in einer
eigenen Datei: %LocalAppData%\CCTrayTool\CloseGuardRules.ini. Sie
wird automatisch angelegt. Es ist eine Unicode-Datei, daher
funktionieren auch Fenstertitel mit Umlauten oder anderen
Sonderzeichen. Notepad behält dieses Format bei; wird die Datei mit
einem anderen Programm bearbeitet, bitte ebenfalls als Unicode
(UTF-16) speichern, sonst können Sonderzeichen verloren gehen. Die
Regeln werden neu eingelesen, wenn Notepad nach "Regeln
bearbeiten..." geschlossen wird, und bei jedem Start von
CCTrayTool.

Jede Zeile ist eine Regel in der Form  Nummer=Titel|Klasse.  Der
Titel ist ein Text, der irgendwo im Fenstertitel vorkommen muss.
Die Klasse ist der technische Name des Fenstertyps und muss genau
übereinstimmen. Groß- und Kleinschreibung spielen keine Rolle.
Einer der beiden Teile darf leer sein (das "|" muss bleiben); sind
beide ausgefüllt, müssen beide passen. Beispiele:

  1=Calculator|       jedes Fenster mit "Calculator" im Titel
  2=|Notepad          jedes Fenster der Klasse "Notepad"
  3=Untitled|Notepad  Fenster der Klasse "Notepad" mit "Untitled"
                      im Titel

Die Tastenkombination "Regel anlegen" verwendet den vollständigen
aktuellen Titel des Fensters. Ändert sich der Titel (zum Beispiel
durch den Namen eines geöffneten Dokuments), über "Regeln
bearbeiten..." auf den gleichbleibenden Teil kürzen oder den Titel
leer lassen und nur die Klasse behalten. Die Klasse eines
gesperrten Fensters zeigt "Gesperrte Fenster anzeigen". Eine Regel
mit leerem Titel und leerer Klasse wird ignoriert; höchstens 200
Regeln werden verwendet.

Einstellungen in der Einstellungsdatei (Abschnitt [CloseGuard]):

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

  Enabled                  1 = CloseGuard ein, 0 = aus (wie der
                           Menüpunkt "CloseGuard aktivieren").
  HotkeyToggle             Tastenkombination für Sperren/Freigeben.
                           ^ = Strg, ! = Alt, + = Umschalt,
                           # = Win, danach die Taste. Einfacher
                           geht es mit dem Menüpunkt "Hotkey
                           ändern".
  HotkeyAddRule            Tastenkombination für "Regel anlegen".
  ApplyOnStartup           1 = Fenster, die beim Programmstart
                           offen sind, werden mit den Regeln
                           verglichen, 0 = sie bleiben unberührt.
  AutoApply                1 = neue Fenster werden automatisch
                           geprüft, 0 = nicht.
  PollInterval             Wie oft die Fenster geprüft werden, in
                           Millisekunden: 250 bis 5000 (Standard:
                           500). Andere Werte werden automatisch
                           korrigiert.
  MinimizeOnClick          1 = Ein Klick auf den gesperrten
                           Schließen-Button minimiert das Fenster,
                           0 = er bewirkt nichts (Standard).
                           Entspricht dem Menüpunkt.
  ClickPollInterval        Wie oft die Maustaste dafür geprüft
                           wird, in Millisekunden: 10 bis 100
                           (Standard: 30). Ein kleinerer Wert
                           erkennt auch sehr kurze Klicks sicherer,
                           ein größerer braucht weniger Rechenzeit.
                           Andere Werte werden automatisch
                           korrigiert. Für diese Einstellung gibt
                           es keinen Menüpunkt.
  ClickGeometryFallback    1 = Meldet ein Fenster mit eigener
                           Titelleiste (zum Beispiel Outlook) sein
                           X nicht an Windows, wird das X an seiner
                           Position erkannt (Standard). 0 = Es wird
                           nur ein X erkannt, das das Fenster
                           selbst meldet.
  ClickGeometryExtendLeft  Wie weit der Bereich, in dem das X an
                           seiner Position erkannt wird, nach links
                           reicht, in Prozent der Breite des X: 0
                           bis 100 (Standard: 0). Manche Programme
                           zeichnen ihr X weiter links, als Windows
                           meldet. Ein zu großer Wert reicht in den
                           benachbarten Maximieren-Button hinein.
  ClickGeometryExtendDown  Wie weit dieser Bereich nach unten
                           reicht, in Prozent der Höhe des X: 0 bis
                           100 (Standard: 87). Manche Programme
                           zeichnen ihr X tiefer, als Windows
                           meldet. Gleicher Zweck und gleiche
                           Grenzen wie ClickGeometryExtendLeft.
  ClickDebugOverlay        1 = zeigt die Bereiche, in denen das X
                           erkannt wird, als farbige, durchsichtige
                           Rechtecke auf dem Bildschirm: rot = der
                           Bereich, in dem ein Klick als Klick auf
                           das X zählt, blau = der Button-Bereich,
                           den Windows meldet (oder, wenn Windows
                           keinen meldet, der beim Fragen des
                           Fensters gefundene Bereich des X),
                           grün = das Schutzfenster über dem X
                           (siehe ClickShieldClasses). Nur zur
                           Fehlersuche. 0 = aus (Standard).
  ClickShieldClasses       Fensterklassen (durch Komma getrennt)
                           von Programmen, die sich selbst
                           schließen, sobald die Maustaste
                           losgelassen wird, zum Beispiel Edge und
                           Chrome (Chrome_WidgetWin_1) und Firefox
                           (MozillaWindowClass); Standard sind
                           beide. Das X eines solchen Fensters wird
                           von einem fast unsichtbaren Fenster
                           abgedeckt, das den Klick abfängt; das
                           Fenster lässt sich dann nicht mehr mit
                           dem X schließen. Leer = keine.

Die beiden CloseGuard-Tastenkombinationen und die
AlwaysOnTop-Tastenkombination müssen sich voneinander
unterscheiden. Andernfalls werden stattdessen die
Standardkombinationen verwendet.

Wissenswertes:

  - Die Sperre schützt vor einem versehentlichen Klick auf das X.
    Je nach Programm lässt sich ein Fenster weiterhin auf anderen
    Wegen schließen: mit ALT + F4, mit "Fenster schließen" in der
    Taskleiste, mit einem Beenden-Befehl im Menü des Programms oder
    über den Task-Manager.

  - Gesperrt werden können nur Fenster mit normaler Titelleiste und
    Systemmenü. Programme, die ihre Titelleiste selbst zeichnen
    (viele moderne Apps, einige Browser, Apps aus dem Microsoft
    Store), behalten unter Umständen ein funktionierendes X, obwohl
    CloseGuard das Fenster als gesperrt meldet. Hat ein Fenster gar
    kein Systemmenü, erscheint ein Hinweis.

  - Minimieren per Klick: CCTrayTool prüft die Maustaste kurz und
    regelmäßig (Standard: alle 30 ms), und nur, solange mindestens
    ein gesperrtes Fenster sichtbar ist. Es wird kein Maus-Hook
    verwendet, die Maus und das System können dadurch nicht
    ausgebremst werden. Fällt ein sehr kurzer Klick ausnahmsweise
    in einen Moment, in dem CCTrayTool beschäftigt ist, wird er
    einfach nicht bemerkt: Das Fenster bleibt unverändert und sein
    X gesperrt.

  - Minimieren per Klick reagiert auf die primäre Maustaste (die
    rechte, wenn die Tasten in Windows vertauscht sind) und nur auf
    das X gesperrter Fenster. Eingaben per Touch und Stift werden
    nicht erkannt. Ignoriert ein Programm den Minimieren-Befehl,
    minimiert CCTrayTool das Fenster direkt.

  - Manche Programme zeichnen ihre Titelleiste selbst (zum Beispiel
    Outlook). Sie sagen Windows nicht, wo ihr X liegt; deshalb
    berechnet CCTrayTool für die Klick-Erkennung die Position des X
    in der oberen rechten Ecke des Fensters (INI-Schlüssel
    ClickGeometryFallback). In der Log-Datei steht dann "recognized
    by its position".

  - Edge, Chrome und andere Chromium-Programme sowie Firefox
    zeichnen ihr X selbst und schließen das Fenster von sich aus,
    sobald die Maustaste losgelassen wird. Das gesperrte Systemmenü
    hält sie deshalb nicht auf. Über dem X solcher Fenster
    (INI-Schlüssel ClickShieldClasses, Standard
    Chrome_WidgetWin_1,MozillaWindowClass) legt CCTrayTool darum
    ein fast unsichtbares Schutzfenster. Der Klick landet auf dem
    Schutzfenster, das Programm bekommt ihn nie zu sehen: Es
    passiert nichts, oder das Fenster wird minimiert, wenn das
    Minimieren beim Klick eingeschaltet ist. Das Schutzfenster
    folgt dem Fenster und ist weg, solange das Fenster minimiert,
    entsperrt, im Vollbild oder an seinem X von einem anderen
    Fenster überdeckt ist. Mit ClickDebugOverlay=1 wird es grün
    angezeigt. Solange ein Fenster einer solchen Klasse sichtbar
    ist, wird die Maustaste alle 10 ms geprüft, auch wenn das
    Minimieren beim Klick ausgeschaltet ist. Firefox zeichnet seine
    Titelleiste selbst, Windows meldet keine Position für sein X;
    CCTrayTool findet das X dann, indem es das Fenster fragt
    (Logdatei: "found by asking the window"). Der Positions-Ersatz
    (ClickGeometryFallback) wird nur für Fenster verwendet, die ihr
    X nicht an Windows melden, etwa Outlook und Word; CCTrayTool
    fragt dazu jedes Fenster einmal und schreibt das Ergebnis in
    die Logdatei ("probe of the X").

  - Fenster von Programmen, die als Administrator laufen, lassen
    sich nicht sperren, solange CCTrayTool nicht selbst als
    Administrator läuft (eine Sicherheitsregel von Windows). Es
    erscheint ein Hinweis.

  - Der Desktop, die Taskleiste und die Fenster von CCTrayTool
    selbst werden nie gesperrt.

  - Beim Freigeben wird das Systemmenü des Fensters auf den
    Windows-Standard zurückgesetzt. Einträge, die das Programm
    selbst zu diesem Menü hinzugefügt hat, fehlen unter Umständen,
    bis das Programm neu gestartet wird.

  - Eine Sperre gilt nur, solange CCTrayTool läuft: Beim Beenden
    des Programms oder beim Ausschalten von CloseGuard erhalten
    alle Fenster ihren Schließen-Button zurück. Wird CCTrayTool
    zwangsweise beendet (zum Beispiel über den Task-Manager),
    bleiben gesperrte Fenster gesperrt. Dann in einem solchen
    Fenster die Tastenkombination zum Sperren/Freigeben drücken
    (CCTrayTool muss wieder laufen) oder das Fenster schließen und
    neu öffnen.


-------------------------------------------------------------------
 5. Schnellstart-Menü für eigene Programme
-------------------------------------------------------------------

Oberhalb von KeepAwake zeigt das Traymenü den Bereich "ToolTime":
eine Liste von Programmen, die sich mit einem Klick starten lassen.
Die Einträge stammen aus einem Ordner auf Ihrem PC (siehe
Abschnitt 6): Jede Verknüpfung (.lnk-Datei) in diesem Ordner wird
zu einem Menüeintrag, jeder Unterordner zu einem Untermenü.

Im Auslieferungszustand sind bereits einige Windows-Bordmittel
eingerichtet, u. a.:

  - Rechner, Notepad  (Ordner "Office")
  - Explorer  (direkt im Hauptmenü)
  - Eingabeaufforderung, Registrierungs-Editor,
    Netzwerkeinstellungen, Systemsteuerung, Ressourcenmonitor,
    Leistungsüberwachung, Dienste verwalten,
    Datenträgerbereinigung  (Ordner "System")

Verknüpfungen, deren Programm auf dem jeweiligen PC nicht gefunden
wird, erscheinen automatisch nicht im Menü - es kommt also zu
keiner Fehlermeldung, wenn ein Tool auf einem System fehlt.

Einige Einträge (z. B. Eingabeaufforderung, Regedit) sind so
eingerichtet, dass sie automatisch mit Administratorrechten
gestartet werden (Windows fragt in diesem Fall über die
Benutzerkontensteuerung nach Bestätigung).


-------------------------------------------------------------------
 6. Eigene Tools und Ordner hinzufügen
-------------------------------------------------------------------

Die Tools im Schnellstart-Menü sind einfach Verknüpfungen in einem
Ordner. Um ein Tool hinzuzufügen, im Menü "Einstellungen" den Punkt
"ToolTime-Ordner öffnen" wählen und im geöffneten Ordner eine
Verknüpfung (.lnk-Datei) ablegen. CCTrayTool bemerkt die Änderung
selbstständig und aktualisiert das Traymenü kurz darauf. (Falls das
einmal nicht geschieht, hilft "Tools neu laden" im Menü
"Einstellungen".)

Eine Verknüpfung lässt sich schnell erstellen: ein Programm mit der
rechten Maustaste in den Ordner ziehen und "Verknüpfungen hier
erstellen" wählen.

Standardordner:  %LocalAppData%\CCTrayTool\ToolTime
(Ein anderer Ordner kann in der Einstellungsdatei festgelegt
werden, siehe unten.)

Beim Anlegen des ToolTime-Ordners legt CCTrayTool außerdem eine
kurze Infodatei darin ab ("ToolTime_Info.txt", in der Sprache des
Systems). Sie erklärt knapp die Grenzen und wie sich Einträge mit
einer vorangestellten Zahl sortieren lassen. Das Menü ignoriert die
Datei; sie kann jederzeit gelöscht werden.

So wird aus dem Ordner das Menü:

  Verknüpfung (.lnk)  wird zu einem Menüeintrag. Der Name ist der
                      Dateiname, das Symbol stammt aus der
                      Verknüpfung (bzw. aus dem Programm, auf das
                      sie zeigt).
  Unterordner         wird zu einem Untermenü. Das Ordnersymbol
                      lässt sich wie gewohnt im Windows-Explorer
                      ändern (Eigenschaften > Anpassen > Anderes
                      Symbol).
  Reihenfolge         Zuerst kommen die Ordner, dann die
                      Verknüpfungen, jeweils alphabetisch sortiert.
                      Für eine eigene Reihenfolge den Namen mit
                      zwei oder drei Ziffern und einem Unterstrich
                      beginnen, z. B. "01_Notepad.lnk". Die Zahl
                      dient nur der Sortierung und wird nicht
                      angezeigt.
  Administrator       In den Eigenschaften der Verknüpfung "Als
                      Administrator ausführen" aktivieren
                      (Verknüpfung > Erweitert). Windows fragt
                      dann beim Start des Eintrags nach
                      Bestätigung.
  Nicht angezeigt     Versteckte Dateien, Dateien, die keine
                      Verknüpfungen sind, Verknüpfungen, deren
                      Programm nicht existiert, und leere Ordner.

Grenzen - damit das Menü bedienbar bleibt:

Ein Traymenü lässt sich nicht mit dem Mausrad scrollen, sondern nur
über zwei kleine Pfeilschaltflächen, und ein langes Menü würde
KeepAwake, AlwaysOnTop und die Einstellungen aus dem sichtbaren
Bereich schieben. Deshalb gilt:

  - Pro Menü werden höchstens 15 Einträge (Ordner und
    Verknüpfungen zusammen) angezeigt. Diese Grenze lässt sich in
    der Einstellungsdatei auf einen Wert zwischen 10 und 20
    ändern (siehe unten).
  - Höchstens 3 Menüebenen: das ToolTime-Menü plus zwei Ebenen
    Untermenüs. Tiefer liegende Ordner werden ignoriert.
  - Höchstens 400 Einträge insgesamt.

Tipp: Viele Tools lieber in Unterordnern gruppieren als in einer
langen Liste.

Wird eine Grenze überschritten, geht nichts unbemerkt verloren:

  - Die überzähligen Einträge werden nicht angezeigt. Stattdessen
    enthält das Menü eine ausgegraute Zeile wie "... 3 weitere
    nicht angezeigt (Limit 15)".
  - Es erscheint eine Benachrichtigung, und der Bereich ToolTime
    zeigt den Eintrag "(!) ToolTime: Probleme gefunden - zum
    Anzeigen der Details klicken". Ein Klick darauf listet genau
    auf, was ignoriert wurde und warum. Dieselben Informationen
    werden ins Logfile geschrieben (sofern "Logfile erstellen"
    aktiviert ist).
  - Zu tief verschachtelte Ordner und Verknüpfungen, die nicht
    gelesen werden können, werden auf dieselbe Weise gemeldet.

Einstellungen in der Einstellungsdatei (Abschnitt [ToolTime]):

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = ToolTime anzeigen, 0 = ausblenden (entspricht
               dem Menüpunkt "ToolTime aktivieren")
  MaxEntries   Höchstzahl der Einträge pro Menü, 10 bis 20
               (Standard: 15). Andere Werte werden automatisch
               korrigiert.
  Folder       Optional: Pfad eines anderen ToolTime-Ordners.
               Umgebungsvariablen wie %USERPROFILE% sind erlaubt.
               Leer = Standardordner. Existiert der Ordner nicht,
               wird er angelegt.

Zum Bearbeiten der Datei im Menü "Einstellungen" den Punkt
"Einstellungsdatei bearbeiten" wählen. Nach dem Speichern und
Schließen von Notepad liest CCTrayTool die Datei neu ein, übernimmt
alle Änderungen sofort (ohne Neustart) und baut das Traymenü neu
auf.

Standard-Tools wiederherstellen: CCTrayTool beenden, den
ToolTime-Ordner löschen und das Programm neu starten - die
Standard-Tools und die Infodatei werden neu angelegt.


-------------------------------------------------------------------
 7. Weitere Einstellungen
-------------------------------------------------------------------

Im Untermenü "Einstellungen" stehen zusätzlich zur Verfügung:

  - ToolTime aktivieren
      Schaltet den gesamten Tools-Schnellstart-Bereich (siehe
      Abschnitt 5) komplett ein oder aus. Bei Deaktivierung
      erscheinen keine seiner Einträge im Traymenü, unabhängig
      davon, was sich im ToolTime-Ordner befindet.

  - ToolTime-Ordner öffnen
      Öffnet den ToolTime-Ordner im Windows-Explorer, damit
      Verknüpfungen hinzugefügt, umbenannt oder entfernt werden
      können (siehe Abschnitt 6).

  - Tools neu laden
      Liest den ToolTime-Ordner erneut ein und baut das Menü neu
      auf. Normalerweise nicht nötig, da Änderungen im Ordner
      automatisch erkannt werden.

  - KeepAwake aktivieren
      Schaltet den gesamten KeepAwake-Bereich (siehe Abschnitt 2)
      komplett ein oder aus. Bei Deaktivierung verschwinden seine
      Einträge aus dem Traymenü, und es gilt das normale
      Energiesparverhalten von Windows.

  - AlwaysOnTop aktivieren
      Schaltet den gesamten AlwaysOnTop-Bereich (siehe Abschnitt 3)
      komplett ein oder aus. Bei Deaktivierung verschwinden seine
      Einträge aus dem Traymenü, und die Tastenkombination wird
      deaktiviert.

  - CloseGuard aktivieren
      Schaltet den gesamten CloseGuard-Bereich (siehe Abschnitt 4)
      komplett ein oder aus. Bei Deaktivierung verschwinden seine
      Einträge aus dem Traymenü, die Tastenkombinationen werden
      deaktiviert, und alle gesperrten Fenster erhalten ihren
      Schließen-Button zurück.

  - Automatisch starten
      CCTrayTool startet künftig automatisch bei der Windows-
      Anmeldung.

  - Logfile erstellen
      Schreibt ein detailliertes Protokoll aller Aktionen in eine
      Log-Datei. Hilfreich zur Fehlersuche, im Normalbetrieb nicht
      erforderlich.
      In der Einstellungsdatei ist das der Eintrag "UseLog" im
      Abschnitt [Main]: 1 = ein; 0, ein leerer oder fehlender
      Eintrag oder jeder andere Wert = aus.

  - Logfile ansehen
      Öffnet die aktuelle Log-Datei in Notepad.

  - Große Icons verwenden
      Zeigt die Symbole im Traymenü größer an (32 statt 16 Pixel).

  - Einstellungsdatei bearbeiten
      Öffnet die Konfigurationsdatei direkt zur Bearbeitung (siehe
      Abschnitt 6).


-------------------------------------------------------------------
 8. Speicherorte
-------------------------------------------------------------------

CCTrayTool legt seine Dateien im Benutzerprofil ab:

  Konfiguration:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Logfile:          %LocalAppData%\CCTrayTool\CCTrayTool.log
  ToolTime-Ordner:  %LocalAppData%\CCTrayTool\ToolTime\

Die CloseGuard-Regeln liegen in einer eigenen Datei:

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(Der Pfad lässt sich in die Windows-Adressleiste des Explorers
einfügen, um direkt zum Ordner zu gelangen.)


-------------------------------------------------------------------
 9. Programm beenden
-------------------------------------------------------------------

Über den Menüpunkt "Beenden" wird CCTrayTool geschlossen. Dabei
wird automatisch das normale Energiesparverhalten von Windows
wiederhergestellt und die aktuelle Konfiguration gespeichert.

Alle Fenster, deren Schließen-Button von CloseGuard gesperrt ist,
erhalten dabei ihren Schließen-Button zurück.


-------------------------------------------------------------------
 10. Über / Kontakt
-------------------------------------------------------------------

Die aktuell installierte Version lässt sich jederzeit über den
Menüpunkt "Über" einsehen.

CCTrayTool - Markus Debus
info@markus-debus.de
Lizenz: GNU General Public License, Version 3 oder später
(GPL-3.0-or-later), mit einer zusätzlichen
Namensnennungs-Bedingung; siehe die Dateien LICENSE und NOTICE.



===================================================================
 CCTrayTool - Manuale d'uso
===================================================================

CCTrayTool è un piccolo strumento per Windows che viene eseguito
come icona nell'area di notifica (in basso a destra, accanto
all'orologio). Riunisce quattro funzioni utili in un unico
programma:

  1. KeepAwake          - impedisce che il PC entri in modalità di
                           risparmio energetico o che lo schermo si
                           spenga
  2. AlwaysOnTop         - mantiene una finestra qualsiasi sempre in
                           primo piano tramite una combinazione di
                           tasti
  3. Avvio rapido strumenti - avvia i programmi usati più spesso
                           direttamente dal menu dell'area di
                           notifica
  4. CloseGuard          - blocca il pulsante di chiusura (X) di
                           finestre selezionate, con una
                           combinazione di tasti o con regole

Tutte le funzioni si utilizzano tramite un clic destro sull'icona
nell'area di notifica. Non è necessaria alcuna installazione, il
programma può essere avviato direttamente.

CCTrayTool supporta le lingue inglese, tedesco, italiano, spagnolo,
francese, polacco, ungherese e russo.
La lingua viene impostata automaticamente in base alla lingua di
sistema del computer.

Requisiti di sistema: è necessario Windows 10 o successivo a 64
bit. Il programma non funziona su Windows a 32 bit.

-------------------------------------------------------------------
 1. Avvio e prima icona
-------------------------------------------------------------------

Dopo l'avvio, viene visualizzata un'icona nell'area di notifica
della barra delle applicazioni di Windows. Il colore dell'icona
indica immediatamente lo stato attuale di KeepAwake:

  - Bianco = KeepAwake disattivato (comportamento normale di
             Windows)
  - Rosso  = KeepAwake attivo per i monitor
  - Blu    = KeepAwake attivo per il sistema
  - Verde  = KeepAwake attivo per monitor e sistema

Un clic con il tasto destro del mouse sull'icona apre il menu con
tutte le funzioni. Se l'icona non è visibile, controllare l'area
delle "icone nascoste" (piccola freccia nella barra delle
applicazioni).

Nota: CCTrayTool può essere avviato una sola volta alla volta. Un
secondo avvio non ha alcun effetto se il programma è già in
esecuzione.


-------------------------------------------------------------------
 2. KeepAwake - impedire il risparmio energetico
-------------------------------------------------------------------

Nella sezione di menu "KeepAwake" è possibile selezionare cosa il
PC NON deve fare mentre CCTrayTool è in esecuzione:

  - Monitor e sistema
      Né lo schermo si spegne, né il PC entra in standby/modalità
      di risparmio energetico. Ideale per presentazioni o processi
      di lunga durata in cui lo schermo deve rimanere visibile.

  - Monitor
      Solo lo schermo rimane acceso (nessuno spegnimento, nessun
      salvaschermo). Il PC stesso può comunque entrare in standby
      dopo il proprio timeout.

  - Sistema
      Il PC non entra in standby/modalità di risparmio energetico,
      ma lo schermo può comunque spegnersi secondo le impostazioni
      di Windows. Utile, ad esempio, per download lunghi o calcoli
      in background.

  - Disattivato
      CCTrayTool non interviene; si applica il normale
      comportamento di risparmio energetico di Windows.

La voce di menu "Salva stato" nel sottomenu "Impostazioni" della
sezione KeepAwake fa sì che CCTrayTool memorizzi l'ultima
impostazione KeepAwake selezionata e la ripristini automaticamente
al successivo avvio.

Alla chiusura di CCTrayTool, il normale comportamento di risparmio
energetico di Windows viene ripristinato automaticamente.


-------------------------------------------------------------------
 3. AlwaysOnTop - mantenere una finestra in primo piano
-------------------------------------------------------------------

La combinazione di tasti MAIUSC + ALT + T (predefinita) mantiene
permanentemente in primo piano la finestra attualmente attiva,
anche quando si fa clic su altre finestre. Premendola di nuovo si
annulla questo blocco.

Al momento del cambio, vicino al puntatore del mouse compare
brevemente un piccolo avviso che conferma se la finestra ora
"rimane in primo piano" oppure è "tornata normale". Questo avviso
può essere attivato o disattivato tramite la voce di menu "Mostra
ToolTip".

Nel menu "AlwaysOnTop" sono disponibili le seguenti opzioni:

  - Hotkey attivo   Attiva o disattiva completamente la
                    combinazione di tasti
  - Impostazioni    Sottomenu (icona a forma di ingranaggio) con le
                    voci seguenti:
      - Cambia hotkey    Apre una finestra di dialogo in cui è
                         possibile impostare una combinazione di
                         tasti personalizzata (combinazione di
                         Ctrl, Alt, Maiusc, Win più una lettera, un
                         numero o un tasto funzione F1-F12)
      - Mostra ToolTip   Attiva o disattiva il breve avviso a
                         schermo al momento del cambio

Nota: Il desktop di Windows stesso ("Program Manager") non può
essere impostato su "sempre in primo piano". Non tutte le
combinazioni di tasti sono libere: alcune sono già occupate dal
sistema o da altri programmi. In questo caso viene visualizzato un
avviso ed è necessario scegliere un'altra combinazione.


-------------------------------------------------------------------
 4. CloseGuard - bloccare il pulsante di chiusura
-------------------------------------------------------------------

CloseGuard protegge le finestre dalla chiusura accidentale. Per le
finestre scelte blocca il pulsante di chiusura (la "X" in alto a
destra nella finestra): il pulsante appare disattivato e un clic su
di esso non ha alcun effetto. È utile per i programmi che devono
rimanere in esecuzione o per le finestre che vengono chiuse per
errore di continuo.

Una finestra può essere bloccata in due modi:

  - A mano, con una combinazione di tasti
      Fare clic sulla finestra e premere CTRL + ALT + X
      (predefinita). Il pulsante di chiusura di questa finestra è
      ora bloccato. Premendo di nuovo la combinazione lo si
      sblocca. Una finestra sbloccata in questo modo resta libera,
      anche se una regola corrisponde, finché non viene chiusa. Una
      breve notifica conferma ogni modifica. Il blocco dura finché
      la finestra non viene chiusa o sbloccata.

  - Automaticamente, con regole
      Fare clic sulla finestra e premere CTRL + ALT + MAIUSC + X
      (predefinita). CCTrayTool salva nel file delle regole una
      regola composta dal titolo e dalla classe della finestra e
      blocca la finestra. Da quel momento ogni finestra che
      corrisponde alla regola viene bloccata automaticamente non
      appena compare - anche dopo il riavvio del programma o di
      CCTrayTool.

Nel menu dell'area di notifica, la sezione "CloseGuard" offre
queste voci:

  - Blocca/sblocca il pulsante di chiusura della finestra attiva
      Fa la stessa cosa della prima combinazione di tasti. Finché
      il menu dell'area di notifica è aperto, il focus è sul menu
      stesso; CloseGuard usa quindi la finestra che era attiva
      subito prima.

  - Crea regola per la finestra attiva
      Fa la stessa cosa della seconda combinazione di tasti.

  - Mostra finestre bloccate
      Mostra quali finestre sono bloccate al momento (da una regola
      o a mano, con la classe della finestra tra parentesi quadre)
      e quante regole esistono.

Sotto di esse, il sottomenu "Impostazioni" (icona a forma di
ingranaggio) contiene:

  - Controlla automaticamente le nuove finestre
      Attivo: CloseGuard resta in osservazione e blocca ogni nuova
      finestra che corrisponde a una regola. Disattivo: le nuove
      finestre non vengono bloccate automaticamente.

  - Controlla le finestre aperte all'avvio
      Attivo: le finestre già aperte all'avvio di CCTrayTool
      vengono confrontate subito con le regole. Disattivo: queste
      finestre restano intatte; vengono controllate solo quelle
      aperte in seguito.

  - Riduci a icona la finestra al clic sulla X bloccata
      Attivo: un clic sul pulsante di chiusura disattivato riduce a
      icona la finestra invece di non fare nulla. Come con un
      pulsante vero, la finestra viene ridotta a icona solo se il
      pulsante del mouse viene rilasciato anch'esso sulla X;
      premere il pulsante e spostarsi altrove annulla il clic.
      Disattivo (predefinito): un clic non fa nulla.

  - Cambia hotkey: blocca/sblocca
    Cambia hotkey: crea regola
      Apre la stessa finestra di dialogo di AlwaysOnTop per
      definire un'altra combinazione di tasti. Una combinazione già
      usata da un'altra funzione di CCTrayTool viene rifiutata.

  - Modifica regole...
      Apre il file delle regole in Blocco note (vedi sotto). Dopo
      aver salvato e chiuso Blocco note, le regole modificate
      vengono applicate subito: le finestre bloccate da una regola
      che non corrisponde più vengono sbloccate e le nuove regole
      valgono subito per le finestre aperte.

CloseGuard nel suo complesso si attiva e si disattiva con "Attiva
CloseGuard" nel menu "Impostazioni" della sezione "CCTrayTool"
(vedi sezione 7).

Regole (file dedicato CloseGuardRules.ini, sezione [Rules]):

Le regole non sono nel file di configurazione, ma in un file
dedicato: %LocalAppData%\CCTrayTool\CloseGuardRules.ini. Viene
creato automaticamente. È un file Unicode, quindi funzionano anche
i titoli di finestra con lettere accentate o altri caratteri
speciali. Blocco note mantiene questo formato; se il file viene
modificato con un altro programma, salvarlo ugualmente come Unicode
(UTF-16), altrimenti i caratteri speciali possono andare persi. Le
regole vengono rilette quando si chiude Blocco note dopo "Modifica
regole..." e a ogni avvio di CCTrayTool.

Ogni riga è una regola nella forma  numero=titolo|classe.  Il
titolo è un testo che deve comparire in un punto qualsiasi del
titolo della finestra. La classe è il nome tecnico del tipo di
finestra e deve corrispondere esattamente. Maiuscole e minuscole
non contano. Una delle due parti può essere vuota (il "|" deve
restare); se sono compilate entrambe, devono corrispondere
entrambe. Esempi:

  1=Calculator|       ogni finestra con "Calculator" nel titolo
  2=|Notepad          ogni finestra della classe "Notepad"
  3=Untitled|Notepad  finestre della classe "Notepad" con
                      "Untitled" nel titolo

La combinazione di tasti "crea regola" usa il titolo attuale
completo della finestra. Se il titolo cambia (ad esempio con il
nome di un documento aperto), accorciarlo in seguito con "Modifica
regole..." alla parte che rimane uguale, oppure lasciare vuoto il
titolo e tenere solo la classe. La classe di una finestra bloccata
è mostrata da "Mostra finestre bloccate". Una regola con titolo e
classe vuoti viene ignorata; vengono usate al massimo 200 regole.

Impostazioni nel file di configurazione (sezione [CloseGuard]):

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

  Enabled                  1 = CloseGuard attivo, 0 = disattivo
                           (come la voce di menu "Attiva
                           CloseGuard").
  HotkeyToggle             Combinazione di tasti per
                           bloccare/sbloccare. ^ = Ctrl, ! = Alt,
                           + = Maiusc, # = Win, seguito dal tasto.
                           È più semplice cambiarla con la voce di
                           menu "Cambia hotkey".
  HotkeyAddRule            Combinazione di tasti per "crea regola".
  ApplyOnStartup           1 = le finestre aperte all'avvio del
                           programma vengono confrontate con le
                           regole, 0 = restano intatte.
  AutoApply                1 = le nuove finestre vengono
                           controllate automaticamente, 0 = no.
  PollInterval             Ogni quanto vengono controllate le
                           finestre, in millisecondi: da 250 a 5000
                           (predefinito: 500). Gli altri valori
                           vengono corretti automaticamente.
  MinimizeOnClick          1 = un clic sul pulsante di chiusura
                           bloccato riduce a icona la finestra,
                           0 = non fa nulla (predefinito). Equivale
                           alla voce di menu.
  ClickPollInterval        Ogni quanto viene controllato a tale
                           scopo il pulsante del mouse, in
                           millisecondi: da 10 a 100 (predefinito:
                           30). Un valore minore riconosce con più
                           sicurezza anche i clic molto brevi, uno
                           maggiore richiede meno tempo di calcolo.
                           Gli altri valori vengono corretti
                           automaticamente. Per questa impostazione
                           non esiste una voce di menu.
  ClickGeometryFallback    1 = se una finestra con barra del titolo
                           propria (per esempio Outlook) non
                           comunica a Windows la sua X, la X viene
                           riconosciuta in base alla posizione
                           (predefinito). 0 = viene riconosciuta
                           solo una X che la finestra comunica da
                           sé.
  ClickGeometryExtendLeft  Quanto si estende verso sinistra l'area
                           in cui la X viene riconosciuta in base
                           alla posizione, in percentuale della
                           larghezza della X: da 0 a 100
                           (predefinito: 0). Alcuni programmi
                           disegnano la loro X più a sinistra di
                           quanto indica Windows. Un valore troppo
                           grande arriva fino al pulsante di
                           ingrandimento vicino.
  ClickGeometryExtendDown  Quanto si estende verso il basso
                           quest'area, in percentuale dell'altezza
                           della X: da 0 a 100 (predefinito: 87).
                           Alcuni programmi disegnano la loro X più
                           in basso di quanto indica Windows.
                           Stesso scopo e stessi limiti di
                           ClickGeometryExtendLeft.
  ClickDebugOverlay        1 = mostra sullo schermo, come
                           rettangoli colorati e trasparenti, le
                           aree usate per riconoscere la X:
                           rosso = l'area in cui un clic vale come
                           clic sulla X, blu = l'area del pulsante
                           di chiusura indicata da Windows (o, se
                           Windows non ne indica una, l'area della
                           X trovata interrogando la finestra),
                           verde = lo scudo sopra la X (vedi
                           ClickShieldClasses). Solo per la ricerca
                           di errori. 0 = disattivato
                           (predefinito).
  ClickShieldClasses       Classi di finestre (separate da virgole)
                           di programmi che si chiudono da soli
                           quando il pulsante del mouse viene
                           rilasciato, ad esempio Edge e Chrome
                           (Chrome_WidgetWin_1) e Firefox
                           (MozillaWindowClass); per impostazione
                           predefinita entrambe. La X di tale
                           finestra viene coperta da una finestra
                           quasi invisibile che intercetta il clic,
                           così la finestra non può più essere
                           chiusa con la X. Vuoto = nessuna.

Le due combinazioni di tasti di CloseGuard e quella di AlwaysOnTop
devono essere diverse tra loro. In caso contrario vengono usate
quelle predefinite.

Da sapere:

  - Il blocco protegge da un clic accidentale sulla X. A seconda
    del programma, una finestra può comunque essere chiusa in altri
    modi: con ALT + F4, con "Chiudi finestra" nella barra delle
    applicazioni, con un comando Esci nel menu del programma o con
    Gestione attività.

  - Si possono bloccare solo le finestre con una normale barra del
    titolo e un menu di sistema. I programmi che disegnano da soli
    la barra del titolo (molte app moderne, alcuni browser, app del
    Microsoft Store) possono mantenere una X funzionante anche se
    CloseGuard segnala la finestra come bloccata. Se una finestra
    non ha affatto un menu di sistema, compare un avviso.

  - Riduzione a icona con un clic: CCTrayTool controlla il pulsante
    del mouse brevemente e a intervalli regolari (predefinito: ogni
    30 ms), e solo finché è visibile almeno una finestra bloccata.
    Non usa alcun hook del mouse, quindi non può rallentare né il
    mouse né il sistema. Nel caso improbabile in cui un clic molto
    breve cada in un momento in cui CCTrayTool è occupato,
    semplicemente non viene rilevato: la finestra resta com'è e la
    sua X resta bloccata.

  - La riduzione a icona con un clic reagisce al pulsante primario
    del mouse (quello destro, se in Windows i pulsanti sono
    invertiti) e solo alla X delle finestre bloccate. L'input
    tattile e con penna non viene rilevato. Se un programma ignora
    il comando di riduzione a icona, CCTrayTool riduce a icona la
    finestra direttamente.

  - Alcuni programmi disegnano da sé la propria barra del titolo
    (per esempio Outlook). Non comunicano a Windows dove si trova
    la loro X, quindi per il rilevamento del clic CCTrayTool
    calcola la posizione della X nell'angolo in alto a destra della
    finestra (chiave INI ClickGeometryFallback). Nel file di log
    compare allora "recognized by its position".

  - Edge, Chrome e altri programmi basati su Chromium, così come
    Firefox, disegnano da soli la X e chiudono la finestra da soli
    quando il pulsante del mouse viene rilasciato, quindi il menu
    di sistema bloccato non li ferma. Sopra la X di tali finestre
    (chiave INI ClickShieldClasses, predefinita
    Chrome_WidgetWin_1,MozillaWindowClass) CCTrayTool pone una
    finestra quasi invisibile, uno scudo. Il clic finisce sullo
    scudo e il programma non lo vede mai: non succede nulla, oppure
    la finestra viene ridotta a icona se la riduzione a icona al
    clic è attiva. Lo scudo segue la finestra e scompare finché la
    finestra è ridotta a icona, sbloccata, a schermo intero o
    coperta da un'altra finestra sopra la X. Con
    ClickDebugOverlay=1 viene mostrato in verde. Finché una
    finestra di tale classe è visibile, il pulsante del mouse viene
    controllato ogni 10 ms, anche se la riduzione a icona al clic è
    disattivata. Firefox disegna da solo la barra del titolo e
    Windows non comunica la posizione della sua X; CCTrayTool trova
    allora la X interrogando la finestra (file di log:
    "found by asking the window"). Il riconoscimento di riserva in
    base alla posizione (ClickGeometryFallback) viene usato solo
    per le finestre che non comunicano la loro X a Windows, come
    Outlook e Word; CCTrayTool interroga ogni finestra una volta e
    scrive il risultato nel file di log ("probe of the X").

  - Le finestre dei programmi eseguiti come amministratore non
    possono essere bloccate finché CCTrayTool non è a sua volta
    eseguito come amministratore (una regola di sicurezza di
    Windows). Compare un avviso.

  - Il desktop, la barra delle applicazioni e le finestre di
    CCTrayTool stesso non vengono mai bloccati.

  - Quando una finestra viene sbloccata, il suo menu di sistema
    viene riportato allo standard di Windows. Le voci che il
    programma stesso ha aggiunto a questo menu possono mancare
    finché il programma non viene riavviato.

  - Un blocco dura solo finché CCTrayTool è in esecuzione: alla
    chiusura del programma o alla disattivazione di CloseGuard
    tutte le finestre riottengono il pulsante di chiusura. Se
    CCTrayTool viene terminato forzatamente (ad esempio con
    Gestione attività), le finestre bloccate restano bloccate. In
    tal caso premere in una di esse la combinazione per
    bloccare/sbloccare (CCTrayTool deve essere di nuovo in
    esecuzione) oppure chiudere la finestra e riaprirla.


-------------------------------------------------------------------
 5. Menu di avvio rapido per programmi personalizzati
-------------------------------------------------------------------

Sopra KeepAwake, il menu dell'area di notifica mostra la sezione
"ToolTime": un elenco di programmi che si avviano con un solo clic.
Le voci provengono da una cartella del PC (vedi sezione 6): ogni
collegamento (file .lnk) in questa cartella diventa una voce di
menu e ogni sottocartella diventa un sottomenu.

Per impostazione predefinita sono già configurati alcuni
strumenti integrati di Windows, tra cui:

  - Calcolatrice, Notepad  (cartella "Office")
  - Explorer  (direttamente nel menu principale)
  - Prompt dei comandi, Editor del Registro di sistema,
    Impostazioni di rete, Pannello di controllo, Monitor risorse,
    Monitor prestazioni, Gestisci servizi, Pulizia disco
    (cartella "Sistema")

I collegamenti il cui programma non viene trovato sul rispettivo
PC non compaiono automaticamente nel menu: non viene quindi
visualizzato alcun messaggio di errore se uno strumento manca su
un sistema.

Alcune voci (ad es. Prompt dei comandi, Editor del Registro di
sistema) sono configurate per avviarsi automaticamente con
privilegi di amministratore (in questo caso Windows chiede
conferma tramite il Controllo account utente).


-------------------------------------------------------------------
 6. Aggiungere strumenti e cartelle personalizzati
-------------------------------------------------------------------

Gli strumenti del menu di avvio rapido sono semplici collegamenti
in una cartella. Per aggiungere uno strumento, selezionare nel menu
"Impostazioni" la voce "Apri cartella ToolTime" e inserire un
collegamento (file .lnk) nella cartella che si apre. CCTrayTool
rileva la modifica da solo e aggiorna il menu poco dopo. (Se ciò
non avviene, usare la voce "Ricarica strumenti" nel menu
"Impostazioni".)

Un modo rapido per creare un collegamento: trascinare un programma
nella cartella con il tasto destro del mouse e scegliere "Crea
collegamenti qui".

Cartella predefinita:  %LocalAppData%\CCTrayTool\ToolTime
(Un'altra cartella può essere impostata nel file di
configurazione, vedi sotto.)

Quando CCTrayTool crea la cartella ToolTime, vi inserisce anche un
breve file informativo ("ToolTime_Info.txt", nella lingua del
sistema). Spiega in breve i limiti e come ordinare le voci con un
numero iniziale. Il menu ignora il file; può essere eliminato in
qualsiasi momento.

Come la cartella diventa un menu:

  Collegamento (.lnk)  diventa una voce di menu. Il nome è il nome
                       del file; l'icona è quella del collegamento
                       (o, se manca, quella del programma a cui
                       punta).
  Sottocartella        diventa un sottomenu. La sua icona si può
                       modificare come di consueto in Esplora
                       file (Proprietà > Personalizza > Cambia
                       icona).
  Ordine               Prima le cartelle, poi i collegamenti,
                       ciascuno in ordine alfabetico. Per un ordine
                       personalizzato, iniziare il nome con due o
                       tre cifre e un trattino basso, ad es.
                       "01_Notepad.lnk". Il numero serve solo per
                       l'ordinamento e non viene mostrato.
  Amministratore       Attivare "Esegui come amministratore" nelle
                       proprietà del collegamento (Collegamento >
                       Avanzate). All'avvio della voce Windows
                       chiede conferma.
  Non visualizzati     File nascosti, file che non sono
                       collegamenti, collegamenti il cui programma
                       non esiste e cartelle vuote.

Limiti - affinché il menu resti utilizzabile:

Un menu dell'area di notifica non si può scorrere con la rotellina
del mouse, ma solo con due piccoli pulsanti a freccia, e un menu
lungo spingerebbe KeepAwake, AlwaysOnTop e le impostazioni fuori
dalla vista. Pertanto:

  - Per ogni menu vengono mostrate al massimo 15 voci (cartelle e
    collegamenti insieme). Questo limite può essere modificato nel
    file di configurazione con un valore compreso tra 10 e 20
    (vedi sotto).
  - Al massimo 3 livelli di menu: il menu ToolTime più due livelli
    di sottomenu. Le cartelle più profonde vengono ignorate.
  - Al massimo 400 voci in totale.

Suggerimento: raggruppare molti strumenti in sottocartelle invece
di un unico elenco lungo.

Se un limite viene superato, nulla va perso inosservato:

  - Le voci in eccesso non vengono mostrate. Al loro posto il menu
    contiene una riga disattivata come "... altri 3 non
    visualizzati (limite 15)".
  - Compare una notifica e la sezione ToolTime mostra la voce
    "(!) ToolTime: rilevati problemi - fare clic per i dettagli".
    Facendo clic si ottiene l'elenco esatto di ciò che è stato
    ignorato e del motivo. Le stesse informazioni vengono scritte
    nel file di log (se "Crea file di log" è attivato).
  - Le cartelle annidate troppo in profondità e i collegamenti
    che non possono essere letti vengono segnalati allo stesso
    modo.

Impostazioni nel file di configurazione (sezione [ToolTime]):

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = mostra ToolTime, 0 = nascondi (come la voce di
               menu "Attiva ToolTime")
  MaxEntries   Numero massimo di voci per menu, da 10 a 20
               (predefinito: 15). Gli altri valori vengono
               corretti automaticamente.
  Folder       Facoltativo: percorso di un'altra cartella
               ToolTime. Sono ammesse variabili d'ambiente come
               %USERPROFILE%. Vuoto = cartella predefinita. Se la
               cartella non esiste, viene creata.

Per modificare il file, selezionare nel menu "Impostazioni" la voce
"Modifica file di configurazione". Dopo aver salvato e chiuso
Blocco note, CCTrayTool rilegge il file, applica subito tutte le
modifiche (senza riavvio) e ricostruisce il menu.

Ripristinare gli strumenti predefiniti: chiudere CCTrayTool,
eliminare la cartella ToolTime e riavviare il programma: gli
strumenti predefiniti e il file informativo vengono ricreati.


-------------------------------------------------------------------
 7. Altre impostazioni
-------------------------------------------------------------------

Nel sottomenu "Impostazioni" sono inoltre disponibili:

  - Attiva ToolTime
      Attiva o disattiva completamente l'intera sezione di avvio
      rapido degli strumenti (vedi sezione 5). Se disattivata,
      nessuna delle sue voci compare nel menu dell'area di notifica,
      indipendentemente da ciò che si trova nella cartella ToolTime.

  - Apri cartella ToolTime
      Apre la cartella ToolTime in Esplora file, per aggiungere,
      rinominare o rimuovere collegamenti (vedi sezione 6).

  - Ricarica strumenti
      Rilegge la cartella ToolTime e ricostruisce il menu.
      Normalmente non è necessario, poiché le modifiche nella
      cartella vengono rilevate automaticamente.

  - Attiva KeepAwake
      Attiva o disattiva completamente l'intera sezione KeepAwake
      (vedi sezione 2). Se disattivata, le sue voci scompaiono dal
      menu dell'area di notifica e si applica il normale
      comportamento di risparmio energetico di Windows.

  - Attiva AlwaysOnTop
      Attiva o disattiva completamente l'intera sezione AlwaysOnTop
      (vedi sezione 3). Se disattivata, le sue voci scompaiono dal
      menu dell'area di notifica e la combinazione di tasti viene
      disattivata.

  - Attiva CloseGuard
      Attiva o disattiva completamente l'intera sezione CloseGuard
      (vedi sezione 4). Se disattivata, le sue voci scompaiono dal
      menu dell'area di notifica, le combinazioni di tasti vengono
      disattivate e tutte le finestre bloccate riottengono il
      pulsante di chiusura.

  - Avvio automatico
      CCTrayTool si avvierà automaticamente in futuro all'accesso a
      Windows.

  - Crea file di log
      Scrive un registro dettagliato di tutte le azioni in un file
      di log. Utile per la risoluzione dei problemi, non necessario
      nel funzionamento normale.
      Nel file di configurazione è la voce "UseLog" nella sezione
      [Main]: 1 = attivo; 0, una voce vuota o mancante o qualsiasi
      altro valore = disattivato.

  - Visualizza file di log
      Apre il file di log corrente in Blocco note.

  - Usa icone grandi
      Visualizza le icone nel menu dell'area di notifica più grandi
      (32 invece di 16 pixel).

  - Modifica file di configurazione
      Apre direttamente il file di configurazione per la modifica
      (vedi sezione 6).


-------------------------------------------------------------------
 8. Percorsi di archiviazione
-------------------------------------------------------------------

CCTrayTool salva i propri file nel profilo utente:

  Configurazione:     %LocalAppData%\CCTrayTool\CCTrayTool.ini
  File di log:        %LocalAppData%\CCTrayTool\CCTrayTool.log
  Cartella ToolTime:  %LocalAppData%\CCTrayTool\ToolTime\

Le regole di CloseGuard sono in un file dedicato:

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(Il percorso può essere incollato nella barra degli indirizzi di
Esplora risorse per accedere direttamente alla cartella.)


-------------------------------------------------------------------
 9. Chiudere il programma
-------------------------------------------------------------------

CCTrayTool viene chiuso tramite la voce di menu "Esci". In questo
modo viene ripristinato automaticamente il normale comportamento
di risparmio energetico di Windows e viene salvata la
configurazione attuale.

Tutte le finestre il cui pulsante di chiusura è bloccato da
CloseGuard riottengono così il proprio pulsante di chiusura.


-------------------------------------------------------------------
 10. Informazioni / Contatti
-------------------------------------------------------------------

La versione attualmente installata può essere consultata in
qualsiasi momento tramite la voce di menu "Informazioni".

CCTrayTool - Markus Debus
info@markus-debus.de
Licenza: GNU General Public License, versione 3 o successiva
(GPL-3.0-or-later), con una condizione aggiuntiva di attribuzione;
vedi i file LICENSE e NOTICE.



===================================================================
 CCTrayTool - Manual de usuario
===================================================================

CCTrayTool es una pequeña herramienta para Windows que se ejecuta
como un icono en la bandeja del sistema (abajo a la derecha, junto
al reloj). Combina cuatro funciones útiles en un solo programa:

  1. KeepAwake            - evita que el PC entre en modo de ahorro
                             de energía o que la pantalla se apague
  2. AlwaysOnTop           - mantiene cualquier ventana en primer
                             plano mediante una combinación de
                             teclas
  3. Inicio rápido de herramientas - inicia programas de uso
                             frecuente directamente desde el menú
                             de la bandeja del sistema
  4. CloseGuard            - bloquea el botón de cerrar (X) de
                             ventanas seleccionadas, con una
                             combinación de teclas o mediante
                             reglas

Todas las funciones se manejan mediante un menú de clic derecho
sobre el icono de la bandeja. No es necesaria ninguna instalación,
el programa se puede iniciar directamente.

CCTrayTool admite los idiomas inglés, alemán, italiano, español,
francés, polaco, húngaro y ruso.
El idioma se establece automáticamente según el idioma del sistema
del equipo.

Requisito del sistema: se necesita Windows 10 o posterior de 64
bits. El programa no funciona en Windows de 32 bits.

-------------------------------------------------------------------
 1. Inicio y primer icono
-------------------------------------------------------------------

Tras el inicio, aparece un icono en el área de la bandeja de la
barra de tareas de Windows. El color del icono muestra de
inmediato el estado actual de KeepAwake:

  - Blanco = KeepAwake desactivado (comportamiento normal de
             Windows)
  - Rojo   = KeepAwake activo para monitores
  - Azul   = KeepAwake activo para el sistema
  - Verde  = KeepAwake activo para monitores y sistema

Un clic con el botón derecho del ratón sobre el icono abre el menú
con todas las funciones. Si el icono no es visible, conviene
revisar el área de "iconos ocultos" (pequeña flecha en la barra de
tareas).

Nota: CCTrayTool solo puede iniciarse una vez a la vez. Un segundo
inicio no tiene ningún efecto si el programa ya se está
ejecutando.


-------------------------------------------------------------------
 2. KeepAwake - impedir el ahorro de energía
-------------------------------------------------------------------

En la sección de menú "KeepAwake" se puede seleccionar qué es lo
que el PC NO debe hacer mientras CCTrayTool está en ejecución:

  - Monitores y sistema
      Ni la pantalla se apaga ni el PC entra en modo de espera/
      ahorro de energía. Ideal para presentaciones o procesos de
      larga duración en los que la pantalla debe permanecer
      visible.

  - Monitores
      Solo la pantalla permanece encendida (sin apagado, sin
      protector de pantalla). El propio PC puede entrar en modo de
      espera igualmente tras su propio tiempo de espera.

  - Sistema
      El PC no entra en modo de espera/ahorro de energía, pero la
      pantalla puede apagarse según la configuración de Windows.
      Útil, por ejemplo, para descargas largas o cálculos en
      segundo plano.

  - Desactivado
      CCTrayTool no interviene; se aplica el comportamiento normal
      de ahorro de energía de Windows.

La opción de menú "Guardar estado" del submenú "Configuración" de
la sección KeepAwake hace que CCTrayTool recuerde la última
configuración de KeepAwake seleccionada y la restaure
automáticamente en el siguiente inicio.

Al cerrar CCTrayTool, el comportamiento normal de ahorro de energía
de Windows se restaura automáticamente.


-------------------------------------------------------------------
 3. AlwaysOnTop - mantener una ventana en primer plano
-------------------------------------------------------------------

La combinación de teclas MAYÚS + ALT + T (predeterminada) mantiene
de forma permanente la ventana actualmente activa en primer plano,
incluso al hacer clic en otras ventanas. Pulsarla de nuevo anula
esta fijación.

Al cambiar el estado, aparece brevemente un pequeño aviso cerca del
puntero del ratón que confirma si la ventana ahora "permanece en
primer plano" o ha vuelto a la "normalidad". Este aviso se puede
activar o desactivar mediante la opción de menú "Mostrar ToolTip".

En el menú "AlwaysOnTop" están disponibles las siguientes opciones:

  - Hotkey activo   Activa o desactiva por completo la combinación
                    de teclas
  - Configuración   Submenú (icono de engranaje) con las siguientes
                    entradas:
      - Cambiar hotkey    Abre un cuadro de diálogo en el que se
                          puede definir una combinación de teclas
                          personalizada (combinación de Ctrl, Alt,
                          Mayús, Win más una letra, un número o una
                          tecla de función F1-F12)
      - Mostrar ToolTip   Activa o desactiva el breve aviso en
                          pantalla al cambiar el estado

Nota: El propio escritorio de Windows ("Program Manager") no se
puede configurar como "siempre en primer plano". No todas las
combinaciones de teclas están libres; algunas ya están reservadas
por el sistema u otros programas. En ese caso aparece un aviso y
debe elegirse otra combinación.


-------------------------------------------------------------------
 4. CloseGuard - bloquear el botón de cerrar
-------------------------------------------------------------------

CloseGuard protege las ventanas contra un cierre accidental. En las
ventanas que usted elija, bloquea el botón de cerrar (la "X" de la
esquina superior derecha de la ventana): el botón aparece
desactivado y hacer clic en él no hace nada. Es útil para programas
que tienen que seguir ejecutándose o para ventanas que se cierran
por error una y otra vez.

Una ventana se puede bloquear de dos maneras:

  - A mano, con una combinación de teclas
      Haga clic en la ventana y pulse CTRL + ALT + X
      (predeterminada). El botón de cerrar de esta ventana queda
      bloqueado. Si vuelve a pulsar la combinación, se desbloquea.
      Una ventana desbloqueada de este modo sigue libre, aunque
      coincida con una regla, hasta que se cierre. Un breve aviso
      confirma cada cambio. El bloqueo dura hasta que la ventana se
      cierra o se desbloquea.

  - Automáticamente, con reglas
      Haga clic en la ventana y pulse CTRL + ALT + MAYÚS + X
      (predeterminada). CCTrayTool guarda en el archivo de reglas
      una regla formada por el título y la clase de la ventana y
      bloquea la ventana. A partir de ese momento, cada ventana que
      coincida con la regla se bloquea automáticamente en cuanto
      aparece, también después de reiniciar el programa o
      CCTrayTool.

En el menú de la bandeja, la sección "CloseGuard" ofrece estas
entradas:

  - Bloquear/desbloquear el botón de cerrar de la ventana activa
      Hace lo mismo que la primera combinación de teclas. Mientras
      el menú de la bandeja está abierto, el foco lo tiene el
      propio menú; por eso CloseGuard usa la ventana que estaba
      activa justo antes.

  - Crear regla para la ventana activa
      Hace lo mismo que la segunda combinación de teclas.

  - Mostrar ventanas bloqueadas
      Muestra qué ventanas están bloqueadas en este momento (por
      regla o a mano, con la clase de la ventana entre corchetes) y
      cuántas reglas hay.

Debajo, el submenú "Configuración" (icono de engranaje) contiene:

  - Comprobar automáticamente las ventanas nuevas
      Activado: CloseGuard vigila de forma continua y bloquea cada
      ventana nueva que coincida con una regla. Desactivado: las
      ventanas nuevas no se bloquean automáticamente.

  - Comprobar las ventanas abiertas al iniciar
      Activado: las ventanas que ya están abiertas cuando se inicia
      CCTrayTool se comparan de inmediato con las reglas.
      Desactivado: estas ventanas no se tocan; solo se comprueban
      las que se abran más tarde.

  - Minimizar la ventana al hacer clic en la X bloqueada
      Activado: un clic en el botón de cerrar atenuado minimiza la
      ventana en lugar de no hacer nada. Como con un botón real, la
      ventana solo se minimiza si el botón del ratón se suelta
      también sobre la X; pulsar el botón y desplazarse fuera
      cancela el clic. Desactivado (predeterminado): un clic no
      hace nada.

  - Cambiar hotkey: bloquear/desbloquear
    Cambiar hotkey: crear regla
      Abre el mismo cuadro de diálogo que en AlwaysOnTop para
      definir otra combinación de teclas. Se rechaza una
      combinación que ya use otra función de CCTrayTool.

  - Editar reglas...
      Abre el archivo de reglas en el Bloc de notas (véase más
      abajo). Tras guardar y cerrar el Bloc de notas, las reglas
      modificadas se aplican de inmediato: las ventanas bloqueadas
      por una regla que ya no coincide se desbloquean y las reglas
      nuevas se aplican enseguida a las ventanas abiertas.

CloseGuard en su conjunto se activa y desactiva con "Activar
CloseGuard" en el menú "Configuración" de la sección "CCTrayTool"
(véase la sección 7).

Reglas (archivo propio CloseGuardRules.ini, sección [Rules]):

Las reglas no están en el archivo de configuración, sino en un
archivo propio: %LocalAppData%\CCTrayTool\CloseGuardRules.ini. Se
crea automáticamente. Es un archivo Unicode, por lo que también
funcionan los títulos de ventana con diéresis, tildes u otros
caracteres especiales. El Bloc de notas conserva este formato; si
el archivo se edita con otro programa, guárdelo también como
Unicode (UTF-16); de lo contrario, los caracteres especiales
podrían perderse. Las reglas se vuelven a leer al cerrar el Bloc de
notas tras "Editar reglas..." y en cada inicio de CCTrayTool.

Cada línea es una regla con la forma  número=título|clase.  El
título es un texto que debe aparecer en algún lugar del título de
la ventana. La clase es el nombre técnico del tipo de ventana y
debe coincidir exactamente. Las mayúsculas y minúsculas no
importan. Una de las dos partes puede estar vacía (el "|" debe
permanecer); si ambas están rellenas, deben coincidir las dos.
Ejemplos:

  1=Calculator|       cada ventana con "Calculator" en el título
  2=|Notepad          cada ventana de la clase "Notepad"
  3=Untitled|Notepad  ventanas de la clase "Notepad" con "Untitled"
                      en el título

La combinación de teclas "crear regla" usa el título actual
completo de la ventana. Si el título cambia (por ejemplo, con el
nombre de un documento abierto), acórtelo después con "Editar
reglas..." a la parte que no cambia, o deje el título vacío y
conserve solo la clase. La clase de una ventana bloqueada se
muestra con "Mostrar ventanas bloqueadas". Una regla con título y
clase vacíos se ignora; se usan como máximo 200 reglas.

Ajustes en el archivo de configuración (sección [CloseGuard]):

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

  Enabled                  1 = CloseGuard activado, 0 = desactivado
                           (igual que la opción de menú "Activar
                           CloseGuard").
  HotkeyToggle             Combinación de teclas para
                           bloquear/desbloquear. ^ = Ctrl, ! = Alt,
                           + = Mayús, # = Win, seguido de la tecla.
                           Es más fácil cambiarla con la opción de
                           menú "Cambiar hotkey".
  HotkeyAddRule            Combinación de teclas para "crear
                           regla".
  ApplyOnStartup           1 = las ventanas abiertas al iniciar el
                           programa se comparan con las reglas,
                           0 = no se tocan.
  AutoApply                1 = las ventanas nuevas se comprueban
                           automáticamente, 0 = no.
  PollInterval             Con qué frecuencia se comprueban las
                           ventanas, en milisegundos: de 250 a 5000
                           (predeterminado: 500). Los demás valores
                           se corrigen automáticamente.
  MinimizeOnClick          1 = un clic en el botón de cerrar
                           bloqueado minimiza la ventana, 0 = no
                           hace nada (predeterminado). Equivale a
                           la opción de menú.
  ClickPollInterval        Con qué frecuencia se comprueba para
                           ello el botón del ratón, en
                           milisegundos: de 10 a 100
                           (predeterminado: 30). Un valor menor
                           detecta con más seguridad los clics muy
                           breves; uno mayor necesita menos tiempo
                           de cálculo. Los demás valores se
                           corrigen automáticamente. Para este
                           ajuste no hay opción de menú.
  ClickGeometryFallback    1 = si una ventana con barra de título
                           propia (por ejemplo, Outlook) no
                           comunica su X a Windows, la X se
                           reconoce por su posición
                           (predeterminado). 0 = solo se reconoce
                           una X que la propia ventana comunica.
  ClickGeometryExtendLeft  Hasta dónde llega hacia la izquierda el
                           área en la que la X se reconoce por su
                           posición, en porcentaje del ancho de la
                           X: de 0 a 100 (predeterminado: 0).
                           Algunos programas dibujan su X más a la
                           izquierda de lo que indica Windows. Un
                           valor demasiado grande llega hasta el
                           botón de maximizar contiguo.
  ClickGeometryExtendDown  Hasta dónde llega hacia abajo esa área,
                           en porcentaje de la altura de la X: de 0
                           a 100 (predeterminado: 87). Algunos
                           programas dibujan su X más abajo de lo
                           que indica Windows. Misma finalidad y
                           mismos límites que
                           ClickGeometryExtendLeft.
  ClickDebugOverlay        1 = muestra en pantalla, como
                           rectángulos de colores y transparentes,
                           las áreas que se usan para reconocer la
                           X: rojo = el área en la que un clic
                           cuenta como clic en la X, azul = el área
                           del botón de cerrar que indica Windows
                           (o, si Windows no indica ninguna, el
                           área de la X que se encontró preguntando
                           a la ventana), verde = el escudo sobre
                           la X (véase ClickShieldClasses). Solo
                           para la búsqueda de errores.
                           0 = desactivado (predeterminado).
  ClickShieldClasses       Clases de ventana (separadas por comas)
                           de programas que se cierran solos cuando
                           se suelta el botón del ratón, por
                           ejemplo Edge y Chrome
                           (Chrome_WidgetWin_1) y Firefox
                           (MozillaWindowClass); ambas son el valor
                           predeterminado. La X de esa ventana se
                           cubre con una ventana casi invisible que
                           recoge el clic, de modo que la ventana
                           ya no se puede cerrar con la X.
                           Vacío = ninguna.

Las dos combinaciones de teclas de CloseGuard y la de AlwaysOnTop
deben ser distintas entre sí. De lo contrario, se usan las
predeterminadas.

Conviene saber:

  - El bloqueo protege de un clic accidental en la X. Según el
    programa, una ventana aún puede cerrarse por otras vías: con
    ALT + F4, con "Cerrar ventana" en la barra de tareas, con una
    orden Salir del menú del propio programa o con el Administrador
    de tareas.

  - Solo se pueden bloquear ventanas con una barra de título normal
    y menú del sistema. Los programas que dibujan su propia barra
    de título (muchas aplicaciones modernas, algunos navegadores,
    aplicaciones de Microsoft Store) pueden conservar una X que
    funciona aunque CloseGuard indique que la ventana está
    bloqueada. Si una ventana no tiene menú del sistema, aparece un
    aviso.

  - Minimizar con un clic: CCTrayTool comprueba el botón del ratón
    de forma breve y regular (predeterminado: cada 30 ms), y solo
    mientras haya al menos una ventana bloqueada visible. No
    utiliza ningún gancho (hook) del ratón, por lo que no puede
    ralentizar el ratón ni el sistema. En el improbable caso de que
    un clic muy breve coincida con un momento en que CCTrayTool
    está ocupado, simplemente no se detecta: la ventana queda como
    está y su X sigue bloqueada.

  - Minimizar con un clic responde al botón principal del ratón (el
    derecho, si los botones están intercambiados en Windows) y solo
    a la X de las ventanas bloqueadas. La entrada táctil y con
    lápiz no se detecta. Si un programa ignora la orden de
    minimizar, CCTrayTool minimiza la ventana directamente.

  - Algunos programas dibujan su propia barra de título (por
    ejemplo, Outlook). No le indican a Windows dónde está su X, por
    lo que, para detectar el clic, CCTrayTool calcula la posición
    de la X en la esquina superior derecha de la ventana (clave INI
    ClickGeometryFallback). En el archivo de registro aparece
    entonces "recognized by its position".

  - Edge, Chrome y otros programas basados en Chromium, así como
    Firefox, dibujan su propia X y cierran la ventana por sí mismos
    cuando se suelta el botón del ratón, por lo que el menú de
    sistema bloqueado no los detiene. Sobre la X de esas ventanas
    (clave INI ClickShieldClasses, valor predeterminado
    Chrome_WidgetWin_1,MozillaWindowClass) CCTrayTool coloca una
    ventana casi invisible, un escudo. El clic cae en el escudo y
    el programa nunca lo ve: no ocurre nada, o la ventana se
    minimiza si minimizar al hacer clic está activado. El escudo
    sigue a la ventana y desaparece mientras la ventana está
    minimizada, desbloqueada, a pantalla completa o cubierta por
    otra ventana sobre su X. Con ClickDebugOverlay=1 se muestra en
    verde. Mientras una ventana de esa clase esté visible, el botón
    del ratón se comprueba cada 10 ms, incluso si minimizar al
    hacer clic está desactivado. Firefox dibuja su propia barra de
    título y Windows no comunica la posición de su X; CCTrayTool
    encuentra entonces la X preguntando a la ventana (archivo de
    registro: "found by asking the window"). El método alternativo
    por posición (ClickGeometryFallback) solo se usa para ventanas
    que no comunican su X a Windows, como Outlook y Word;
    CCTrayTool consulta cada ventana una vez y escribe el resultado
    en el archivo de registro ("probe of the X").

  - Las ventanas de programas que se ejecutan como administrador no
    se pueden bloquear mientras CCTrayTool no se ejecute también
    como administrador (una regla de seguridad de Windows). Aparece
    un aviso.

  - El escritorio, la barra de tareas y las ventanas del propio
    CCTrayTool nunca se bloquean.

  - Al desbloquear una ventana, su menú del sistema se restablece
    al estándar de Windows. Las entradas que el propio programa
    haya añadido a este menú pueden faltar hasta que se reinicie el
    programa.

  - Un bloqueo dura solo mientras CCTrayTool se está ejecutando: al
    cerrar el programa o al desactivar CloseGuard, todas las
    ventanas recuperan su botón de cerrar. Si CCTrayTool se termina
    a la fuerza (por ejemplo con el Administrador de tareas), las
    ventanas bloqueadas siguen bloqueadas. En ese caso, pulse en
    una de ellas la combinación para bloquear/desbloquear
    (CCTrayTool debe estar de nuevo en ejecución) o cierre la
    ventana y vuelva a abrirla.


-------------------------------------------------------------------
 5. Menú de inicio rápido para programas propios
-------------------------------------------------------------------

Encima de KeepAwake, el menú de la bandeja muestra la sección
"ToolTime": una lista de programas que se pueden iniciar con un
solo clic. Las entradas proceden de una carpeta de su PC (véase la
sección 6): cada acceso directo (archivo .lnk) de esta carpeta se
convierte en una entrada de menú y cada subcarpeta en un submenú.

De forma predeterminada ya hay varias herramientas integradas de
Windows configuradas, entre ellas:

  - Calculadora, Notepad  (carpeta "Office")
  - Explorer  (directamente en el menú principal)
  - Símbolo del sistema, Editor del registro, Configuración de
    red, Panel de control, Monitor de recursos, Monitor de
    rendimiento, Administrar servicios, Liberador de espacio en
    disco  (carpeta "Sistema")

Los accesos directos cuyo programa no se encuentra en el PC
correspondiente no aparecen automáticamente en el menú, por lo que
no se produce ningún mensaje de error si falta una herramienta en
un sistema.

Algunas entradas (p. ej., Símbolo del sistema, Editor del registro)
están configuradas para iniciarse automáticamente con derechos de
administrador (en este caso, Windows solicita confirmación mediante
el Control de cuentas de usuario).


-------------------------------------------------------------------
 6. Añadir herramientas y carpetas propias
-------------------------------------------------------------------

Las herramientas del menú de inicio rápido son simplemente accesos
directos en una carpeta. Para añadir una herramienta, seleccione en
el menú "Configuración" la opción "Abrir carpeta ToolTime" y coloque
un acceso directo (archivo .lnk) en la carpeta que se abre.
CCTrayTool detecta el cambio por sí mismo y actualiza el menú poco
después. (Si no ocurre, use "Recargar herramientas" en el menú
"Configuración".)

Una forma rápida de crear un acceso directo: arrastre un programa a
la carpeta con el botón derecho del ratón y elija "Crear accesos
directos aquí".

Carpeta predeterminada:  %LocalAppData%\CCTrayTool\ToolTime
(Se puede definir otra carpeta en el archivo de configuración,
véase más abajo.)

Cuando CCTrayTool crea la carpeta ToolTime, coloca también en ella
un breve archivo informativo ("ToolTime_Info.txt", en el idioma del
sistema). Explica brevemente los límites y cómo ordenar las
entradas con un número al principio. El menú ignora el archivo; se
puede eliminar en cualquier momento.

Cómo la carpeta se convierte en un menú:

  Acceso directo (.lnk)  se convierte en una entrada de menú. El
                         nombre es el nombre del archivo; el icono
                         es el del acceso directo (o, si no tiene,
                         el del programa al que apunta).
  Subcarpeta             se convierte en un submenú. Su icono se
                         puede cambiar como de costumbre en el
                         Explorador de Windows (Propiedades >
                         Personalizar > Cambiar icono).
  Orden                  Primero las carpetas y luego los accesos
                         directos, cada grupo ordenado
                         alfabéticamente. Para un orden propio,
                         empiece el nombre con dos o tres dígitos y
                         un guion bajo, p. ej. "01_Notepad.lnk". El
                         número solo sirve para ordenar y no se
                         muestra.
  Administrador          Active "Ejecutar como administrador" en
                         las propiedades del acceso directo (Acceso
                         directo > Opciones avanzadas). Windows
                         solicita confirmación al iniciar la
                         entrada.
  No se muestran         Archivos ocultos, archivos que no son
                         accesos directos, accesos directos cuyo
                         programa no existe y carpetas vacías.

Límites: para que el menú siga siendo manejable:

Un menú de la bandeja no se puede desplazar con la rueda del ratón,
solo con dos pequeños botones de flecha, y un menú largo empujaría
KeepAwake, AlwaysOnTop y la configuración fuera de la vista. Por
ello:

  - Se muestran como máximo 15 entradas (carpetas y accesos
    directos juntos) por menú. Este límite se puede cambiar en el
    archivo de configuración a un valor entre 10 y 20 (véase más
    abajo).
  - Como máximo 3 niveles de menú: el menú ToolTime más dos niveles
    de submenús. Las carpetas más profundas se ignoran.
  - Como máximo 400 entradas en total.

Consejo: agrupe muchas herramientas en subcarpetas en lugar de una
lista larga.

Si se supera un límite, no se pierde nada sin avisar:

  - Las entradas sobrantes no se muestran. En su lugar, el menú
    contiene una línea atenuada como "... 3 más no mostradas
    (límite 15)".
  - Aparece una notificación y la sección ToolTime muestra la
    entrada "(!) ToolTime: se encontraron problemas - haga clic
    para ver los detalles". Al hacer clic se indica exactamente
    qué se ignoró y por qué. La misma información se escribe en el
    archivo de registro (si "Crear archivo de registro" está
    activado).
  - Las carpetas anidadas a demasiada profundidad y los accesos
    directos que no se pueden leer se notifican del mismo modo.

Ajustes en el archivo de configuración (sección [ToolTime]):

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = mostrar ToolTime, 0 = ocultarlo (igual que la
               opción de menú "Activar ToolTime")
  MaxEntries   Número máximo de entradas por menú, de 10 a 20
               (predeterminado: 15). Los demás valores se
               corrigen automáticamente.
  Folder       Opcional: ruta de otra carpeta ToolTime. Se
               permiten variables de entorno como %USERPROFILE%.
               Vacío = carpeta predeterminada. Si la carpeta no
               existe, se crea.

Para editar el archivo, seleccione en el menú "Configuración" la
opción "Editar archivo de configuración". Tras guardar y cerrar el
Bloc de notas, CCTrayTool vuelve a leer el archivo, aplica todos
los cambios de inmediato (sin reiniciar) y reconstruye el menú.

Restaurar las herramientas predeterminadas: cierre CCTrayTool,
elimine la carpeta ToolTime y vuelva a iniciar el programa; las
herramientas predeterminadas y el archivo informativo se crean de
nuevo.


-------------------------------------------------------------------
 7. Configuración adicional
-------------------------------------------------------------------

En el submenú "Configuración" también están disponibles:

  - Activar ToolTime
      Activa o desactiva por completo toda la sección de inicio
      rápido de herramientas (véase la sección 5). Si se desactiva,
      ninguna de sus entradas aparece en el menú de la bandeja,
      independientemente de lo que haya en la carpeta ToolTime.

  - Abrir carpeta ToolTime
      Abre la carpeta ToolTime en el Explorador de Windows para
      añadir, renombrar o eliminar accesos directos (véase la
      sección 6).

  - Recargar herramientas
      Vuelve a leer la carpeta ToolTime y reconstruye el menú.
      Normalmente no es necesario, ya que los cambios en la
      carpeta se detectan automáticamente.

  - Activar KeepAwake
      Activa o desactiva por completo toda la sección KeepAwake
      (véase la sección 2). Si se desactiva, sus entradas
      desaparecen del menú de la bandeja y se aplica el
      comportamiento normal de ahorro de energía de Windows.

  - Activar AlwaysOnTop
      Activa o desactiva por completo toda la sección AlwaysOnTop
      (véase la sección 3). Si se desactiva, sus entradas
      desaparecen del menú de la bandeja y la combinación de teclas
      se desactiva.

  - Activar CloseGuard
      Activa o desactiva por completo toda la sección CloseGuard
      (véase la sección 4). Si se desactiva, sus entradas
      desaparecen del menú de la bandeja, las combinaciones de
      teclas se desactivan y todas las ventanas bloqueadas
      recuperan su botón de cerrar.

  - Iniciar automáticamente
      CCTrayTool se iniciará automáticamente al iniciar sesión en
      Windows a partir de ahora.

  - Crear archivo de registro
      Escribe un registro detallado de todas las acciones en un
      archivo de registro. Útil para la resolución de problemas, no
      es necesario en el funcionamiento normal.
      En el archivo de configuración es la entrada "UseLog" de la
      sección [Main]: 1 = activado; 0, una entrada vacía o
      inexistente o cualquier otro valor = desactivado.

  - Ver archivo de registro
      Abre el archivo de registro actual en el Bloc de notas.

  - Usar iconos grandes
      Muestra los iconos del menú de la bandeja más grandes (32 en
      lugar de 16 píxeles).

  - Editar archivo de configuración
      Abre el archivo de configuración directamente para su edición
      (véase la sección 6).


-------------------------------------------------------------------
 8. Ubicaciones de almacenamiento
-------------------------------------------------------------------

CCTrayTool guarda sus archivos en el perfil de usuario:

  Configuración:        %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Archivo de registro:  %LocalAppData%\CCTrayTool\CCTrayTool.log
  Carpeta ToolTime:     %LocalAppData%\CCTrayTool\ToolTime\

Las reglas de CloseGuard están en un archivo propio:

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(La ruta se puede pegar en la barra de direcciones del Explorador
de Windows para ir directamente a la carpeta.)


-------------------------------------------------------------------
 9. Cerrar el programa
-------------------------------------------------------------------

CCTrayTool se cierra mediante la opción de menú "Salir". Esto
restaura automáticamente el comportamiento normal de ahorro de
energía de Windows y guarda la configuración actual.

Todas las ventanas cuyo botón de cerrar está bloqueado por
CloseGuard recuperan así su botón de cerrar.


-------------------------------------------------------------------
 10. Acerca de / Contacto
-------------------------------------------------------------------

La versión actualmente instalada se puede consultar en cualquier
momento mediante la opción de menú "Acerca de".

CCTrayTool - Markus Debus
info@markus-debus.de
Licencia: GNU General Public License, versión 3 o posterior
(GPL-3.0-or-later), con una condición adicional de atribución;
véanse los archivos LICENSE y NOTICE.



===================================================================
 CCTrayTool - Guide d'utilisation
===================================================================

CCTrayTool est un petit outil Windows qui s'exécute sous forme
d'icône dans la zone de notification (en bas à droite, à côté de
l'horloge). Il regroupe quatre fonctions utiles en un seul
programme :

  1. KeepAwake             - empêche le PC de passer en mode
                              d'économie d'énergie ou l'écran de
                              s'éteindre
  2. AlwaysOnTop            - maintient une fenêtre au premier plan
                              via un raccourci clavier
  3. Démarrage rapide d'outils - lance directement les programmes
                              fréquemment utilisés depuis le menu
                              de la zone de notification
  4. CloseGuard             - verrouille le bouton de fermeture (X)
                              de fenêtres choisies, par raccourci
                              clavier ou par des règles

Toutes les fonctions se gèrent via un menu accessible par clic
droit sur l'icône de la zone de notification. Aucune installation
n'est nécessaire, le programme peut être lancé directement.

CCTrayTool prend en charge les langues anglais, allemand, italien,
espagnol, français, polonais, hongrois et russe.
La langue est définie automatiquement en fonction de la langue
système de l'ordinateur.

Configuration requise : une version 64 bits de Windows 10 ou plus
récente est nécessaire. Le programme ne fonctionne pas sous Windows
32 bits.

-------------------------------------------------------------------
 1. Démarrage et première icône
-------------------------------------------------------------------

Après le démarrage, une icône apparaît dans la zone de notification
de la barre des tâches Windows. La couleur de l'icône indique
immédiatement l'état actuel de KeepAwake :

  - Blanc = KeepAwake désactivé (comportement normal de Windows)
  - Rouge = KeepAwake actif pour les moniteurs
  - Bleu  = KeepAwake actif pour le système
  - Vert  = KeepAwake actif pour les moniteurs et le système

Un clic droit sur l'icône ouvre le menu avec toutes les fonctions.
Si l'icône n'est pas visible, vérifiez la zone des "icônes
masquées" (petite flèche dans la barre des tâches).

Remarque : CCTrayTool ne peut être démarré qu'une seule fois à la
fois. Un second démarrage n'a aucun effet si le programme est déjà
en cours d'exécution.


-------------------------------------------------------------------
 2. KeepAwake - empêcher la mise en veille
-------------------------------------------------------------------

Dans la section de menu "KeepAwake", vous pouvez sélectionner ce
que le PC ne doit PAS faire pendant que CCTrayTool est en cours
d'exécution :

  - Moniteurs et système
      Ni l'écran ne s'éteint, ni le PC ne passe en veille/mode
      d'économie d'énergie. Idéal pour les présentations ou les
      opérations de longue durée où l'écran doit rester visible.

  - Moniteurs
      Seul l'écran reste allumé (pas d'extinction, pas d'économiseur
      d'écran). Le PC lui-même peut néanmoins passer en veille
      après son propre délai.

  - Système
      Le PC ne passe pas en veille/mode d'économie d'énergie, mais
      l'écran peut tout de même s'éteindre selon les paramètres de
      Windows. Utile, par exemple, pour les téléchargements longs
      ou les calculs en arrière-plan.

  - Désactivé
      CCTrayTool n'intervient pas ; le comportement normal
      d'économie d'énergie de Windows s'applique.

L'option de menu "Enregistrer l'état" du sous-menu "Paramètres" de
la section KeepAwake permet à CCTrayTool de mémoriser le dernier
réglage KeepAwake sélectionné et de le restaurer automatiquement au
prochain démarrage.

À la fermeture de CCTrayTool, le comportement normal d'économie
d'énergie de Windows est automatiquement rétabli.


-------------------------------------------------------------------
 3. AlwaysOnTop - maintenir une fenêtre au premier plan
-------------------------------------------------------------------

Le raccourci clavier MAJ + ALT + T (par défaut) maintient de façon
permanente la fenêtre actuellement active au premier plan, même
lorsque d'autres fenêtres sont cliquées. Appuyer à nouveau dessus
annule cette fixation.

Lors du basculement, une petite notification apparaît brièvement
près du pointeur de la souris, confirmant si la fenêtre "reste au
premier plan" ou est "revenue à la normale". Cette notification
peut être activée ou désactivée via l'option de menu "Afficher
l'infobulle".

Le menu "AlwaysOnTop" propose les options suivantes :

  - Raccourci actif   Active ou désactive complètement le raccourci
                      clavier
  - Paramètres        Sous-menu (icône d'engrenage) avec les
                      entrées suivantes :
      - Modifier le raccourci   Ouvre une boîte de dialogue
                                permettant de définir un raccourci
                                clavier personnalisé (combinaison
                                de Ctrl, Alt, Maj, Win plus une
                                lettre, un chiffre ou une touche de
                                fonction F1-F12)
      - Afficher l'infobulle    Active ou désactive la brève
                                notification à l'écran lors du
                                basculement

Remarque : Le bureau Windows lui-même ("Program Manager") ne peut
pas être défini sur "toujours au premier plan". Toutes les
combinaisons de touches ne sont pas libres : certaines sont déjà
réservées par le système ou d'autres programmes. Dans ce cas, un
message apparaît et une autre combinaison doit être choisie.


-------------------------------------------------------------------
 4. CloseGuard - verrouiller le bouton de fermeture
-------------------------------------------------------------------

CloseGuard protège les fenêtres contre une fermeture accidentelle.
Pour les fenêtres que vous choisissez, il verrouille le bouton de
fermeture (le "X" en haut à droite de la fenêtre) : le bouton est
grisé et un clic dessus ne fait rien. C'est utile pour les
programmes qui doivent rester en cours d'exécution ou pour les
fenêtres qui sont sans cesse fermées par erreur.

Une fenêtre peut être verrouillée de deux façons :

  - À la main, avec un raccourci clavier
      Cliquez sur la fenêtre, puis appuyez sur CTRL + ALT + X (par
      défaut). Le bouton de fermeture de cette fenêtre est alors
      verrouillé. Un nouvel appui sur le raccourci le déverrouille.
      Une fenêtre déverrouillée ainsi reste libre, même si une
      règle correspond, jusqu'à sa fermeture. Une brève
      notification confirme chaque changement. Le verrouillage dure
      jusqu'à ce que la fenêtre soit fermée ou déverrouillée.

  - Automatiquement, avec des règles
      Cliquez sur la fenêtre, puis appuyez sur CTRL + ALT + MAJ + X
      (par défaut). CCTrayTool enregistre dans le fichier de règles
      une règle composée du titre et de la classe de la fenêtre, et
      verrouille la fenêtre. Dès lors, chaque fenêtre correspondant
      à la règle est verrouillée automatiquement dès qu'elle
      apparaît - même après un redémarrage du programme ou de
      CCTrayTool.

Dans le menu de la zone de notification, la section "CloseGuard"
propose ces entrées :

  - Verrouiller/déverrouiller le bouton de fermeture de la fenêtre
    active
      Fait la même chose que le premier raccourci clavier. Tant que
      le menu de la zone de notification est ouvert, c'est lui qui
      a le focus ; CloseGuard utilise donc la fenêtre qui était
      active juste avant.

  - Créer une règle pour la fenêtre active
      Fait la même chose que le deuxième raccourci clavier.

  - Afficher les fenêtres verrouillées
      Indique quelles fenêtres sont verrouillées en ce moment (par
      règle ou à la main, avec la classe de la fenêtre entre
      crochets) et combien de règles existent.

En dessous, le sous-menu "Paramètres" (icône d'engrenage) contient
:

  - Vérifier automatiquement les nouvelles fenêtres
      Activé : CloseGuard surveille en permanence et verrouille
      chaque nouvelle fenêtre correspondant à une règle. Désactivé
      : les nouvelles fenêtres ne sont pas verrouillées
      automatiquement.

  - Vérifier les fenêtres ouvertes au démarrage
      Activé : les fenêtres déjà ouvertes au démarrage de
      CCTrayTool sont comparées immédiatement aux règles. Désactivé
      : ces fenêtres sont laissées telles quelles ; seules les
      fenêtres ouvertes plus tard sont vérifiées.

  - Réduire la fenêtre au clic sur le X verrouillé
      Activé : un clic sur le bouton de fermeture grisé réduit la
      fenêtre au lieu de ne rien faire. Comme avec un vrai bouton,
      la fenêtre n'est réduite que si le bouton de la souris est
      aussi relâché sur le X ; appuyer sur le bouton puis
      s'éloigner annule le clic. Désactivé (par défaut) : un clic
      ne fait rien.

  - Modifier le raccourci : verrouiller/déverrouiller
    Modifier le raccourci : créer une règle
      Ouvre la même boîte de dialogue que pour AlwaysOnTop afin de
      définir un autre raccourci clavier. Une combinaison déjà
      utilisée par une autre fonction de CCTrayTool est refusée.

  - Modifier les règles...
      Ouvre le fichier de règles dans le Bloc-notes (voir
      ci-dessous). Après l'enregistrement et la fermeture du
      Bloc-notes, les règles modifiées sont appliquées aussitôt :
      les fenêtres verrouillées par une règle qui ne correspond
      plus sont déverrouillées, et les nouvelles règles
      s'appliquent tout de suite aux fenêtres ouvertes.

CloseGuard dans son ensemble s'active et se désactive avec "Activer
CloseGuard" dans le menu "Paramètres" de la section "CCTrayTool"
(voir section 7).

Règles (fichier dédié CloseGuardRules.ini, section [Rules]) :

Les règles ne sont pas dans le fichier de configuration, mais dans
un fichier dédié : %LocalAppData%\CCTrayTool\CloseGuardRules.ini.
Il est créé automatiquement. C'est un fichier Unicode ; les titres
de fenêtre contenant des accents ou d'autres caractères spéciaux
fonctionnent donc aussi. Le Bloc-notes conserve ce format ; si le
fichier est modifié avec un autre programme, enregistrez-le
également en Unicode (UTF-16), sinon des caractères spéciaux
peuvent être perdus. Les règles sont relues à la fermeture du
Bloc-notes après "Modifier les règles..." et à chaque démarrage de
CCTrayTool.

Chaque ligne est une règle de la forme  numéro=titre|classe.  Le
titre est un texte qui doit apparaître quelque part dans le titre
de la fenêtre. La classe est le nom technique du type de fenêtre et
doit correspondre exactement. La casse n'a pas d'importance. L'une
des deux parties peut être vide (le "|" doit rester) ; si les deux
sont renseignées, les deux doivent correspondre. Exemples :

  1=Calculator|       chaque fenêtre dont le titre contient
                      "Calculator"
  2=|Notepad          chaque fenêtre de la classe "Notepad"
  3=Untitled|Notepad  fenêtres de la classe "Notepad" dont le titre
                      contient "Untitled"

Le raccourci "créer une règle" utilise le titre actuel complet de
la fenêtre. Si le titre change (par exemple avec le nom d'un
document ouvert), raccourcissez-le ensuite avec "Modifier les
règles..." à la partie qui reste identique, ou laissez le titre
vide et ne gardez que la classe. La classe d'une fenêtre
verrouillée est indiquée par "Afficher les fenêtres verrouillées".
Une règle dont le titre et la classe sont vides est ignorée ; 200
règles au maximum sont utilisées.

Paramètres dans le fichier de configuration (section [CloseGuard])
:

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

  Enabled                  1 = CloseGuard activé, 0 = désactivé
                           (comme l'option de menu "Activer
                           CloseGuard").
  HotkeyToggle             Raccourci clavier pour
                           verrouiller/déverrouiller. ^ = Ctrl,
                           ! = Alt, + = Maj, # = Win, suivi de la
                           touche. Il est plus simple de le
                           modifier avec l'option de menu "Modifier
                           le raccourci".
  HotkeyAddRule            Raccourci clavier pour "créer une
                           règle".
  ApplyOnStartup           1 = les fenêtres ouvertes au démarrage
                           du programme sont comparées aux règles,
                           0 = elles sont laissées telles quelles.
  AutoApply                1 = les nouvelles fenêtres sont
                           vérifiées automatiquement, 0 = non.
  PollInterval             Fréquence de vérification des fenêtres,
                           en millisecondes : de 250 à 5000 (par
                           défaut : 500). Les autres valeurs sont
                           corrigées automatiquement.
  MinimizeOnClick          1 = un clic sur le bouton de fermeture
                           verrouillé réduit la fenêtre, 0 = il ne
                           fait rien (par défaut). Équivaut à
                           l'option de menu.
  ClickPollInterval        Fréquence à laquelle le bouton de la
                           souris est vérifié pour cela, en
                           millisecondes : de 10 à 100 (par défaut
                           : 30). Une valeur plus petite détecte
                           plus sûrement les clics très brefs, une
                           valeur plus grande demande moins de
                           temps de calcul. Les autres valeurs sont
                           corrigées automatiquement. Ce réglage
                           n'a pas d'option de menu.
  ClickGeometryFallback    1 = si une fenêtre avec sa propre barre
                           de titre (par exemple Outlook) ne
                           signale pas son X à Windows, le X est
                           reconnu d'après sa position (par
                           défaut). 0 = seul un X que la fenêtre
                           signale elle-même est reconnu.
  ClickGeometryExtendLeft  Jusqu'où la zone dans laquelle le X est
                           reconnu d'après sa position s'étend vers
                           la gauche, en pourcentage de la largeur
                           du X : de 0 à 100 (par défaut : 0).
                           Certains programmes dessinent leur X
                           plus à gauche que ne l'indique Windows.
                           Une valeur trop grande empiète sur le
                           bouton d'agrandissement voisin.
  ClickGeometryExtendDown  Jusqu'où cette zone s'étend vers le bas,
                           en pourcentage de la hauteur du X : de 0
                           à 100 (par défaut : 87). Certains
                           programmes dessinent leur X plus bas que
                           ne l'indique Windows. Même objet et
                           mêmes limites que
                           ClickGeometryExtendLeft.
  ClickDebugOverlay        1 = affiche à l'écran, sous forme de
                           rectangles colorés et transparents, les
                           zones utilisées pour reconnaître le X :
                           rouge = la zone dans laquelle un clic
                           compte comme un clic sur le X, bleu = la
                           zone du bouton de fermeture indiquée par
                           Windows (ou, si Windows n'en indique
                           aucune, la zone du X trouvée en
                           interrogeant la fenêtre), vert = le
                           bouclier au-dessus du X (voir
                           ClickShieldClasses). Uniquement pour le
                           dépannage. 0 = désactivé (par défaut).
  ClickShieldClasses       Classes de fenêtres (séparées par des
                           virgules) de programmes qui se ferment
                           eux-mêmes lorsque le bouton de la souris
                           est relâché, par exemple Edge et Chrome
                           (Chrome_WidgetWin_1) et Firefox
                           (MozillaWindowClass) ; les deux sont la
                           valeur par défaut. Le X d'une telle
                           fenêtre est recouvert par une fenêtre
                           presque invisible qui intercepte le clic
                           ; la fenêtre ne peut alors plus être
                           fermée avec le X. Vide = aucune.

Les deux raccourcis de CloseGuard et celui d'AlwaysOnTop doivent
être différents les uns des autres. Sinon, les raccourcis par
défaut sont utilisés à la place.

Bon à savoir :

  - Le verrouillage protège contre un clic accidentel sur le X.
    Selon le programme, une fenêtre peut encore être fermée
    d'autres façons : avec ALT + F4, avec "Fermer la fenêtre" dans
    la barre des tâches, avec une commande Quitter dans le menu du
    programme ou avec le Gestionnaire des tâches.

  - Seules les fenêtres dotées d'une barre de titre normale et d'un
    menu système peuvent être verrouillées. Les programmes qui
    dessinent eux-mêmes leur barre de titre (de nombreuses
    applications modernes, certains navigateurs, les applications
    du Microsoft Store) peuvent conserver un X fonctionnel même si
    CloseGuard signale la fenêtre comme verrouillée. Si une fenêtre
    n'a aucun menu système, un avis s'affiche.

  - Réduction par clic : CCTrayTool vérifie brièvement et
    régulièrement le bouton de la souris (par défaut : toutes les
    30 ms), et seulement tant qu'au moins une fenêtre verrouillée
    est visible. Il n'utilise aucun hook de souris et ne peut donc
    ralentir ni la souris ni le système. Dans le cas improbable où
    un clic très bref tombe à un moment où CCTrayTool est occupé,
    il n'est simplement pas détecté : la fenêtre reste telle quelle
    et son X reste verrouillé.

  - La réduction par clic réagit au bouton principal de la souris
    (le droit si les boutons sont inversés dans Windows) et
    uniquement au X des fenêtres verrouillées. La saisie tactile et
    au stylet n'est pas détectée. Si un programme ignore la
    commande de réduction, CCTrayTool réduit la fenêtre
    directement.

  - Certains programmes dessinent eux-mêmes leur barre de titre
    (par exemple Outlook). Ils n'indiquent pas à Windows où se
    trouve leur X ; pour la détection du clic, CCTrayTool calcule
    donc la position du X dans le coin supérieur droit de la
    fenêtre (clé INI ClickGeometryFallback). Le fichier journal
    indique alors "recognized by its position".

  - Edge, Chrome et d'autres programmes basés sur Chromium ainsi
    que Firefox dessinent eux-mêmes leur X et ferment la fenêtre
    eux-mêmes lorsque le bouton de la souris est relâché ; le menu
    système verrouillé ne les arrête donc pas. Au-dessus du X de
    ces fenêtres (clé INI ClickShieldClasses, valeur par défaut
    Chrome_WidgetWin_1,MozillaWindowClass), CCTrayTool place une
    fenêtre presque invisible, un bouclier. Le clic tombe sur le
    bouclier et le programme ne le voit jamais : rien ne se passe,
    ou la fenêtre est réduite si la réduction au clic est activée.
    Le bouclier suit la fenêtre et disparaît tant que la fenêtre
    est réduite, déverrouillée, en plein écran ou recouverte par
    une autre fenêtre au niveau de son X. Avec ClickDebugOverlay=1,
    il s'affiche en vert. Tant qu'une fenêtre de cette classe est
    visible, le bouton de la souris est vérifié toutes les 10 ms,
    même si la réduction au clic est désactivée. Firefox dessine
    lui-même sa barre de titre et Windows ne signale pas la
    position de son X ; CCTrayTool trouve alors le X en
    interrogeant la fenêtre (fichier journal :
    "found by asking the window"). La reconnaissance de secours par
    la position (ClickGeometryFallback) n'est utilisée que pour les
    fenêtres qui ne signalent pas leur X à Windows, comme Outlook
    et Word ; CCTrayTool interroge chaque fenêtre une fois et
    inscrit le résultat dans le fichier journal ("probe of the X").

  - Les fenêtres des programmes exécutés en tant qu'administrateur
    ne peuvent pas être verrouillées tant que CCTrayTool ne
    s'exécute pas lui-même en tant qu'administrateur (une règle de
    sécurité de Windows). Un avis s'affiche.

  - Le bureau, la barre des tâches et les fenêtres de CCTrayTool
    lui-même ne sont jamais verrouillés.

  - Lorsqu'une fenêtre est déverrouillée, son menu système est
    rétabli au standard de Windows. Les entrées que le programme
    avait lui-même ajoutées à ce menu peuvent manquer jusqu'au
    redémarrage du programme.

  - Un verrouillage ne dure que tant que CCTrayTool est en cours
    d'exécution : à la fermeture du programme ou à la désactivation
    de CloseGuard, toutes les fenêtres retrouvent leur bouton de
    fermeture. Si CCTrayTool est arrêté de force (par exemple avec
    le Gestionnaire des tâches), les fenêtres verrouillées restent
    verrouillées. Dans ce cas, appuyez dans une telle fenêtre sur
    le raccourci verrouiller/déverrouiller (CCTrayTool doit de
    nouveau être en cours d'exécution) ou fermez la fenêtre et
    rouvrez-la.


-------------------------------------------------------------------
 5. Menu de démarrage rapide pour vos propres programmes
-------------------------------------------------------------------

Au-dessus de KeepAwake, le menu de la zone de notification affiche
la section "ToolTime" : une liste de programmes que l'on peut
démarrer d'un simple clic. Les entrées proviennent d'un dossier de
votre PC (voir section 6) : chaque raccourci (fichier .lnk) de ce
dossier devient une entrée de menu et chaque sous-dossier devient
un sous-menu.

Par défaut, plusieurs outils intégrés de Windows sont déjà
configurés, notamment :

  - Calculatrice, Notepad  (dossier "Office")
  - Explorer  (directement dans le menu principal)
  - Invite de commandes, Éditeur du registre, Paramètres réseau,
    Panneau de configuration, Moniteur de ressources, Analyseur
    de performances, Gérer les services, Nettoyage de disque
    (dossier "Système")

Les raccourcis dont le programme est introuvable sur le PC concerné
n'apparaissent automatiquement pas dans le menu - aucun message
d'erreur ne s'affiche donc si un outil manque sur un système.

Certaines entrées (p. ex. Invite de commandes, Éditeur du registre)
sont configurées pour démarrer automatiquement avec les droits
d'administrateur (dans ce cas, Windows demande une confirmation via
le Contrôle de compte d'utilisateur).


-------------------------------------------------------------------
 6. Ajouter ses propres outils et dossiers
-------------------------------------------------------------------

Les outils du menu de démarrage rapide sont de simples raccourcis
placés dans un dossier. Pour ajouter un outil, sélectionnez dans le
menu "Paramètres" l'option "Ouvrir le dossier ToolTime" et placez un
raccourci (fichier .lnk) dans le dossier qui s'ouvre. CCTrayTool
remarque lui-même la modification et met à jour le menu peu après.
(Si ce n'est pas le cas, utilisez "Recharger les outils" dans le
menu "Paramètres".)

Pour créer rapidement un raccourci : faites glisser un programme
dans le dossier avec le bouton droit de la souris et choisissez
"Créer des raccourcis ici".

Dossier par défaut :  %LocalAppData%\CCTrayTool\ToolTime
(Un autre dossier peut être défini dans le fichier de paramètres,
voir ci-dessous.)

Lorsque CCTrayTool crée le dossier ToolTime, il y place aussi un
court fichier d'information ("ToolTime_Info.txt", dans la langue du
système). Il explique brièvement les limites et comment trier les
entrées à l'aide d'un nombre placé devant le nom. Le menu ignore ce
fichier ; il peut être supprimé à tout moment.

Comment le dossier devient un menu :

  Raccourci (.lnk)  devient une entrée de menu. Le nom est celui
                    du fichier ; l'icône est celle du raccourci
                    (ou, à défaut, celle du programme ciblé).
  Sous-dossier      devient un sous-menu. Son icône peut être
                    modifiée comme d'habitude dans l'Explorateur
                    Windows (Propriétés > Personnaliser >
                    Changer d'icône).
  Ordre             D'abord les dossiers, puis les raccourcis,
                    chacun trié par ordre alphabétique. Pour un
                    ordre personnalisé, faites commencer le nom par
                    deux ou trois chiffres et un trait de
                    soulignement, p. ex. "01_Notepad.lnk". Le
                    nombre ne sert qu'au tri et n'est pas affiché.
  Administrateur    Activez "Exécuter en tant qu'administrateur"
                    dans les propriétés du raccourci (Raccourci >
                    Avancé). Windows demande alors une
                    confirmation au démarrage de l'entrée.
  Non affichés      Fichiers masqués, fichiers qui ne sont pas des
                    raccourcis, raccourcis dont le programme
                    n'existe pas et dossiers vides.

Limites - pour que le menu reste utilisable :

Un menu de la zone de notification ne peut pas être défilé avec la
molette de la souris, uniquement avec deux petits boutons fléchés,
et un menu long repousserait KeepAwake, AlwaysOnTop et les
paramètres hors de la zone visible. C'est pourquoi :

  - Au maximum 15 entrées (dossiers et raccourcis confondus) sont
    affichées par menu. Cette limite peut être modifiée dans le
    fichier de paramètres, avec une valeur comprise entre 10 et 20
    (voir ci-dessous).
  - Au maximum 3 niveaux de menu : le menu ToolTime plus deux
    niveaux de sous-menus. Les dossiers plus profonds sont ignorés.
  - Au maximum 400 entrées au total.

Conseil : regroupez de nombreux outils dans des sous-dossiers
plutôt que dans une longue liste.

Si une limite est dépassée, rien n'est perdu sans que vous le
sachiez :

  - Les entrées en trop ne sont pas affichées. À la place, le menu
    contient une ligne grisée du type "... 3 autres non affichés
    (limite 15)".
  - Une notification apparaît et la section ToolTime affiche
    l'entrée "(!) ToolTime : problèmes détectés - cliquer pour les
    détails". Un clic dessus indique précisément ce qui a été
    ignoré et pourquoi. Les mêmes informations sont écrites dans le
    fichier journal (si "Créer un fichier journal" est activé).
  - Les dossiers imbriqués trop profondément et les raccourcis qui
    ne peuvent pas être lus sont signalés de la même manière.

Paramètres dans le fichier de paramètres (section [ToolTime]) :

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = afficher ToolTime, 0 = le masquer (comme
               l'option de menu "Activer ToolTime")
  MaxEntries   Nombre maximal d'entrées par menu, de 10 à 20
               (par défaut : 15). Les autres valeurs sont
               corrigées automatiquement.
  Folder       Facultatif : chemin d'un autre dossier ToolTime.
               Les variables d'environnement comme %USERPROFILE%
               sont autorisées. Vide = dossier par défaut. Si le
               dossier n'existe pas, il est créé.

Pour modifier le fichier, sélectionnez dans le menu "Paramètres"
l'option "Modifier le fichier de paramètres". Après avoir
enregistré et fermé le Bloc-notes, CCTrayTool relit le fichier,
applique immédiatement toutes les modifications (sans redémarrage)
et reconstruit le menu.

Rétablir les outils par défaut : quittez CCTrayTool, supprimez le
dossier ToolTime et redémarrez le programme - les outils par défaut
et le fichier d'information sont recréés.


-------------------------------------------------------------------
 7. Autres paramètres
-------------------------------------------------------------------

Le sous-menu "Paramètres" propose également :

  - Activer ToolTime
      Active ou désactive entièrement la section de démarrage
      rapide des outils (voir section 5). Si désactivée, aucune de
      ses entrées n'apparaît dans le menu de la zone de
      notification, quel que soit le contenu du dossier ToolTime.

  - Ouvrir le dossier ToolTime
      Ouvre le dossier ToolTime dans l'Explorateur Windows afin
      d'ajouter, de renommer ou de supprimer des raccourcis (voir
      section 6).

  - Recharger les outils
      Relit le dossier ToolTime et reconstruit le menu. Normalement
      inutile, car les modifications du dossier sont détectées
      automatiquement.

  - Activer KeepAwake
      Active ou désactive entièrement la section KeepAwake (voir
      section 2). Si désactivée, ses entrées disparaissent du menu
      de la zone de notification et le comportement normal
      d'économie d'énergie de Windows s'applique.

  - Activer AlwaysOnTop
      Active ou désactive entièrement la section AlwaysOnTop (voir
      section 3). Si désactivée, ses entrées disparaissent du menu
      de la zone de notification et le raccourci clavier est
      désactivé.

  - Activer CloseGuard
      Active ou désactive entièrement toute la section CloseGuard
      (voir section 4). Si elle est désactivée, ses entrées
      disparaissent du menu de la zone de notification, les
      raccourcis clavier sont désactivés et toutes les fenêtres
      verrouillées retrouvent leur bouton de fermeture.

  - Démarrage automatique
      CCTrayTool démarrera désormais automatiquement à l'ouverture
      de session Windows.

  - Créer un fichier journal
      Écrit un journal détaillé de toutes les actions dans un
      fichier journal. Utile pour le dépannage, non nécessaire en
      fonctionnement normal.
      Dans le fichier de paramètres, il s'agit de l'entrée "UseLog"
      de la section [Main] : 1 = activé ; 0, une entrée vide ou
      absente ou toute autre valeur = désactivé.

  - Afficher le fichier journal
      Ouvre le fichier journal actuel dans le Bloc-notes.

  - Utiliser de grandes icônes
      Affiche les icônes du menu de la zone de notification en plus
      grand (32 au lieu de 16 pixels).

  - Modifier le fichier de paramètres
      Ouvre directement le fichier de configuration pour
      modification (voir section 6).


-------------------------------------------------------------------
 8. Emplacements de stockage
-------------------------------------------------------------------

CCTrayTool enregistre ses fichiers dans le profil utilisateur :

  Configuration :     %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Fichier journal :   %LocalAppData%\CCTrayTool\CCTrayTool.log
  Dossier ToolTime :  %LocalAppData%\CCTrayTool\ToolTime\

Les règles de CloseGuard se trouvent dans un fichier dédié :

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(Le chemin peut être collé dans la barre d'adresse de l'Explorateur
Windows pour accéder directement au dossier.)


-------------------------------------------------------------------
 9. Fermer le programme
-------------------------------------------------------------------

CCTrayTool se ferme via l'option de menu "Quitter". Cela restaure
automatiquement le comportement normal d'économie d'énergie de
Windows et enregistre la configuration actuelle.

Toutes les fenêtres dont le bouton de fermeture est verrouillé par
CloseGuard retrouvent ainsi leur bouton de fermeture.


-------------------------------------------------------------------
 10. À propos / Contact
-------------------------------------------------------------------

La version actuellement installée peut être consultée à tout
moment via l'option de menu "À propos".

CCTrayTool - Markus Debus
info@markus-debus.de
Licence : GNU General Public License, version 3 ou ultérieure
(GPL-3.0-or-later), avec une condition supplémentaire d'attribution
; voir les fichiers LICENSE et NOTICE.



===================================================================
 CCTrayTool - Instrukcja obsługi
===================================================================

CCTrayTool to małe narzędzie dla systemu Windows, które działa jako
ikona w zasobniku systemowym (w prawym dolnym rogu, obok zegara).
Łączy cztery przydatne funkcje w jednym programie:

  1. KeepAwake           - zapobiega przechodzeniu komputera w tryb
                            oszczędzania energii lub wyłączaniu się
                            ekranu
  2. AlwaysOnTop          - utrzymuje dowolne okno na pierwszym
                            planie za pomocą skrótu klawiszowego
  3. Szybkie uruchamianie narzędzi - uruchamia często używane
                            programy bezpośrednio z menu zasobnika
  4. CloseGuard           - blokuje przycisk zamykania (X)
                            wybranych okien za pomocą skrótu
                            klawiszowego lub reguł

Wszystkie funkcje obsługuje się za pomocą menu wywoływanego
kliknięciem prawym przyciskiem myszy na ikonie w zasobniku.
Instalacja nie jest wymagana, program można uruchomić bezpośrednio.

CCTrayTool obsługuje języki: angielski, niemiecki, włoski,
hiszpański, francuski, polski, węgierski i rosyjski.
Język jest ustawiany automatycznie na podstawie języka systemowego
komputera.

Wymagania systemowe: wymagany jest 64-bitowy system Windows 10 lub
nowszy. Program nie działa w 32-bitowym systemie Windows.

-------------------------------------------------------------------
 1. Uruchomienie i pierwsza ikona
-------------------------------------------------------------------

Po uruchomieniu w obszarze zasobnika paska zadań Windows pojawia
się ikona. Kolor ikony od razu pokazuje aktualny stan KeepAwake:

  - Biały     = KeepAwake wyłączone (normalne zachowanie Windows)
  - Czerwony  = KeepAwake aktywne dla monitorów
  - Niebieski = KeepAwake aktywne dla systemu
  - Zielony   = KeepAwake aktywne dla monitorów i systemu

Kliknięcie prawym przyciskiem myszy na ikonę otwiera menu ze
wszystkimi funkcjami. Jeśli ikona nie jest widoczna, warto sprawdzić
obszar "ukrytych ikon" (mała strzałka na pasku zadań).

Uwaga: CCTrayTool można uruchomić tylko raz jednocześnie. Ponowne
uruchomienie nie ma żadnego efektu, jeśli program już działa.


-------------------------------------------------------------------
 2. KeepAwake - blokowanie oszczędzania energii
-------------------------------------------------------------------

W sekcji menu "KeepAwake" można wybrać, czego komputer NIE powinien
robić, gdy CCTrayTool jest uruchomiony:

  - Monitory i system
      Ani ekran się nie wyłącza, ani komputer nie przechodzi w tryb
      wstrzymania/oszczędzania energii. Idealne do prezentacji lub
      długotrwałych procesów, podczas których ekran musi pozostać
      widoczny.

  - Monitory
      Wyłącznie ekran pozostaje włączony (brak wyłączania, brak
      wygaszacza ekranu). Sam komputer może mimo to przejść w tryb
      wstrzymania po swoim własnym czasie oczekiwania.

  - System
      Komputer nie przechodzi w tryb wstrzymania/oszczędzania
      energii, ale ekran może się mimo to wyłączyć zgodnie z
      ustawieniami Windows. Przydatne np. przy długich pobieraniach
      lub obliczeniach w tle.

  - Wyłączone
      CCTrayTool nie ingeruje; obowiązuje normalne zachowanie
      oszczędzania energii Windows.

Opcja menu "Zapisz stan" w podmenu "Ustawienia" sekcji KeepAwake
powoduje, że CCTrayTool zapamiętuje ostatnio wybrane ustawienie
KeepAwake i przywraca je automatycznie przy następnym uruchomieniu.

Po zamknięciu CCTrayTool automatycznie przywracane jest normalne
zachowanie oszczędzania energii Windows.


-------------------------------------------------------------------
 3. AlwaysOnTop - utrzymywanie okna na pierwszym planie
-------------------------------------------------------------------

Skrót klawiszowy SHIFT + ALT + T (domyślny) trwale utrzymuje
aktualnie aktywne okno na pierwszym planie - nawet gdy klikane są
inne okna. Ponowne naciśnięcie znosi to przypięcie.

Podczas przełączania w pobliżu kursora myszy pojawia się na chwilę
mały komunikat potwierdzający, czy okno "pozostaje na pierwszym
planie", czy "wróciło do normalnego" stanu. Ten komunikat można
włączyć lub wyłączyć za pomocą opcji menu "Pokaż dymek".

W menu "AlwaysOnTop" dostępne są następujące opcje:

  - Skrót aktywny   Całkowicie włącza lub wyłącza skrót klawiszowy
  - Ustawienia      Podmenu (ikona zębatki) z następującymi
                    pozycjami:
      - Zmień skrót   Otwiera okno dialogowe, w którym można
                      ustawić własny skrót klawiszowy (kombinacja
                      Ctrl, Alt, Shift, Win oraz litery, cyfry lub
                      klawisza funkcyjnego F1-F12)
      - Pokaż dymek   Włącza lub wyłącza krótki komunikat na
                      ekranie podczas przełączania

Uwaga: Samego pulpitu Windows ("Program Manager") nie można ustawić
na "zawsze na wierzchu". Nie każda kombinacja klawiszy jest wolna -
niektóre są już zajęte przez system lub inne programy. W takim
przypadku pojawia się komunikat i należy wybrać inną kombinację.


-------------------------------------------------------------------
 4. CloseGuard - blokowanie przycisku zamykania
-------------------------------------------------------------------

CloseGuard chroni okna przed przypadkowym zamknięciem. Dla
wybranych okien blokuje przycisk zamykania (znak "X" w prawym
górnym rogu okna): przycisk jest wyszarzony, a kliknięcie go nic
nie daje. Jest to przydatne w przypadku programów, które muszą
stale działać, oraz okien, które wciąż są zamykane przez pomyłkę.

Okno można zablokować na dwa sposoby:

  - Ręcznie, za pomocą skrótu klawiszowego
      Kliknij okno, a następnie naciśnij CTRL + ALT + X (ustawienie
      domyślne). Przycisk zamykania tego okna zostaje zablokowany.
      Ponowne naciśnięcie skrótu odblokowuje go. Okno odblokowane w
      ten sposób pozostaje wolne, nawet jeśli pasuje do reguły, aż
      do zamknięcia. Krótki komunikat potwierdza każdą zmianę.
      Blokada trwa do zamknięcia lub odblokowania okna.

  - Automatycznie, za pomocą reguł
      Kliknij okno, a następnie naciśnij CTRL + ALT + SHIFT + X
      (ustawienie domyślne). CCTrayTool zapisuje w pliku reguł
      regułę składającą się z tytułu i klasy okna i blokuje okno.
      Od tej chwili każde okno pasujące do reguły jest blokowane
      automatycznie, gdy tylko się pojawi - także po ponownym
      uruchomieniu programu lub CCTrayTool.

W menu zasobnika sekcja "CloseGuard" oferuje następujące pozycje:

  - Zablokuj/odblokuj przycisk zamykania aktywnego okna
      Robi to samo co pierwszy skrót klawiszowy. Dopóki menu
      zasobnika jest otwarte, to ono ma fokus; dlatego CloseGuard
      używa okna, które było aktywne tuż przed tym.

  - Utwórz regułę dla aktywnego okna
      Robi to samo co drugi skrót klawiszowy.

  - Pokaż zablokowane okna
      Pokazuje, które okna są obecnie zablokowane (przez regułę lub
      ręcznie, z klasą okna w nawiasach kwadratowych) oraz ile jest
      reguł.

Pod nimi znajduje się podmenu "Ustawienia" (ikona zębatki), które
zawiera:

  - Automatycznie sprawdzaj nowe okna
      Włączone: CloseGuard stale obserwuje i blokuje każde nowe
      okno pasujące do reguły. Wyłączone: nowe okna nie są
      blokowane automatycznie.

  - Sprawdzaj okna otwarte przy uruchomieniu
      Włączone: okna, które są już otwarte w chwili uruchomienia
      CCTrayTool, są od razu porównywane z regułami. Wyłączone: te
      okna pozostają nietknięte; sprawdzane są tylko okna otwarte
      później.

  - Minimalizuj okno po kliknięciu zablokowanego X
      Włączone: kliknięcie wyszarzonego przycisku zamykania
      minimalizuje okno zamiast nie robić nic. Tak jak przy
      prawdziwym przycisku, okno jest minimalizowane tylko wtedy,
      gdy przycisk myszy zostanie zwolniony również nad X;
      naciśnięcie przycisku i odsunięcie kursora anuluje
      kliknięcie. Wyłączone (domyślnie): kliknięcie nic nie robi.

  - Zmień skrót: zablokuj/odblokuj
    Zmień skrót: utwórz regułę
      Otwiera to samo okno dialogowe co w AlwaysOnTop, aby ustawić
      inny skrót klawiszowy. Kombinacja, której używa już inna
      funkcja CCTrayTool, zostaje odrzucona.

  - Edytuj reguły...
      Otwiera plik reguł w Notatniku (patrz niżej). Po zapisaniu i
      zamknięciu Notatnika zmienione reguły są stosowane od razu:
      okna zablokowane przez regułę, która już nie pasuje, zostają
      odblokowane, a nowe reguły obowiązują natychmiast dla
      otwartych okien.

CloseGuard jako całość włącza się i wyłącza pozycją "Włącz
CloseGuard" w menu "Ustawienia" sekcji "CCTrayTool" (patrz punkt
7).

Reguły (osobny plik CloseGuardRules.ini, sekcja [Rules]):

Reguły nie są zapisane w pliku ustawień, lecz w osobnym pliku:
%LocalAppData%\CCTrayTool\CloseGuardRules.ini. Jest on tworzony
automatycznie. To plik Unicode, więc działają także tytuły okien ze
znakami diakrytycznymi i innymi znakami specjalnymi. Notatnik
zachowuje ten format; jeśli plik jest edytowany innym programem,
zapisz go również jako Unicode (UTF-16), w przeciwnym razie znaki
specjalne mogą zostać utracone. Reguły są wczytywane ponownie po
zamknięciu Notatnika otwartego przez "Edytuj reguły..." oraz przy
każdym uruchomieniu CCTrayTool.

Każdy wiersz to jedna reguła w postaci  numer=tytuł|klasa.  Tytuł
to tekst, który musi występować gdziekolwiek w tytule okna. Klasa
to techniczna nazwa typu okna i musi się dokładnie zgadzać.
Wielkość liter nie ma znaczenia. Jedna z dwóch części może być
pusta (znak "|" musi pozostać); jeśli wypełnione są obie, muszą
pasować obie. Przykłady:

  1=Calculator|       każde okno z "Calculator" w tytule
  2=|Notepad          każde okno klasy "Notepad"
  3=Untitled|Notepad  okna klasy "Notepad" z "Untitled" w tytule

Skrót "utwórz regułę" używa pełnego, aktualnego tytułu okna. Jeśli
tytuł się zmienia (na przykład o nazwę otwartego dokumentu), skróć
go później przez "Edytuj reguły..." do części, która się nie
zmienia, albo zostaw tytuł pusty i zachowaj tylko klasę. Klasę
zablokowanego okna pokazuje "Pokaż zablokowane okna". Reguła z
pustym tytułem i pustą klasą jest ignorowana; używanych jest
najwyżej 200 reguł.

Ustawienia w pliku ustawień (sekcja [CloseGuard]):

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

  Enabled                  1 = CloseGuard włączony, 0 = wyłączony
                           (tak jak pozycja menu "Włącz
                           CloseGuard").
  HotkeyToggle             Skrót klawiszowy
                           blokowania/odblokowywania. ^ = Ctrl,
                           ! = Alt, + = Shift, # = Win, a po nich
                           klawisz. Łatwiej zmienić go pozycją menu
                           "Zmień skrót".
  HotkeyAddRule            Skrót klawiszowy dla "utwórz regułę".
  ApplyOnStartup           1 = okna otwarte przy uruchomieniu
                           programu są porównywane z regułami,
                           0 = pozostają nietknięte.
  AutoApply                1 = nowe okna są sprawdzane
                           automatycznie, 0 = nie.
  PollInterval             Jak często okna są sprawdzane, w
                           milisekundach: od 250 do 5000
                           (domyślnie: 500). Inne wartości są
                           korygowane automatycznie.
  MinimizeOnClick          1 = kliknięcie zablokowanego przycisku
                           zamykania minimalizuje okno, 0 = nic nie
                           robi (domyślnie). Odpowiada opcji menu.
  ClickPollInterval        Jak często przycisk myszy jest w tym
                           celu sprawdzany, w milisekundach: od 10
                           do 100 (domyślnie: 30). Mniejsza wartość
                           pewniej wykrywa bardzo krótkie
                           kliknięcia, większa wymaga mniej czasu
                           obliczeniowego. Inne wartości są
                           korygowane automatycznie. Dla tego
                           ustawienia nie ma opcji menu.
  ClickGeometryFallback    1 = jeśli okno z własnym paskiem tytułu
                           (na przykład Outlook) nie zgłasza
                           systemowi Windows swojego X, X jest
                           rozpoznawany na podstawie położenia
                           (domyślnie). 0 = rozpoznawany jest tylko
                           X, który okno zgłasza samo.
  ClickGeometryExtendLeft  Jak daleko w lewo sięga obszar, w którym
                           X jest rozpoznawany na podstawie
                           położenia, w procentach szerokości X: od
                           0 do 100 (domyślnie: 0). Niektóre
                           programy rysują swój X bardziej na lewo,
                           niż zgłasza Windows. Zbyt duża wartość
                           sięga do sąsiedniego przycisku
                           maksymalizacji.
  ClickGeometryExtendDown  Jak daleko w dół sięga ten obszar, w
                           procentach wysokości X: od 0 do 100
                           (domyślnie: 87). Niektóre programy
                           rysują swój X niżej, niż zgłasza
                           Windows. Ten sam cel i te same granice
                           co ClickGeometryExtendLeft.
  ClickDebugOverlay        1 = pokazuje na ekranie, jako kolorowe,
                           przezroczyste prostokąty, obszary
                           używane do rozpoznawania X:
                           czerwony = obszar, w którym kliknięcie
                           liczy się jako kliknięcie X,
                           niebieski = obszar przycisku zamykania
                           zgłaszany przez Windows (lub, jeśli
                           Windows żadnego nie zgłasza, obszar X
                           znaleziony przez zapytanie okna),
                           zielony = tarcza nad X (zob.
                           ClickShieldClasses). Tylko do
                           diagnostyki. 0 = wyłączone (domyślnie).
  ClickShieldClasses       Klasy okien (rozdzielone przecinkami)
                           programów, które same się zamykają po
                           zwolnieniu przycisku myszy, na przykład
                           Edge i Chrome (Chrome_WidgetWin_1) oraz
                           Firefox (MozillaWindowClass); domyślnie
                           obie. X takiego okna jest przykryty
                           prawie niewidocznym oknem, które
                           przejmuje kliknięcie, więc okna nie
                           można już zamknąć przyciskiem X.
                           Puste = brak.

Oba skróty CloseGuard i skrót AlwaysOnTop muszą się od siebie
różnić. W przeciwnym razie używane są skróty domyślne.

Warto wiedzieć:

  - Blokada chroni przed przypadkowym kliknięciem X. W zależności
    od programu okno nadal można zamknąć w inny sposób: za pomocą
    ALT + F4, poleceniem "Zamknij okno" na pasku zadań, poleceniem
    Zakończ w menu samego programu lub w Menedżerze zadań.

  - Zablokować można tylko okna ze zwykłym paskiem tytułu i menu
    systemowym. Programy rysujące własny pasek tytułu (wiele
    nowoczesnych aplikacji, niektóre przeglądarki, aplikacje ze
    sklepu Microsoft Store) mogą zachować działający przycisk X,
    mimo że CloseGuard zgłasza okno jako zablokowane. Jeśli okno w
    ogóle nie ma menu systemowego, pojawia się komunikat.

  - Minimalizowanie kliknięciem: CCTrayTool sprawdza przycisk myszy
    krótko i regularnie (domyślnie co 30 ms), i tylko wtedy, gdy
    widoczne jest co najmniej jedno zablokowane okno. Nie używa
    haka myszy, więc nie może spowolnić myszy ani systemu. W mało
    prawdopodobnym przypadku, gdy bardzo krótkie kliknięcie
    przypadnie na moment, w którym CCTrayTool jest zajęty, po
    prostu nie zostanie zauważone: okno pozostaje bez zmian, a jego
    X nadal jest zablokowany.

  - Minimalizowanie kliknięciem reaguje na główny przycisk myszy
    (prawy, jeśli w Windows zamieniono przyciski) i tylko na X
    zablokowanych okien. Dotyk i pióro nie są wykrywane. Jeśli
    program ignoruje polecenie minimalizacji, CCTrayTool
    minimalizuje okno bezpośrednio.

  - Niektóre programy rysują własny pasek tytułu (na przykład
    Outlook). Nie informują systemu Windows, gdzie znajduje się ich
    X, dlatego do wykrywania kliknięcia CCTrayTool oblicza
    położenie X w prawym górnym rogu okna (klucz INI
    ClickGeometryFallback). W pliku dziennika pojawia się wtedy
    "recognized by its position".

  - Edge, Chrome i inne programy oparte na Chromium oraz Firefox
    same rysują swój przycisk X i same zamykają okno, gdy przycisk
    myszy zostanie zwolniony, więc zablokowane menu systemowe ich
    nie powstrzymuje. Nad X takich okien (klucz INI
    ClickShieldClasses, domyślnie
    Chrome_WidgetWin_1,MozillaWindowClass) CCTrayTool umieszcza
    prawie niewidoczne okno, czyli tarczę. Kliknięcie trafia w
    tarczę, a program nigdy go nie widzi: nic się nie dzieje albo
    okno jest minimalizowane, jeśli minimalizowanie po kliknięciu
    jest włączone. Tarcza podąża za oknem i znika, dopóki okno jest
    zminimalizowane, odblokowane, na pełnym ekranie lub przykryte
    innym oknem w miejscu X. Przy ClickDebugOverlay=1 jest
    pokazywana na zielono. Dopóki okno takiej klasy jest widoczne,
    przycisk myszy jest sprawdzany co 10 ms, nawet gdy
    minimalizowanie po kliknięciu jest wyłączone. Firefox sam
    rysuje pasek tytułu i Windows nie zgłasza położenia jego X;
    CCTrayTool znajduje wtedy X, pytając okno (plik dziennika:
    "found by asking the window"). Rozpoznawanie zastępcze według
    położenia (ClickGeometryFallback) jest stosowane tylko dla
    okien, które nie zgłaszają swojego X do Windows, takich jak
    Outlook i Word; CCTrayTool pyta każde okno jeden raz i zapisuje
    wynik w pliku dziennika ("probe of the X").

  - Okien programów uruchomionych jako administrator nie można
    blokować, dopóki CCTrayTool sam nie działa jako administrator
    (reguła bezpieczeństwa systemu Windows). Pojawia się komunikat.

  - Pulpit, pasek zadań i okna samego CCTrayTool nigdy nie są
    blokowane.

  - Po odblokowaniu okna jego menu systemowe jest przywracane do
    standardu Windows. Pozycje, które program sam dodał do tego
    menu, mogą zniknąć do czasu ponownego uruchomienia programu.

  - Blokada trwa tylko wtedy, gdy działa CCTrayTool: po zamknięciu
    programu lub wyłączeniu CloseGuard wszystkie okna odzyskują
    przycisk zamykania. Jeśli CCTrayTool zostanie zakończony siłowo
    (na przykład w Menedżerze zadań), zablokowane okna pozostają
    zablokowane. Wtedy naciśnij w takim oknie skrót
    blokowania/odblokowywania (CCTrayTool musi znów działać) albo
    zamknij okno i otwórz je ponownie.


-------------------------------------------------------------------
 5. Menu szybkiego uruchamiania własnych programów
-------------------------------------------------------------------

Nad KeepAwake menu zasobnika pokazuje sekcję "ToolTime": listę
programów, które można uruchomić jednym kliknięciem. Pozycje
pochodzą z folderu na komputerze (patrz punkt 6): każdy skrót (plik
.lnk) w tym folderze staje się pozycją menu, a każdy podfolder -
podmenu.

Domyślnie skonfigurowano już kilka wbudowanych narzędzi Windows, w
tym:

  - Kalkulator, Notepad  (folder "Office")
  - Explorer  (bezpośrednio w menu głównym)
  - Wiersz poleceń, Edytor rejestru, Ustawienia sieciowe, Panel
    sterowania, Monitor zasobów, Monitor wydajności, Zarządzaj
    usługami, Oczyszczanie dysku  (folder "System")

Skróty, których program nie zostanie znaleziony na danym
komputerze, automatycznie nie pojawiają się w menu - dzięki temu
nie występuje komunikat o błędzie, jeśli narzędzia brakuje w
systemie.

Niektóre pozycje (np. Wiersz poleceń, Edytor rejestru) są
skonfigurowane tak, aby uruchamiały się automatycznie z
uprawnieniami administratora (w takim przypadku system Windows
prosi o potwierdzenie za pomocą Kontroli konta użytkownika).


-------------------------------------------------------------------
 6. Dodawanie własnych narzędzi i folderów
-------------------------------------------------------------------

Narzędzia w menu szybkiego uruchamiania to po prostu skróty w
folderze. Aby dodać narzędzie, wybierz w menu "Ustawienia" pozycję
"Otwórz folder ToolTime" i umieść skrót (plik .lnk) w otwartym
folderze. CCTrayTool sam zauważa zmianę i chwilę później
aktualizuje menu zasobnika. (Jeśli tak się nie stanie, użyj pozycji
"Wczytaj narzędzia ponownie" w menu "Ustawienia".)

Szybki sposób utworzenia skrótu: przeciągnij program do folderu
prawym przyciskiem myszy i wybierz "Utwórz skróty tutaj".

Folder domyślny:  %LocalAppData%\CCTrayTool\ToolTime
(Inny folder można ustawić w pliku ustawień, patrz niżej.)

Podczas tworzenia folderu ToolTime CCTrayTool umieszcza w nim także
krótki plik informacyjny ("ToolTime_Info.txt", w języku systemu).
Wyjaśnia on pokrótce limity oraz sposób sortowania pozycji za
pomocą liczby na początku nazwy. Menu ignoruje ten plik; można go w
każdej chwili usunąć.

Jak folder zamienia się w menu:

  Skrót (.lnk)    staje się pozycją menu. Nazwą jest nazwa pliku;
                  ikona to ikona skrótu (a jeśli jej brak - ikona
                  programu, na który skrót wskazuje).
  Podfolder       staje się podmenu. Jego ikonę można zmienić jak
                  zwykle w Eksploratorze Windows (Właściwości >
                  Dostosowywanie > Zmień ikonę).
  Kolejność       Najpierw foldery, potem skróty, każde posortowane
                  alfabetycznie. Aby ustalić własną kolejność,
                  zacznij nazwę od dwóch lub trzech cyfr i
                  podkreślenia, np. "01_Notepad.lnk". Liczba służy
                  tylko do sortowania i nie jest wyświetlana.
  Administrator   Włącz "Uruchom jako administrator" we
                  właściwościach skrótu (Skrót > Zaawansowane).
                  Przy uruchamianiu pozycji Windows poprosi wtedy
                  o potwierdzenie.
  Niewyświetlane  Ukryte pliki, pliki niebędące skrótami, skróty,
                  których program nie istnieje, oraz puste foldery.

Limity - aby menu pozostało użyteczne:

Menu zasobnika nie da się przewijać kółkiem myszy, a jedynie
dwoma małymi przyciskami ze strzałkami, a długie menu wypchnęłoby
KeepAwake, AlwaysOnTop i ustawienia poza widoczny obszar.
Dlatego obowiązuje:

  - W jednym menu wyświetlanych jest co najwyżej 15 pozycji
    (foldery i skróty łącznie). Ten limit można zmienić w pliku
    ustawień na wartość od 10 do 20 (patrz niżej).
  - Co najwyżej 3 poziomy menu: menu ToolTime plus dwa poziomy
    podmenu. Głębsze foldery są ignorowane.
  - Co najwyżej 400 pozycji łącznie.

Wskazówka: wiele narzędzi lepiej pogrupować w podfolderach niż
umieszczać na jednej długiej liście.

Jeśli limit zostanie przekroczony, nic nie ginie niezauważone:

  - Nadmiarowe pozycje nie są wyświetlane. Zamiast nich menu
    zawiera wyszarzony wiersz, np. "... 3 kolejnych nie
    wyświetlono (limit 15)".
  - Pojawia się powiadomienie, a sekcja ToolTime pokazuje pozycję
    "(!) ToolTime: znaleziono problemy - kliknij, aby zobaczyć
    szczegóły". Kliknięcie jej wyświetla dokładnie, co zostało
    pominięte i dlaczego. Te same informacje są zapisywane w
    pliku dziennika (jeśli włączono "Utwórz plik dziennika").
  - Zbyt głęboko zagnieżdżone foldery oraz skróty, których nie
    można odczytać, są zgłaszane w ten sam sposób.

Ustawienia w pliku ustawień (sekcja [ToolTime]):

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = pokaż ToolTime, 0 = ukryj (jak pozycja menu
               "Włącz ToolTime")
  MaxEntries   Maksymalna liczba pozycji w jednym menu, od 10 do
               20 (domyślnie: 15). Inne wartości są korygowane
               automatycznie.
  Folder       Opcjonalnie: ścieżka innego folderu ToolTime.
               Dozwolone są zmienne środowiskowe, np.
               %USERPROFILE%. Puste = folder domyślny. Jeśli
               folder nie istnieje, zostanie utworzony.

Aby edytować plik, wybierz w menu "Ustawienia" pozycję "Edytuj plik
ustawień". Po zapisaniu i zamknięciu Notatnika CCTrayTool ponownie
wczytuje plik, od razu stosuje wszystkie zmiany (bez ponownego
uruchamiania) i odbudowuje menu.

Przywracanie narzędzi domyślnych: zamknij CCTrayTool, usuń folder
ToolTime i uruchom program ponownie - narzędzia domyślne i plik
informacyjny zostaną utworzone od nowa.


-------------------------------------------------------------------
 7. Dodatkowe ustawienia
-------------------------------------------------------------------

W podmenu "Ustawienia" dostępne są dodatkowo:

  - Włącz ToolTime
      Całkowicie włącza lub wyłącza sekcję szybkiego uruchamiania
      narzędzi (patrz punkt 5). Po wyłączeniu żadna z jej pozycji
      nie pojawia się w menu zasobnika, niezależnie od zawartości
      folderu ToolTime.

  - Otwórz folder ToolTime
      Otwiera folder ToolTime w Eksploratorze Windows, aby dodawać,
      zmieniać nazwy lub usuwać skróty (patrz punkt 6).

  - Wczytaj narzędzia ponownie
      Ponownie odczytuje folder ToolTime i odbudowuje menu.
      Zwykle nie jest to konieczne, ponieważ zmiany w folderze są
      wykrywane automatycznie.

  - Włącz KeepAwake
      Całkowicie włącza lub wyłącza sekcję KeepAwake (patrz punkt
      2). Po wyłączeniu jej pozycje znikają z menu zasobnika i
      obowiązuje normalne zachowanie oszczędzania energii Windows.

  - Włącz AlwaysOnTop
      Całkowicie włącza lub wyłącza sekcję AlwaysOnTop (patrz punkt
      3). Po wyłączeniu jej pozycje znikają z menu zasobnika, a
      skrót klawiszowy zostaje dezaktywowany.

  - Włącz CloseGuard
      Całkowicie włącza lub wyłącza sekcję CloseGuard (patrz punkt
      4). Po wyłączeniu jej pozycje znikają z menu zasobnika,
      skróty klawiszowe zostają dezaktywowane, a wszystkie
      zablokowane okna odzyskują przycisk zamykania.

  - Uruchamiaj automatycznie
      CCTrayTool będzie odtąd uruchamiał się automatycznie przy
      logowaniu do Windows.

  - Utwórz plik dziennika
      Zapisuje szczegółowy dziennik wszystkich działań w pliku
      dziennika. Przydatne przy rozwiązywaniu problemów, niepotrzeb-
      ne w normalnej pracy.
      W pliku ustawień jest to wpis "UseLog" w sekcji [Main]:
      1 = włączone; 0, pusty lub brakujący wpis albo dowolna inna
      wartość = wyłączone.

  - Pokaż plik dziennika
      Otwiera bieżący plik dziennika w Notatniku.

  - Używaj dużych ikon
      Wyświetla ikony w menu zasobnika w większym rozmiarze (32
      zamiast 16 pikseli).

  - Edytuj plik ustawień
      Otwiera plik konfiguracyjny bezpośrednio do edycji (patrz
      punkt 6).


-------------------------------------------------------------------
 8. Lokalizacje przechowywania
-------------------------------------------------------------------

CCTrayTool przechowuje swoje pliki w profilu użytkownika:

  Konfiguracja:     %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Plik dziennika:   %LocalAppData%\CCTrayTool\CCTrayTool.log
  Folder ToolTime:  %LocalAppData%\CCTrayTool\ToolTime\

Reguły CloseGuard znajdują się w osobnym pliku:

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(Ścieżkę można wkleić do paska adresu Eksploratora Windows, aby
przejść bezpośrednio do folderu.)


-------------------------------------------------------------------
 9. Zamykanie programu
-------------------------------------------------------------------

CCTrayTool zamyka się za pomocą opcji menu "Zakończ". Powoduje to
automatyczne przywrócenie normalnego zachowania oszczędzania
energii Windows oraz zapisanie bieżącej konfiguracji.

Wszystkie okna, których przycisk zamykania jest zablokowany przez
CloseGuard, odzyskują przy tym swój przycisk zamykania.


-------------------------------------------------------------------
 10. Informacje / Kontakt
-------------------------------------------------------------------

Aktualnie zainstalowaną wersję można w każdej chwili sprawdzić za
pomocą opcji menu "Informacje".

CCTrayTool - Markus Debus
info@markus-debus.de
Licencja: GNU General Public License, wersja 3 lub nowsza
(GPL-3.0-or-later), z dodatkowym warunkiem uznania autorstwa; patrz
pliki LICENSE i NOTICE.



===================================================================
 CCTrayTool - Felhasználói kézikönyv
===================================================================

A CCTrayTool egy kis Windows-eszköz, amely ikonként fut a
tálcán (jobbra lent, az óra mellett). Négy hasznos funkciót
egyesít egyetlen programban:

  1. KeepAwake             - megakadályozza, hogy a számítógép
                              energiatakarékos módba váltson, vagy
                              hogy a képernyő kikapcsoljon
  2. AlwaysOnTop            - billentyűkombinációval bármely ablakot
                              az előtérben tart
  3. Eszközök gyorsindítása - egy kattintással indítja a gyakran
                              használt programokat közvetlenül a
                              tálcamenüből
  4. CloseGuard             - zárolja a kiválasztott ablakok
                              bezárás gombját (X)
                              billentyűkombinációval vagy
                              szabályokkal

Minden funkció a tálcaikonra kattintva, jobb egérgombbal
elérhető menün keresztül működtethető. Telepítés nem szükséges, a
program közvetlenül indítható.

A CCTrayTool a következő nyelveket támogatja: angol, német, olasz,
spanyol, francia, lengyel, magyar és orosz.
A nyelv a számítógép rendszernyelve alapján automatikusan beáll.

Rendszerkövetelmény: 64 bites Windows 10 vagy újabb szükséges. A
program 32 bites Windows rendszeren nem fut.

-------------------------------------------------------------------
 1. Indítás és az első ikon
-------------------------------------------------------------------

Indítás után egy ikon jelenik meg a Windows tálca
értesítési területén. Az ikon színe azonnal mutatja a KeepAwake
aktuális állapotát:

  - Fehér = KeepAwake letiltva (normál Windows-viselkedés)
  - Piros = KeepAwake aktív a monitorokhoz
  - Kék   = KeepAwake aktív a rendszerhez
  - Zöld  = KeepAwake aktív a monitorokhoz és a rendszerhez

Az ikonra jobb gombbal kattintva megnyílik a menü az összes
funkcióval. Ha az ikon nem látható, érdemes megnézni a "rejtett
ikonok" területét (kis nyíl a tálcán).

Megjegyzés: A CCTrayTool egyszerre csak egyszer indítható. Egy
második indításnak nincs hatása, ha a program már fut.


-------------------------------------------------------------------
 2. KeepAwake - az energiatakarékosság megakadályozása
-------------------------------------------------------------------

A "KeepAwake" menüpontban kiválasztható, hogy a számítógép mit NE
tegyen, amíg a CCTrayTool fut:

  - Monitorok és rendszer
      Sem a képernyő nem kapcsol ki, sem a számítógép nem vált
      készenléti/energiatakarékos módba. Ideális előadásokhoz vagy
      hosszan futó folyamatokhoz, amelyeknél a képernyőnek
      láthatónak kell maradnia.

  - Monitorok
      Csak a képernyő marad bekapcsolva (nincs kikapcsolás, nincs
      képernyővédő). Maga a számítógép a saját időkorlátja után
      ettől függetlenül készenléti módba válthat.

  - Rendszer
      A számítógép nem vált készenléti/energiatakarékos módba, de a
      képernyő a Windows beállításának megfelelően továbbra is
      kikapcsolhat. Hasznos például hosszú letöltésekhez vagy
      háttérben futó számításokhoz.

  - Letiltva
      A CCTrayTool nem avatkozik be; a Windows normál
      energiatakarékossági viselkedése érvényes.

A KeepAwake szakasz "Beállítások" almenüjének "Állapot mentése"
menüpontja hatására a CCTrayTool megjegyzi az utoljára kiválasztott
KeepAwake-beállítást, és a következő induláskor automatikusan
visszaállítja.

A CCTrayTool bezárásakor a Windows normál energiatakarékossági
viselkedése automatikusan visszaáll.


-------------------------------------------------------------------
 3. AlwaysOnTop - ablak az előtérben tartása
-------------------------------------------------------------------

A SHIFT + ALT + T (alapértelmezett) billentyűkombináció tartósan
az előtérben tartja az éppen aktív ablakot - még akkor is, ha más
ablakokra kattintanak. Ismételt megnyomásra ez a rögzítés
megszűnik.

Váltáskor egy kis értesítés jelenik meg röviden az egérmutató
közelében, amely megerősíti, hogy az ablak most "az előtérben
marad"-e, vagy "visszaállt normálra". Ez az értesítés a "ToolTip
megjelenítése" menüponttal ki- és bekapcsolható.

Az "AlwaysOnTop" menüben a következő beállítások érhetők el:

  - Gyorsbillentyű aktív   Teljesen be- vagy kikapcsolja a
                           billentyűkombinációt
  - Beállítások            Almenü (fogaskerék ikon) a következő
                           bejegyzésekkel:
      - Gyorsbillentyű módosítása   Megnyit egy párbeszédablakot,
                                    ahol saját billentyűkombináció
                                    adható meg (Ctrl, Alt, Shift,
                                    Win kombinációja egy betűvel,
                                    számmal vagy F1-F12
                                    funkcióbillentyűvel)
      - ToolTip megjelenítése       Be- vagy kikapcsolja a rövid
                                    képernyőn megjelenő értesítést
                                    váltáskor

Megjegyzés: Maga a Windows asztal ("Program Manager") nem
állítható be "mindig az előtérben" módra. Nem minden
billentyűkombináció szabad - néhányat már a rendszer vagy más
programok lefoglaltak. Ilyenkor egy értesítés jelenik meg, és más
kombinációt kell választani.


-------------------------------------------------------------------
 4. CloseGuard - a bezárás gomb zárolása
-------------------------------------------------------------------

A CloseGuard megvédi az ablakokat a véletlen bezárástól. A
kiválasztott ablakoknál zárolja a bezárás gombot (az ablak jobb
felső sarkában lévő "X"-et): a gomb szürkén jelenik meg, és a
rákattintás nem csinál semmit. Ez hasznos azoknál a programoknál,
amelyeknek folyamatosan futniuk kell, vagy azoknál az ablakoknál,
amelyeket újra és újra véletlenül bezárnak.

Egy ablakot kétféleképpen lehet zárolni:

  - Kézzel, billentyűkombinációval
      Kattintson az ablakra, majd nyomja meg a CTRL + ALT + X
      kombinációt (alapértelmezett). Az ablak bezárás gombja ezzel
      zárolva lesz. A kombináció ismételt megnyomása feloldja. Az
      így feloldott ablak akkor is feloldva marad, ha illik rá egy
      szabály, amíg be nem zárják. Egy rövid értesítés megerősít
      minden változást. A zárolás addig tart, amíg az ablakot be
      nem zárják vagy fel nem oldják.

  - Automatikusan, szabályokkal
      Kattintson az ablakra, majd nyomja meg a
      CTRL + ALT + SHIFT + X kombinációt (alapértelmezett). A
      CCTrayTool a szabályfájlba menti az ablak címéből és
      osztályából álló szabályt, és zárolja az ablakot. Ettől
      kezdve minden olyan ablak, amelyre a szabály illik,
      automatikusan zárolva lesz, amint megjelenik - a program vagy
      a CCTrayTool újraindítása után is.

A tálcamenüben a "CloseGuard" szakasz a következő bejegyzéseket
kínálja:

  - Az aktív ablak bezárás gombjának zárolása/feloldása
      Ugyanazt teszi, mint az első billentyűkombináció. Amíg a
      tálcamenü nyitva van, az kapja a fókuszt; ezért a CloseGuard
      azt az ablakot használja, amely közvetlenül előtte aktív
      volt.

  - Szabály létrehozása az aktív ablakhoz
      Ugyanazt teszi, mint a második billentyűkombináció.

  - Zárolt ablakok megjelenítése
      Megmutatja, mely ablakok vannak éppen zárolva (szabály
      alapján vagy kézzel, az ablak osztályával szögletes
      zárójelben), és hány szabály létezik.

Alattuk a "Beállítások" almenü (fogaskerék ikon) található, amely a
következőket tartalmazza:

  - Új ablakok automatikus ellenőrzése
      Bekapcsolva: a CloseGuard folyamatosan figyel, és zárol
      minden új ablakot, amelyre illik valamelyik szabály.
      Kikapcsolva: az új ablakok nem lesznek automatikusan zárolva.

  - Induláskor nyitott ablakok ellenőrzése
      Bekapcsolva: a CCTrayTool indulásakor már nyitott ablakokat
      azonnal összeveti a szabályokkal. Kikapcsolva: ezeket az
      ablakokat békén hagyja; csak a később megnyitottakat
      ellenőrzi.

  - Ablak minimalizálása a zárolt X-re kattintáskor
      Bekapcsolva: a szürkített bezárás gombra kattintva az ablak
      minimalizálódik ahelyett, hogy semmi sem történne. Mint egy
      valódi gombnál, az ablak csak akkor minimalizálódik, ha az
      egérgombot is az X-en engedik fel; ha lenyomják a gombot,
      majd elhúzzák az egeret, a kattintás megszakad. Kikapcsolva
      (alapértelmezés): a kattintás semmit sem tesz.

  - Gyorsbillentyű módosítása: zárolás/feloldás
    Gyorsbillentyű módosítása: szabály létrehozása
      Ugyanazt a párbeszédablakot nyitja meg, mint az AlwaysOnTop,
      egy másik billentyűkombináció megadásához. Az olyan
      kombinációt, amelyet a CCTrayTool egy másik funkciója már
      használ, elutasítja.

  - Szabályok szerkesztése...
      Megnyitja a szabályfájlt a Jegyzettömbben (lásd alább). A
      Jegyzettömb mentése és bezárása után a módosított szabályok
      azonnal érvénybe lépnek: azok az ablakok, amelyeket egy már
      nem illő szabály zárolt, feloldódnak, az új szabályok pedig
      azonnal vonatkoznak a megnyitott ablakokra.

A CloseGuard egésze a "CCTrayTool" szakasz "Beállítások" menüjének
"CloseGuard bekapcsolása" pontjával ki- és bekapcsolható (lásd a 7.
pontot).

Szabályok (külön fájl: CloseGuardRules.ini, [Rules] szakasz):

A szabályok nem a beállításfájlban vannak, hanem egy külön fájlban:
%LocalAppData%\CCTrayTool\CloseGuardRules.ini. A program
automatikusan létrehozza. Unicode fájl, ezért az ékezetes vagy más
különleges karaktereket tartalmazó ablakcímek is működnek. A
Jegyzettömb megtartja ezt a formátumot; ha a fájlt más programmal
szerkeszti, azt is Unicode (UTF-16) formátumban mentse, különben a
különleges karakterek elveszhetnek. A szabályokat a program újra
beolvassa, amikor a "Szabályok szerkesztése..." paranccsal
megnyitott Jegyzettömböt bezárja, valamint a CCTrayTool minden
indításakor.

Minden sor egy szabály  szám=cím|osztály  alakban. A cím olyan
szöveg, amelynek szerepelnie kell valahol az ablak címében. Az
osztály az ablaktípus technikai neve, és pontosan egyeznie kell. A
kis- és nagybetűk nem számítanak. A két rész egyike üres lehet (a
"|" jelnek maradnia kell); ha mindkettő ki van töltve, mindkettőnek
illeszkednie kell. Példák:

  1=Calculator|       minden ablak, amelynek címében szerepel a
                      "Calculator"
  2=|Notepad          minden "Notepad" osztályú ablak
  3=Untitled|Notepad  a "Notepad" osztályú ablakok, amelyek címében
                      szerepel az "Untitled"

A "szabály létrehozása" billentyűkombináció az ablak teljes,
aktuális címét használja. Ha a cím változik (például egy megnyitott
dokumentum nevével), utólag rövidítse le a "Szabályok
szerkesztése..." paranccsal az állandó részre, vagy hagyja üresen a
címet, és csak az osztályt tartsa meg. A zárolt ablak osztályát a
"Zárolt ablakok megjelenítése" mutatja. Az üres című és üres
osztályú szabályt figyelmen kívül hagyja; legfeljebb 200 szabályt
használ.

Beállítások a beállításfájlban ([CloseGuard] szakasz):

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

  Enabled                  1 = a CloseGuard be van kapcsolva,
                           0 = ki van kapcsolva (megegyezik a
                           "CloseGuard bekapcsolása" menüponttal).
  HotkeyToggle             A zárolás/feloldás
                           billentyűkombinációja. ^ = Ctrl,
                           ! = Alt, + = Shift, # = Win, utána a
                           billentyű. Egyszerűbb a "Gyorsbillentyű
                           módosítása" menüponttal megváltoztatni.
  HotkeyAddRule            A "szabály létrehozása"
                           billentyűkombinációja.
  ApplyOnStartup           1 = a program indulásakor nyitott
                           ablakokat összeveti a szabályokkal,
                           0 = békén hagyja őket.
  AutoApply                1 = az új ablakokat automatikusan
                           ellenőrzi, 0 = nem.
  PollInterval             Milyen gyakran ellenőrzi az ablakokat,
                           ezredmásodpercben: 250 és 5000 között
                           (alapértelmezés: 500). A többi értéket
                           automatikusan kijavítja.
  MinimizeOnClick          1 = a zárolt bezárás gombra kattintva az
                           ablak minimalizálódik, 0 = a kattintás
                           semmit sem tesz (alapértelmezés).
                           Megfelel a menüpontnak.
  ClickPollInterval        Milyen gyakran ellenőrzi ehhez az
                           egérgombot, ezredmásodpercben: 10 és 100
                           között (alapértelmezés: 30). A kisebb
                           érték a nagyon rövid kattintásokat is
                           megbízhatóbban észleli, a nagyobb
                           kevesebb számítási időt igényel. A többi
                           értéket automatikusan kijavítja. Ehhez a
                           beállításhoz nincs menüpont.
  ClickGeometryFallback    1 = ha egy saját címsorral rendelkező
                           ablak (például az Outlook) nem jelzi a
                           Windowsnak az X-ét, az X-et a pozíciója
                           alapján ismeri fel (alapértelmezés).
                           0 = csak olyan X-et ismer fel, amelyet
                           az ablak maga jelez.
  ClickGeometryExtendLeft  Milyen messzire nyúlik balra az a
                           terület, amelyben az X-et a pozíciója
                           alapján ismeri fel, az X szélességének
                           százalékában: 0 és 100 között
                           (alapértelmezés: 0). Néhány program az
                           X-ét távolabb balra rajzolja, mint amit
                           a Windows jelez. Túl nagy érték belelóg
                           a szomszédos maximalizálás gombba.
  ClickGeometryExtendDown  Milyen messzire nyúlik lefelé ez a
                           terület, az X magasságának százalékában:
                           0 és 100 között (alapértelmezés: 87).
                           Néhány program az X-ét lejjebb rajzolja,
                           mint amit a Windows jelez. Ugyanaz a cél
                           és ugyanazok a határok, mint a
                           ClickGeometryExtendLeft esetében.
  ClickDebugOverlay        1 = színes, átlátszó téglalapokként
                           megjeleníti a képernyőn az X
                           felismeréséhez használt területeket:
                           piros = az a terület, ahol a kattintás
                           X-re kattintásnak számít, kék = a
                           bezárás gomb Windows által jelzett
                           területe (vagy, ha a Windows nem jelez
                           ilyet, az ablak megkérdezésével
                           megtalált X-terület), zöld = az X
                           fölötti pajzs (lásd:
                           ClickShieldClasses). Csak
                           hibakereséshez. 0 = kikapcsolva
                           (alapértelmezés).
  ClickShieldClasses       Olyan programok ablakosztályai
                           (vesszővel elválasztva), amelyek az
                           egérgomb felengedésekor maguktól
                           bezáródnak, például az Edge és a Chrome
                           (Chrome_WidgetWin_1), valamint a Firefox
                           (MozillaWindowClass); alapértelmezés:
                           mindkettő. Az ilyen ablak X gombját egy
                           szinte láthatatlan ablak takarja, amely
                           felfogja a kattintást, így az ablak az
                           X-szel már nem zárható be. Üres = nincs.

A két CloseGuard-billentyűkombinációnak és az AlwaysOnTop
kombinációnak különbözniük kell egymástól. Ha nem így van,
helyettük az alapértelmezett kombinációk lesznek használatban.

Tudnivalók:

  - A zárolás a véletlen X-kattintástól véd. A programtól függően
    az ablak más módon továbbra is bezárható: az ALT + F4
    kombinációval, a tálca "Ablak bezárása" parancsával, a program
    saját menüjének Kilépés parancsával vagy a Feladatkezelővel.

  - Csak a hagyományos címsorú és rendszermenüs ablakok zárolhatók.
    Azok a programok, amelyek saját címsort rajzolnak (sok modern
    alkalmazás, egyes böngészők, a Microsoft Store alkalmazásai),
    működő X-et tarthatnak meg akkor is, ha a CloseGuard zároltnak
    jelzi az ablakot. Ha egy ablaknak egyáltalán nincs
    rendszermenüje, értesítés jelenik meg.

  - Minimalizálás kattintásra: a CCTrayTool röviden és rendszeresen
    ellenőrzi az egérgombot (alapértelmezés: 30 ms-onként), és csak
    akkor, amíg legalább egy zárolt ablak látható. Nem használ
    egérhookot, ezért nem lassíthatja le az egeret vagy a
    rendszert. Abban a valószínűtlen esetben, ha egy nagyon rövid
    kattintás éppen akkor történik, amikor a CCTrayTool elfoglalt,
    a program egyszerűen nem veszi észre: az ablak változatlan
    marad, az X-e pedig zárolt.

  - A kattintásra történő minimalizálás az elsődleges egérgombra
    reagál (a jobbra, ha a Windowsban felcserélték a gombokat), és
    csak a zárolt ablakok X-ére. Az érintéses és tollas bevitelt
    nem érzékeli. Ha egy program figyelmen kívül hagyja a
    minimalizálási parancsot, a CCTrayTool közvetlenül
    minimalizálja az ablakot.

  - Néhány program saját maga rajzolja a címsorát (például az
    Outlook). Ezek nem mondják meg a Windowsnak, hol van az X-ük,
    ezért a kattintás felismeréséhez a CCTrayTool kiszámítja az X
    helyét az ablak jobb felső sarkában (ClickGeometryFallback
    INI-kulcs). A naplófájlban ilyenkor a "recognized by its
    position" szöveg jelenik meg.

  - Az Edge, a Chrome és más Chromium-alapú programok, valamint a
    Firefox maguk rajzolják az X gombot, és az egérgomb
    felengedésekor maguk zárják be az ablakot, ezért a zárolt
    rendszermenü nem állítja meg őket. Az ilyen ablakok X gombja
    fölé (ClickShieldClasses INI-kulcs, alapértelmezés:
    Chrome_WidgetWin_1,MozillaWindowClass) a CCTrayTool egy szinte
    láthatatlan ablakot, egy pajzsot helyez. A kattintás a pajzsra
    érkezik, a program sosem látja: nem történik semmi, vagy az
    ablak minimalizálódik, ha a kattintásra történő minimalizálás
    be van kapcsolva. A pajzs követi az ablakot, és eltűnik, amíg
    az ablak minimalizált, feloldott, teljes képernyős, vagy az
    X-énél egy másik ablak takarja. A ClickDebugOverlay=1
    beállításnál zölden látszik. Amíg egy ilyen osztályú ablak
    látható, az egérgombot 10 ms-onként ellenőrzi a program, akkor
    is, ha a kattintásra történő minimalizálás ki van kapcsolva. A
    Firefox maga rajzolja a címsorát, és a Windows nem jelenti az X
    gombjának helyét; a CCTrayTool ilyenkor úgy találja meg az X
    gombot, hogy megkérdezi az ablakot (naplófájl:
    "found by asking the window"). A helyzet alapján történő
    tartalék felismerést (ClickGeometryFallback) csak azoknál az
    ablakoknál használja a program, amelyek nem jelentik az X
    gombjukat a Windowsnak, például az Outlooknál és a Wordnél; a
    CCTrayTool minden ablakot egyszer megkérdez, és az eredményt a
    naplófájlba írja ("probe of the X").

  - A rendszergazdaként futó programok ablakai nem zárolhatók, amíg
    a CCTrayTool maga nem fut rendszergazdaként (ez egy
    Windows-biztonsági szabály). Értesítés jelenik meg.

  - Az asztalt, a tálcát és magának a CCTrayTool-nak az ablakait a
    program soha nem zárolja.

  - Feloldáskor az ablak rendszermenüje visszaáll a Windows
    alapértelmezésére. Azok a bejegyzések, amelyeket a program maga
    adott ehhez a menühöz, a program újraindításáig hiányozhatnak.

  - A zárolás csak addig tart, amíg a CCTrayTool fut: a program
    bezárásakor vagy a CloseGuard kikapcsolásakor minden ablak
    visszakapja a bezárás gombját. Ha a CCTrayTool-t erőszakkal
    fejezik be (például a Feladatkezelővel), a zárolt ablakok
    zárolva maradnak. Ilyenkor nyomja meg egy ilyen ablakban a
    zárolás/feloldás billentyűkombinációt (a CCTrayTool-nak ismét
    futnia kell), vagy zárja be az ablakot, és nyissa meg újra.


-------------------------------------------------------------------
 5. Gyorsindító menü saját programokhoz
-------------------------------------------------------------------

A KeepAwake fölött a tálcamenü megjeleníti a "ToolTime" szakaszt:
egy kattintással indítható programok listáját. A bejegyzések a
számítógép egyik mappájából származnak (lásd 6. pont): a mappában
lévő minden parancsikon (.lnk fájl) menübejegyzéssé, minden almappa
almenüvé válik.

Alapértelmezés szerint már több beépített Windows-eszköz be van
állítva, például:

  - Számológép, Notepad  (mappa: "Office")
  - Explorer  (közvetlenül a főmenüben)
  - Parancssor, Rendszerleíró adatbázis-szerkesztő, Hálózati
    beállítások, Vezérlőpult, Erőforrás-figyelő,
    Teljesítményfigyelő, Szolgáltatások kezelése, Lemezkarbantartó
    (mappa: "Rendszer")

Azok a parancsikonok, amelyek programja nem található meg az adott
számítógépen, automatikusan nem jelennek meg a menüben - így nem
keletkezik hibaüzenet, ha egy eszköz hiányzik egy rendszerről.

Egyes bejegyzések (pl. Parancssor, Rendszerleíró adatbázis-
szerkesztő) úgy vannak beállítva, hogy automatikusan
rendszergazdai jogosultsággal induljanak (ilyenkor a Windows a
Felhasználói fiókok felügyeletén keresztül megerősítést kér).


-------------------------------------------------------------------
 6. Saját eszközök és mappák hozzáadása
-------------------------------------------------------------------

A gyorsindító menü eszközei egyszerűen egy mappában lévő
parancsikonok. Eszköz hozzáadásához válassza a "Beállítások" menü
"ToolTime mappa megnyitása" pontját, és helyezzen el egy
parancsikont (.lnk fájlt) a megnyíló mappában. A CCTrayTool magától
észleli a változást, és egy pillanattal később frissíti a
tálcamenüt. (Ha ez nem történne meg, használja a "Beállítások"
menü "Eszközök újratöltése" pontját.)

Gyors mód parancsikon létrehozására: húzza a programot a mappába a
jobb egérgombbal, és válassza a "Parancsikonok létrehozása itt"
lehetőséget.

Alapértelmezett mappa:  %LocalAppData%\CCTrayTool\ToolTime
(Másik mappa megadható a beállításfájlban, lásd alább.)

A ToolTime mappa létrehozásakor a CCTrayTool egy rövid tájékoztató
fájlt is elhelyez benne ("ToolTime_Info.txt", a rendszer nyelvén).
Röviden elmagyarázza a korlátokat, valamint azt, hogyan rendezhetők
a bejegyzések a név elé írt számmal. A menü figyelmen kívül hagyja
a fájlt; bármikor törölhető.

Hogyan lesz a mappából menü:

  Parancsikon (.lnk)  menübejegyzéssé válik. A név a fájlnév; az
                      ikon a parancsikoné (ennek hiányában annak a
                      programnak az ikonja, amelyre mutat).
  Almappa             almenüvé válik. Az ikonja a szokott módon
                      módosítható a Windows Intézőben
                      (Tulajdonságok > Testreszabás > Ikon
                      módosítása).
  Sorrend             Először a mappák, utána a parancsikonok
                      következnek, mindkettő betűrendben. Saját
                      sorrendhez kezdje a nevet két vagy három
                      számjeggyel és egy aláhúzással, pl.
                      "01_Notepad.lnk". A szám csak a rendezést
                      szolgálja, és nem jelenik meg.
  Rendszergazda       Kapcsolja be a "Futtatás rendszergazdaként"
                      lehetőséget a parancsikon tulajdonságaiban
                      (Parancsikon > Speciális). A Windows ekkor a
                      bejegyzés indításakor megerősítést kér.
  Nem jelennek meg    Rejtett fájlok, nem parancsikon fájlok,
                      olyan parancsikonok, amelyek programja nem
                      létezik, valamint üres mappák.

Korlátok - hogy a menü használható maradjon:

A tálcamenü nem görgethető az egérgörgővel, csak két kis nyílgombbal,
és egy hosszú menü kiszorítaná a KeepAwake, az AlwaysOnTop és a
beállítások szakaszt a látható területről. Ezért:

  - Menünként legfeljebb 15 bejegyzés (mappák és parancsikonok
    együtt) jelenik meg. Ez a korlát a beállításfájlban 10 és 20
    közötti értékre módosítható (lásd alább).
  - Legfeljebb 3 menüszint: a ToolTime menü és két almenüszint.
    A mélyebben lévő mappákat a program figyelmen kívül hagyja.
  - Összesen legfeljebb 400 bejegyzés.

Tipp: sok eszközt inkább almappákba csoportosítson, ne egyetlen
hosszú listába.

Ha egy korlát túllépésre kerül, semmi sem vész el észrevétlenül:

  - A felesleges bejegyzések nem jelennek meg. Helyettük a menü
    egy szürkített sort tartalmaz, például "... további 3 nem
    jelenik meg (korlát: 15)".
  - Értesítés jelenik meg, és a ToolTime szakasz megjeleníti a
    "(!) ToolTime: problémák találhatók - kattintson a
    részletekért" bejegyzést. Rákattintva pontosan látható, mi
    maradt ki és miért. Ugyanezek az információk a naplófájlba is
    bekerülnek (ha a "Naplófájl létrehozása" be van kapcsolva).
  - A túl mélyen egymásba ágyazott mappákat és az olvashatatlan
    parancsikonokat a program ugyanígy jelzi.

Beállítások a beállításfájlban ([ToolTime] szakasz):

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = a ToolTime megjelenik, 0 = el van rejtve
               (megegyezik a "ToolTime bekapcsolása" menüponttal)
  MaxEntries   A bejegyzések maximális száma menünként, 10 és 20
               között (alapérték: 15). A többi értéket a program
               automatikusan javítja.
  Folder       Nem kötelező: másik ToolTime mappa elérési útja.
               Környezeti változók, például %USERPROFILE%,
               használhatók. Üres = alapértelmezett mappa. Ha a
               mappa nem létezik, a program létrehozza.

A fájl szerkesztéséhez válassza a "Beállítások" menü "Beállításfájl
szerkesztése" pontját. A Jegyzettömb mentése és bezárása után a
CCTrayTool újra beolvassa a fájlt, azonnal alkalmazza az összes
módosítást (újraindítás nélkül), és újraépíti a tálcamenüt.

Az alapértelmezett eszközök visszaállítása: lépjen ki a
CCTrayTool-ból, törölje a ToolTime mappát, majd indítsa újra a
programot - az alapértelmezett eszközök és a tájékoztató fájl újra
létrejön.


-------------------------------------------------------------------
 7. További beállítások
-------------------------------------------------------------------

A "Beállítások" almenüben ezenkívül elérhető:

  - ToolTime bekapcsolása
      Teljesen be- vagy kikapcsolja az eszközök gyorsindító
      szakaszát (lásd 5. pont). Kikapcsolt állapotban egyik
      bejegyzése sem jelenik meg a tálcamenüben, függetlenül attól,
      hogy mi van a ToolTime mappában.

  - ToolTime mappa megnyitása
      Megnyitja a ToolTime mappát a Windows Intézőben, hogy
      parancsikonokat lehessen hozzáadni, átnevezni vagy törölni
      (lásd 6. pont).

  - Eszközök újratöltése
      Újra beolvassa a ToolTime mappát, és újraépíti a menüt.
      Általában nem szükséges, mert a mappában történt változásokat
      a program automatikusan észleli.

  - KeepAwake bekapcsolása
      Teljesen be- vagy kikapcsolja a KeepAwake szakaszt (lásd 2.
      pont). Kikapcsolt állapotban bejegyzései eltűnnek a
      tálcamenüből, és a Windows normál energiatakarékossági
      viselkedése érvényes.

  - AlwaysOnTop bekapcsolása
      Teljesen be- vagy kikapcsolja az AlwaysOnTop szakaszt (lásd 3.
      pont). Kikapcsolt állapotban bejegyzései eltűnnek a
      tálcamenüből, és a billentyűkombináció letiltásra kerül.

  - CloseGuard bekapcsolása
      Teljesen be- vagy kikapcsolja a CloseGuard egész szakaszát
      (lásd 4. pont). Kikapcsolt állapotban bejegyzései eltűnnek a
      tálcamenüből, a billentyűkombinációk letiltásra kerülnek, és
      minden zárolt ablak visszakapja a bezárás gombját.

  - Automatikus indítás
      A CCTrayTool ezentúl automatikusan elindul a Windows
      bejelentkezéskor.

  - Naplófájl létrehozása
      Részletes naplót ír az összes műveletről egy naplófájlba.
      Hasznos hibakereséshez, normál üzemben nem szükséges.
      A beállításfájlban ez a [Main] szakasz "UseLog" bejegyzése:
      1 = be; 0, üres vagy hiányzó bejegyzés, illetve bármilyen más
      érték = ki.

  - Naplófájl megtekintése
      Megnyitja az aktuális naplófájlt a Jegyzettömbben.

  - Nagy ikonok használata
      Nagyobban jeleníti meg az ikonokat a tálcamenüben (32 a 16
      pixel helyett).

  - Beállításfájl szerkesztése
      Közvetlenül megnyitja a konfigurációs fájlt szerkesztésre
      (lásd a 6. pontot).


-------------------------------------------------------------------
 8. Tárolási helyek
-------------------------------------------------------------------

A CCTrayTool a saját fájljait a felhasználói profilban tárolja:

  Konfiguráció:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Naplófájl:       %LocalAppData%\CCTrayTool\CCTrayTool.log
  ToolTime mappa:  %LocalAppData%\CCTrayTool\ToolTime\

A CloseGuard szabályai egy külön fájlban vannak:

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(Az elérési út beilleszthető a Windows Intéző címsorába, hogy
közvetlenül a mappához jusson.)


-------------------------------------------------------------------
 9. A program bezárása
-------------------------------------------------------------------

A CCTrayTool a "Kilépés" menüponttal zárható be. Ez automatikusan
visszaállítja a Windows normál energiatakarékossági viselkedését,
és elmenti az aktuális konfigurációt.

Azok az ablakok, amelyek bezárás gombját a CloseGuard zárolta,
ilyenkor visszakapják a bezárás gombjukat.


-------------------------------------------------------------------
 10. Névjegy / Kapcsolat
-------------------------------------------------------------------

A jelenleg telepített verzió bármikor megtekinthető a "Névjegy"
menüponttal.

CCTrayTool - Markus Debus
info@markus-debus.de
Licenc: GNU General Public License, 3. vagy újabb verzió
(GPL-3.0-or-later), kiegészítő szerzőmegjelölési feltétellel; lásd
a LICENSE és a NOTICE fájlt.



===================================================================
 CCTrayTool - Руководство пользователя
===================================================================

CCTrayTool - это небольшая утилита для Windows, которая работает
в виде значка в области уведомлений (внизу справа, рядом с часами).
Она объединяет четыре полезные функции в одной программе:

  1. KeepAwake              - не позволяет ПК переходить в режим
                               энергосбережения или отключать экран
  2. AlwaysOnTop             - удерживает любое окно поверх других
                               окон с помощью сочетания клавиш
  3. Быстрый запуск инструментов - запускает часто используемые
                               программы прямо из меню области
                               уведомлений
  4. CloseGuard              - блокирует кнопку закрытия (X)
                               выбранных окон с помощью сочетания
                               клавиш или правил

Все функции управляются через меню, открываемое щелчком правой
кнопкой мыши по значку в области уведомлений. Установка не
требуется, программу можно запускать напрямую.

CCTrayTool поддерживает следующие языки: английский, немецкий,
итальянский, испанский, французский, польский, венгерский и
русский.
Язык устанавливается автоматически на основе языка системы
компьютера.

Системные требования: необходима 64-разрядная версия Windows 10 или
новее. Программа не работает в 32-разрядной версии Windows.

-------------------------------------------------------------------
 1. Запуск и первый значок
-------------------------------------------------------------------

После запуска в области уведомлений панели задач Windows
появляется значок. Цвет значка сразу показывает текущее состояние
KeepAwake:

  - Белый   = KeepAwake отключен (обычное поведение Windows)
  - Красный = KeepAwake активен для мониторов
  - Синий   = KeepAwake активен для системы
  - Зелёный = KeepAwake активен для мониторов и системы

Щелчок правой кнопкой мыши по значку открывает меню со всеми
функциями. Если значок не виден, стоит проверить область "скрытых
значков" (маленькая стрелка на панели задач).

Примечание: CCTrayTool можно запустить только один раз
одновременно. Повторный запуск не имеет никакого эффекта, если
программа уже работает.


-------------------------------------------------------------------
 2. KeepAwake - предотвращение энергосбережения
-------------------------------------------------------------------

В разделе меню "KeepAwake" можно выбрать, что ПК НЕ должен делать,
пока запущен CCTrayTool:

  - Мониторы и система
      Ни экран не отключается, ни ПК не переходит в режим
      ожидания/энергосбережения. Идеально подходит для презентаций
      или длительных процессов, при которых экран должен оставаться
      видимым.

  - Мониторы
      Остаётся включённым только экран (без отключения, без
      заставки). Сам ПК может всё же перейти в режим ожидания по
      истечении собственного тайм-аута.

  - Система
      ПК не переходит в режим ожидания/энергосбережения, но экран
      всё же может отключиться согласно настройкам Windows.
      Полезно, например, для длительных загрузок или вычислений в
      фоновом режиме.

  - Отключено
      CCTrayTool не вмешивается; действует обычное поведение
      энергосбережения Windows.

Пункт меню "Сохранить состояние" в подменю "Настройки" раздела
KeepAwake заставляет CCTrayTool запоминать последнюю выбранную
настройку KeepAwake и автоматически восстанавливать её при
следующем запуске.

При закрытии CCTrayTool обычное поведение энергосбережения Windows
восстанавливается автоматически.


-------------------------------------------------------------------
 3. AlwaysOnTop - удержание окна поверх других
-------------------------------------------------------------------

Сочетание клавиш SHIFT + ALT + T (по умолчанию) постоянно
удерживает текущее активное окно поверх других - даже при щелчке
по другим окнам. Повторное нажатие снимает эту фиксацию.

При переключении рядом с курсором мыши ненадолго появляется
небольшое уведомление, подтверждающее, "остаётся ли окно поверх
других" или оно "вернулось в обычный режим". Это уведомление можно
включить или отключить через пункт меню "Показывать подсказку".

В меню "AlwaysOnTop" доступны следующие параметры:

  - Горячая клавиша активна   Полностью включает или отключает
                              сочетание клавиш
  - Настройки                 Подменю (значок шестерёнки) со
                              следующими пунктами:
      - Изменить горячую клавишу   Открывает диалоговое окно, в
                                   котором можно задать собственное
                                   сочетание клавиш (комбинация
                                   Ctrl, Alt, Shift, Win и буквы,
                                   цифры или функциональной клавиши
                                   F1-F12)
      - Показывать подсказку       Включает или отключает короткое
                                   уведомление на экране при
                                   переключении

Примечание: Сам рабочий стол Windows ("Program Manager") нельзя
установить в режим "поверх всех окон". Не каждое сочетание клавиш
свободно - некоторые уже заняты системой или другими программами.
В этом случае появляется уведомление, и необходимо выбрать другое
сочетание.


-------------------------------------------------------------------
 4. CloseGuard - блокировка кнопки закрытия
-------------------------------------------------------------------

CloseGuard защищает окна от случайного закрытия. Для выбранных окон
он блокирует кнопку закрытия (значок "X" в правом верхнем углу
окна): кнопка становится серой, а щелчок по ней ничего не делает.
Это удобно для программ, которые должны работать постоянно, и для
окон, которые то и дело закрывают по ошибке.

Окно можно заблокировать двумя способами:

  - Вручную, с помощью сочетания клавиш
      Щёлкните окно и нажмите CTRL + ALT + X (по умолчанию). Кнопка
      закрытия этого окна заблокирована. Повторное нажатие
      сочетания разблокирует её. Окно, разблокированное таким
      образом, остаётся свободным, даже если подходит под правило,
      пока его не закроют. Короткое уведомление подтверждает каждое
      изменение. Блокировка действует, пока окно не будет закрыто
      или разблокировано.

  - Автоматически, с помощью правил
      Щёлкните окно и нажмите CTRL + ALT + SHIFT + X (по
      умолчанию). CCTrayTool сохраняет в файле правил правило из
      заголовка и класса окна и блокирует окно. С этого момента
      каждое окно, подходящее под правило, блокируется
      автоматически, как только появляется, - в том числе после
      перезапуска программы или CCTrayTool.

В меню области уведомлений раздел "CloseGuard" содержит следующие
пункты:

  - Заблокировать/разблокировать кнопку закрытия активного окна
      Делает то же, что и первое сочетание клавиш. Пока меню
      области уведомлений открыто, фокус находится у самого меню;
      поэтому CloseGuard использует окно, которое было активным
      непосредственно перед этим.

  - Создать правило для активного окна
      Делает то же, что и второе сочетание клавиш.

  - Показать заблокированные окна
      Показывает, какие окна заблокированы в данный момент (по
      правилу или вручную, с классом окна в квадратных скобках), и
      сколько существует правил.

Под ними находится подменю "Настройки" (значок шестерёнки), которое
содержит:

  - Автоматически проверять новые окна
      Включено: CloseGuard постоянно наблюдает и блокирует каждое
      новое окно, подходящее под правило. Выключено: новые окна
      автоматически не блокируются.

  - Проверять окна, открытые при запуске
      Включено: окна, уже открытые при запуске CCTrayTool, сразу
      сравниваются с правилами. Выключено: эти окна не
      затрагиваются; проверяются только окна, открытые позже.

  - Сворачивать окно при щелчке по заблокированному X
      Включено: щелчок по затемнённой кнопке закрытия сворачивает
      окно вместо того, чтобы ничего не делать. Как и с настоящей
      кнопкой, окно сворачивается, только если кнопка мыши отпущена
      тоже над X; если нажать кнопку и отвести курсор, щелчок
      отменяется. Выключено (по умолчанию): щелчок ничего не
      делает.

  - Изменить горячую клавишу: блокировка/разблокировка
    Изменить горячую клавишу: создание правила
      Открывает то же диалоговое окно, что и для AlwaysOnTop, чтобы
      задать другое сочетание клавиш. Сочетание, которое уже
      использует другая функция CCTrayTool, отклоняется.

  - Редактировать правила...
      Открывает файл правил в Блокноте (см. ниже). После сохранения
      и закрытия Блокнота изменённые правила применяются сразу:
      окна, заблокированные правилом, которое больше не подходит,
      разблокируются, а новые правила сразу действуют для открытых
      окон.

CloseGuard в целом включается и отключается пунктом "Включить
CloseGuard" в меню "Настройки" раздела "CCTrayTool" (см. раздел 7).

Правила (отдельный файл CloseGuardRules.ini, раздел [Rules]):

Правила хранятся не в файле настроек, а в отдельном файле:
%LocalAppData%\CCTrayTool\CloseGuardRules.ini. Он создаётся
автоматически. Это файл Unicode, поэтому работают заголовки окон с
любыми специальными символами. Блокнот сохраняет этот формат; если
файл редактируется другой программой, сохраните его тоже как
Unicode (UTF-16), иначе специальные символы могут быть потеряны.
Правила перечитываются после закрытия Блокнота, открытого через
"Редактировать правила...", и при каждом запуске CCTrayTool.

Каждая строка - это одно правило вида  номер=заголовок|класс.
Заголовок - текст, который должен встречаться где-либо в заголовке
окна. Класс - техническое имя типа окна; он должен совпадать точно.
Регистр букв не учитывается. Одна из двух частей может быть пустой
(знак "|" должен остаться); если заполнены обе, должны совпадать
обе. Примеры:

  1=Calculator|       любое окно со словом "Calculator" в заголовке
  2=|Notepad          любое окно класса "Notepad"
  3=Untitled|Notepad  окна класса "Notepad" со словом "Untitled" в
                      заголовке

Сочетание клавиш "создать правило" использует полный текущий
заголовок окна. Если заголовок меняется (например, из-за имени
открытого документа), позже сократите его через "Редактировать
правила..." до неизменной части либо оставьте заголовок пустым и
сохраните только класс. Класс заблокированного окна показывает
пункт "Показать заблокированные окна". Правило с пустым заголовком
и пустым классом игнорируется; используется не более 200 правил.

Параметры в файле настроек (раздел [CloseGuard]):

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

  Enabled                  1 = CloseGuard включён, 0 = выключен
                           (как пункт меню "Включить CloseGuard").
  HotkeyToggle             Сочетание клавиш для
                           блокировки/разблокировки. ^ = Ctrl,
                           ! = Alt, + = Shift, # = Win, затем
                           клавиша. Проще изменить его через пункт
                           меню "Изменить горячую клавишу".
  HotkeyAddRule            Сочетание клавиш для "создать правило".
  ApplyOnStartup           1 = окна, открытые при запуске
                           программы, сравниваются с правилами,
                           0 = не затрагиваются.
  AutoApply                1 = новые окна проверяются
                           автоматически, 0 = нет.
  PollInterval             Как часто проверяются окна, в
                           миллисекундах: от 250 до 5000 (по
                           умолчанию: 500). Другие значения
                           исправляются автоматически.
  MinimizeOnClick          1 = щелчок по заблокированной кнопке
                           закрытия сворачивает окно, 0 = ничего не
                           происходит (по умолчанию). Соответствует
                           пункту меню.
  ClickPollInterval        Как часто для этого проверяется кнопка
                           мыши, в миллисекундах: от 10 до 100 (по
                           умолчанию: 30). Меньшее значение
                           надёжнее распознаёт очень короткие
                           щелчки, большее требует меньше
                           вычислительного времени. Другие значения
                           исправляются автоматически. Для этого
                           параметра пункта меню нет.
  ClickGeometryFallback    1 = если окно с собственной строкой
                           заголовка (например, Outlook) не
                           сообщает Windows о своей кнопке X, она
                           распознаётся по положению (по
                           умолчанию). 0 = распознаётся только та
                           кнопка X, о которой окно сообщает само.
  ClickGeometryExtendLeft  Насколько далеко влево простирается
                           область, в которой X распознаётся по
                           положению, в процентах от ширины X: от 0
                           до 100 (по умолчанию: 0). Некоторые
                           программы рисуют X левее, чем сообщает
                           Windows. Слишком большое значение
                           заходит на соседнюю кнопку
                           развёртывания.
  ClickGeometryExtendDown  Насколько далеко вниз простирается эта
                           область, в процентах от высоты X: от 0
                           до 100 (по умолчанию: 87). Некоторые
                           программы рисуют X ниже, чем сообщает
                           Windows. Та же цель и те же пределы, что
                           у ClickGeometryExtendLeft.
  ClickDebugOverlay        1 = показывает на экране в виде цветных
                           прозрачных прямоугольников области, по
                           которым распознаётся X:
                           красный = область, в которой щелчок
                           считается щелчком по X, синий = область
                           кнопки закрытия, о которой сообщает
                           Windows (или, если Windows её не
                           сообщает, область X, найденная опросом
                           окна), зелёный = щит над X (см.
                           ClickShieldClasses). Только для поиска
                           ошибок. 0 = выключено (по умолчанию).
  ClickShieldClasses       Классы окон (через запятую) программ,
                           которые сами закрываются при отпускании
                           кнопки мыши, например Edge и Chrome
                           (Chrome_WidgetWin_1) и Firefox
                           (MozillaWindowClass); по умолчанию оба.
                           Кнопка X такого окна закрывается почти
                           невидимым окном, которое перехватывает
                           щелчок, поэтому окно больше нельзя
                           закрыть кнопкой X. Пусто = нет.

Два сочетания клавиш CloseGuard и сочетание AlwaysOnTop должны
отличаться друг от друга. Иначе вместо них используются сочетания
по умолчанию.

Полезно знать:

  - Блокировка защищает от случайного щелчка по X. В зависимости от
    программы окно по-прежнему можно закрыть другими способами: с
    помощью ALT + F4, командой "Закрыть окно" на панели задач,
    командой выхода в меню самой программы или через диспетчер
    задач.

  - Заблокировать можно только окна с обычной строкой заголовка и
    системным меню. Программы, которые рисуют собственную строку
    заголовка (многие современные приложения, некоторые браузеры,
    приложения из Microsoft Store), могут сохранить рабочий значок
    X, даже если CloseGuard сообщает, что окно заблокировано. Если
    у окна вообще нет системного меню, появляется уведомление.

  - Сворачивание щелчком: CCTrayTool кратко и регулярно проверяет
    кнопку мыши (по умолчанию каждые 30 мс), и только пока видно
    хотя бы одно заблокированное окно. Хук мыши не используется,
    поэтому мышь и систему замедлить невозможно. В маловероятном
    случае, когда очень короткий щелчок приходится на момент, когда
    CCTrayTool занят, он просто не замечается: окно остаётся как
    есть, а его X остаётся заблокированным.

  - Сворачивание щелчком реагирует на основную кнопку мыши (правую,
    если в Windows кнопки поменяны местами) и только на X
    заблокированных окон. Сенсорный ввод и ввод пером не
    распознаются. Если программа игнорирует команду сворачивания,
    CCTrayTool сворачивает окно напрямую.

  - Некоторые программы рисуют строку заголовка сами (например,
    Outlook). Они не сообщают Windows, где находится их кнопка X,
    поэтому для распознавания щелчка CCTrayTool вычисляет положение
    X в правом верхнем углу окна (ключ INI ClickGeometryFallback).
    В файле журнала тогда появляется "recognized by its position".

  - Edge, Chrome и другие программы на основе Chromium, а также
    Firefox сами рисуют кнопку X и сами закрывают окно, когда
    кнопка мыши отпускается, поэтому заблокированное системное меню
    их не останавливает. Над кнопкой X таких окон (ключ INI
    ClickShieldClasses, по умолчанию
    Chrome_WidgetWin_1,MozillaWindowClass) CCTrayTool размещает
    почти невидимое окно, щит. Щелчок попадает в щит, и программа
    его никогда не видит: ничего не происходит, или окно
    сворачивается, если включено сворачивание по щелчку. Щит
    следует за окном и исчезает, пока окно свёрнуто,
    разблокировано, развёрнуто на весь экран или перекрыто другим
    окном в месте кнопки X. При ClickDebugOverlay=1 он показывается
    зелёным. Пока окно такого класса видно, кнопка мыши проверяется
    каждые 10 мс, даже если сворачивание по щелчку выключено.
    Firefox сам рисует строку заголовка, и Windows не сообщает
    положение его кнопки X; тогда CCTrayTool находит X, опрашивая
    окно (файл журнала: "found by asking the window"). Запасное
    распознавание по положению (ClickGeometryFallback) используется
    только для окон, которые не сообщают Windows о своей кнопке X,
    например Outlook и Word; CCTrayTool один раз опрашивает каждое
    окно и записывает результат в файл журнала ("probe of the X").

  - Окна программ, запущенных от имени администратора, нельзя
    заблокировать, пока сам CCTrayTool не запущен от имени
    администратора (правило безопасности Windows). Появляется
    уведомление.

  - Рабочий стол, панель задач и окна самого CCTrayTool никогда не
    блокируются.

  - При разблокировке системное меню окна возвращается к
    стандартному виду Windows. Пункты, которые программа сама
    добавила в это меню, могут отсутствовать до перезапуска
    программы.

  - Блокировка действует только пока работает CCTrayTool: при
    закрытии программы или отключении CloseGuard все окна получают
    кнопку закрытия обратно. Если CCTrayTool завершён принудительно
    (например, через диспетчер задач), заблокированные окна
    остаются заблокированными. Тогда нажмите в таком окне сочетание
    для блокировки/разблокировки (CCTrayTool должен снова работать)
    либо закройте окно и откройте его заново.


-------------------------------------------------------------------
 5. Меню быстрого запуска собственных программ
-------------------------------------------------------------------

Над разделом KeepAwake меню в области уведомлений показывает раздел
"ToolTime": список программ, которые можно запустить одним щелчком.
Записи берутся из папки на вашем компьютере (см. раздел 6): каждый
ярлык (файл .lnk) в этой папке становится пунктом меню, а каждая
вложенная папка - подменю.

По умолчанию уже настроено несколько встроенных инструментов
Windows, в том числе:

  - Калькулятор, Notepad  (папка "Office")
  - Explorer  (прямо в главном меню)
  - Командная строка, Редактор реестра, Сетевые настройки, Панель
    управления, Монитор ресурсов, Монитор производительности,
    Управление службами, Очистка диска  (папка "Система")

Ярлыки, программа которых не найдена на данном компьютере,
автоматически не появляются в меню - поэтому сообщение об ошибке не
возникает, если какого-либо инструмента нет в системе.

Некоторые записи (например, Командная строка, Редактор реестра)
настроены на автоматический запуск с правами администратора (в этом
случае Windows запрашивает подтверждение через Контроль учётных
записей).


-------------------------------------------------------------------
 6. Добавление собственных инструментов и папок
-------------------------------------------------------------------

Инструменты в меню быстрого запуска - это просто ярлыки в папке.
Чтобы добавить инструмент, выберите в меню "Настройки" пункт
"Открыть папку ToolTime" и поместите ярлык (файл .lnk) в
открывшуюся папку. CCTrayTool сам замечает изменение и вскоре
обновляет меню в области уведомлений. (Если этого не произошло,
используйте пункт "Перезагрузить инструменты" в меню "Настройки".)

Быстрый способ создать ярлык: перетащите программу в папку правой
кнопкой мыши и выберите "Создать ярлыки".

Папка по умолчанию:  %LocalAppData%\CCTrayTool\ToolTime
(Другую папку можно указать в файле настроек, см. ниже.)

При создании папки ToolTime CCTrayTool помещает в неё также краткий
информационный файл ("ToolTime_Info.txt", на языке системы). В нём
кратко объясняются ограничения и то, как сортировать записи с
помощью числа перед именем. Меню игнорирует этот файл; его можно
удалить в любой момент.

Как папка превращается в меню:

  Ярлык (.lnk)      становится пунктом меню. Название - это имя
                    файла; значок - значок ярлыка (если его нет -
                    значок программы, на которую он указывает).
  Вложенная папка   становится подменю. Её значок можно изменить,
                    как обычно, в проводнике Windows (Свойства >
                    Настройка > Сменить значок).
  Порядок           Сначала идут папки, затем ярлыки, и те и другие
                    по алфавиту. Чтобы задать свой порядок, начните
                    имя с двух или трёх цифр и знака подчёркивания,
                    например "01_Notepad.lnk". Число служит только
                    для сортировки и не отображается.
  Администратор     Включите "Запуск от имени администратора" в
                    свойствах ярлыка (Ярлык > Дополнительно). При
                    запуске записи Windows запросит подтверждение.
  Не отображаются   Скрытые файлы, файлы, не являющиеся ярлыками,
                    ярлыки, программы которых не существует, и
                    пустые папки.

Ограничения - чтобы меню оставалось удобным:

Меню в области уведомлений нельзя прокручивать колесом мыши, только
двумя маленькими кнопками со стрелками, а длинное меню вытеснило бы
KeepAwake, AlwaysOnTop и настройки за пределы видимой области.
Поэтому действуют следующие правила:

  - В одном меню отображается не более 15 записей (папки и ярлыки
    вместе). Это ограничение можно изменить в файле настроек на
    значение от 10 до 20 (см. ниже).
  - Не более 3 уровней меню: меню ToolTime и два уровня подменю.
    Более глубокие папки игнорируются.
  - Не более 400 записей в сумме.

Совет: лучше группируйте множество инструментов по подпапкам, чем
держать их в одном длинном списке.

Если ограничение превышено, ничего не теряется незаметно:

  - Лишние записи не отображаются. Вместо них в меню появляется
    неактивная строка вида "... ещё 3 не показано (лимит 15)".
  - Появляется уведомление, а в разделе ToolTime отображается
    запись "(!) ToolTime: обнаружены проблемы - щёлкните для
    подробностей". Щелчок по ней показывает, что именно было
    пропущено и почему. Те же сведения записываются в файл журнала
    (если включено "Создавать файл журнала").
  - О слишком глубоко вложенных папках и ярлыках, которые не удаётся
    прочитать, сообщается таким же образом.

Параметры в файле настроек (раздел [ToolTime]):

  [ToolTime]
  Enabled=1
  MaxEntries=15
  Folder=

  Enabled      1 = показывать ToolTime, 0 = скрыть (то же, что
               пункт меню "Включить ToolTime")
  MaxEntries   Максимальное число записей в одном меню, от 10 до 20
               (по умолчанию: 15). Другие значения исправляются
               автоматически.
  Folder       Необязательно: путь к другой папке ToolTime.
               Допускаются переменные среды, например
               %USERPROFILE%. Пусто = папка по умолчанию. Если
               папка не существует, она создаётся.

Чтобы отредактировать файл, выберите в меню "Настройки" пункт
"Редактировать файл настроек". После сохранения и закрытия Блокнота
CCTrayTool заново читает файл, сразу применяет все изменения (без
перезапуска) и перестраивает меню.

Восстановление инструментов по умолчанию: закройте CCTrayTool,
удалите папку ToolTime и снова запустите программу - инструменты по
умолчанию и информационный файл будут созданы заново.


-------------------------------------------------------------------
 7. Дополнительные настройки
-------------------------------------------------------------------

В подменю "Настройки" также доступны:

  - Включить ToolTime
      Полностью включает или отключает весь раздел быстрого запуска
      инструментов (см. раздел 5). При отключении ни одна из его
      записей не отображается в меню области уведомлений, независимо
      от того, что находится в папке ToolTime.

  - Открыть папку ToolTime
      Открывает папку ToolTime в проводнике Windows, чтобы
      добавлять, переименовывать или удалять ярлыки (см. раздел 6).

  - Перезагрузить инструменты
      Заново читает папку ToolTime и перестраивает меню. Обычно не
      требуется, так как изменения в папке обнаруживаются
      автоматически.

  - Включить KeepAwake
      Полностью включает или отключает весь раздел KeepAwake (см.
      раздел 2). При отключении его записи исчезают из меню области
      уведомлений, и действует обычное поведение энергосбережения
      Windows.

  - Включить AlwaysOnTop
      Полностью включает или отключает весь раздел AlwaysOnTop (см.
      раздел 3). При отключении его записи исчезают из меню области
      уведомлений, а сочетание клавиш отключается.

  - Включить CloseGuard
      Полностью включает или отключает весь раздел CloseGuard (см.
      раздел 4). При отключении его записи исчезают из меню области
      уведомлений, сочетания клавиш отключаются, а все
      заблокированные окна получают кнопку закрытия обратно.

  - Запускать автоматически
      CCTrayTool будет теперь автоматически запускаться при входе
      в Windows.

  - Создавать файл журнала
      Записывает подробный журнал всех действий в файл журнала.
      Полезно для устранения неполадок, не требуется при обычной
      работе.
      В файле настроек это запись "UseLog" в разделе [Main]:
      1 = включено; 0, пустая или отсутствующая запись либо любое
      другое значение = выключено.

  - Просмотреть файл журнала
      Открывает текущий файл журнала в Блокноте.

  - Использовать крупные значки
      Отображает значки в меню области уведомлений крупнее (32
      вместо 16 пикселей).

  - Редактировать файл настроек
      Открывает файл конфигурации напрямую для редактирования (см.
      раздел 6).


-------------------------------------------------------------------
 8. Расположение файлов
-------------------------------------------------------------------

CCTrayTool сохраняет свои файлы в профиле пользователя:

  Конфигурация:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Файл журнала:    %LocalAppData%\CCTrayTool\CCTrayTool.log
  Папка ToolTime:  %LocalAppData%\CCTrayTool\ToolTime\

Правила CloseGuard хранятся в отдельном файле:

  %LocalAppData%\CCTrayTool\CloseGuardRules.ini

(Путь можно вставить в адресную строку проводника Windows, чтобы
перейти прямо в папку.)


-------------------------------------------------------------------
 9. Завершение работы программы
-------------------------------------------------------------------

CCTrayTool закрывается через пункт меню "Выход". При этом
автоматически восстанавливается обычное поведение
энергосбережения Windows и сохраняется текущая конфигурация.

Все окна, у которых кнопка закрытия заблокирована CloseGuard, при
этом снова получают свою кнопку закрытия.


-------------------------------------------------------------------
 10. О программе / Контакты
-------------------------------------------------------------------

Текущую установленную версию можно в любой момент посмотреть через
пункт меню "О программе".

CCTrayTool - Markus Debus
info@markus-debus.de
Лицензия: GNU General Public License, версия 3 или более поздняя
(GPL-3.0-or-later), с дополнительным условием об указании
авторства; см. файлы LICENSE и NOTICE.
