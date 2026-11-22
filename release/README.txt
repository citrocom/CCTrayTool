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
system tray (bottom right, next to the clock). It combines three
useful functions in one program:

  1. KeepAwake         - prevents the PC from entering power-saving
                          mode or the screen from turning off
  2. AlwaysOnTop        - keeps any window in the foreground using
                          a keyboard shortcut
  3. Tools Quick Start  - launches frequently used programs directly
                          from the tray menu

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

The "Save Status" menu item makes CCTrayTool remember the last
selected KeepAwake setting and automatically restore it on the
next start.

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

  - Hotkey Active        Turns the keyboard shortcut on or off
                          completely
  - Change Hotkey         Opens a dialog where a custom keyboard
                          shortcut can be defined (a combination of
                          Ctrl, Alt, Shift, Win plus a letter, a
                          number, or a function key F1-F12)
  - Show ToolTip          Turns the brief on-screen notification on
                          or off when toggling

Note: The Windows desktop itself ("Program Manager") cannot be set
to "always on top". Not every keyboard combination is available -
some are already reserved by the system or other programs. In this
case, a notice appears and a different combination must be chosen.


-------------------------------------------------------------------
 4. Quick start menu for your own programs
-------------------------------------------------------------------

Above KeepAwake, the tray menu shows the "ToolTime" section: a list
of programs that can be started with a single click. The entries
come from a folder on your PC (see Section 5): every shortcut
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
 5. Adding your own tools and folders
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
 6. Additional settings
-------------------------------------------------------------------

The "Settings" submenu also offers:

  - Enable ToolTime
      Turns the entire tool quick-start section (see Section 4) on
      or off. When turned off, none of its entries appear in the
      tray menu, no matter what is in the ToolTime folder.

  - Open ToolTime Folder
      Opens the ToolTime folder in Windows Explorer, so that
      shortcuts can be added, renamed or removed (see Section 5).

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
      Section 5).


-------------------------------------------------------------------
 7. Storage locations
-------------------------------------------------------------------

CCTrayTool stores its files in the user profile:

  Configuration:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Logfile:          %LocalAppData%\CCTrayTool\CCTrayTool.log
  ToolTime folder:  %LocalAppData%\CCTrayTool\ToolTime\

(The path can be pasted into Windows Explorer's address bar to go
directly to the folder.)


-------------------------------------------------------------------
 8. Closing the program
-------------------------------------------------------------------

CCTrayTool is closed via the "Exit" menu item. This automatically
restores normal Windows power-saving behavior and saves the current
configuration.


-------------------------------------------------------------------
 9. About / Contact
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
System-Tray (unten rechts neben der Uhr) läuft. Es vereint drei
nützliche Funktionen in einem Programm:

  1. KeepAwake        - verhindert, dass der PC in den Energiesparmodus
                         wechselt oder der Bildschirm sich abschaltet
  2. AlwaysOnTop       - hält per Tastenkombination ein beliebiges
                         Fenster im Vordergrund
  3. Tools-Schnellstart - startet häufig genutzte Programme direkt
                         über das Traymenü

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

Über den Menüpunkt "Status speichern" merkt sich CCTrayTool die
zuletzt gewählte KeepAwake-Einstellung und stellt sie beim
nächsten Start automatisch wieder her.

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

  - Hotkey aktiv        Schaltet die Tastenkombination komplett
                         ein oder aus
  - Hotkey ändern        Öffnet einen Dialog, in dem eine eigene
                         Tastenkombination festgelegt werden kann
                         (Kombination aus Strg/Ctrl, Alt, Shift,
                         Win + einem Buchstaben, einer Zahl oder
                         einer Funktionstaste F1-F12)
  - ToolTip anzeigen      Schaltet den kurzen Bildschirmhinweis
                         beim Umschalten ein oder aus

Hinweis: Der Windows-Desktop selbst ("Program Manager") kann nicht
auf "immer im Vordergrund" gesetzt werden. Nicht jede Tastenkombi-
nation ist frei - manche sind bereits vom System oder anderen
Programmen belegt. In diesem Fall erscheint ein Hinweis, und es
muss eine andere Kombination gewählt werden.


-------------------------------------------------------------------
 4. Schnellstart-Menü für eigene Programme
-------------------------------------------------------------------

Oberhalb von KeepAwake zeigt das Traymenü den Bereich "ToolTime":
eine Liste von Programmen, die sich mit einem Klick starten lassen.
Die Einträge stammen aus einem Ordner auf Ihrem PC (siehe
Abschnitt 5): Jede Verknüpfung (.lnk-Datei) in diesem Ordner wird
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
 5. Eigene Tools und Ordner hinzufügen
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
 6. Weitere Einstellungen
-------------------------------------------------------------------

Im Untermenü "Einstellungen" stehen zusätzlich zur Verfügung:

  - ToolTime aktivieren
      Schaltet den gesamten Tools-Schnellstart-Bereich (siehe
      Abschnitt 4) komplett ein oder aus. Bei Deaktivierung
      erscheinen keine seiner Einträge im Traymenü, unabhängig
      davon, was sich im ToolTime-Ordner befindet.

  - ToolTime-Ordner öffnen
      Öffnet den ToolTime-Ordner im Windows-Explorer, damit
      Verknüpfungen hinzugefügt, umbenannt oder entfernt werden
      können (siehe Abschnitt 5).

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
      Abschnitt 5).


-------------------------------------------------------------------
 7. Speicherorte
-------------------------------------------------------------------

CCTrayTool legt seine Dateien im Benutzerprofil ab:

  Konfiguration:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Logfile:          %LocalAppData%\CCTrayTool\CCTrayTool.log
  ToolTime-Ordner:  %LocalAppData%\CCTrayTool\ToolTime\

(Der Pfad lässt sich in die Windows-Adressleiste des Explorers
einfügen, um direkt zum Ordner zu gelangen.)


-------------------------------------------------------------------
 8. Programm beenden
-------------------------------------------------------------------

Über den Menüpunkt "Beenden" wird CCTrayTool geschlossen. Dabei
wird automatisch das normale Energiesparverhalten von Windows
wiederhergestellt und die aktuelle Konfiguration gespeichert.


-------------------------------------------------------------------
 9. Über / Kontakt
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
all'orologio). Riunisce tre funzioni utili in un unico programma:

  1. KeepAwake          - impedisce che il PC entri in modalità di
                           risparmio energetico o che lo schermo si
                           spenga
  2. AlwaysOnTop         - mantiene una finestra qualsiasi sempre in
                           primo piano tramite una combinazione di
                           tasti
  3. Avvio rapido strumenti - avvia i programmi usati più spesso
                           direttamente dal menu dell'area di
                           notifica

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

La voce di menu "Salva stato" fa sì che CCTrayTool memorizzi
l'ultima impostazione KeepAwake selezionata e la ripristini
automaticamente al successivo avvio.

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

  - Hotkey attivo         Attiva o disattiva completamente la
                           combinazione di tasti
  - Cambia hotkey          Apre una finestra di dialogo in cui è
                           possibile impostare una combinazione di
                           tasti personalizzata (combinazione di
                           Ctrl, Alt, Maiusc, Win più una lettera,
                           un numero o un tasto funzione F1-F12)
  - Mostra ToolTip          Attiva o disattiva il breve avviso a
                           schermo al momento del cambio

Nota: Il desktop di Windows stesso ("Program Manager") non può
essere impostato su "sempre in primo piano". Non tutte le
combinazioni di tasti sono libere: alcune sono già occupate dal
sistema o da altri programmi. In questo caso viene visualizzato un
avviso ed è necessario scegliere un'altra combinazione.


-------------------------------------------------------------------
 4. Menu di avvio rapido per programmi personalizzati
-------------------------------------------------------------------

Sopra KeepAwake, il menu dell'area di notifica mostra la sezione
"ToolTime": un elenco di programmi che si avviano con un solo clic.
Le voci provengono da una cartella del PC (vedi sezione 5): ogni
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
 5. Aggiungere strumenti e cartelle personalizzati
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
 6. Altre impostazioni
-------------------------------------------------------------------

Nel sottomenu "Impostazioni" sono inoltre disponibili:

  - Attiva ToolTime
      Attiva o disattiva completamente l'intera sezione di avvio
      rapido degli strumenti (vedi sezione 4). Se disattivata,
      nessuna delle sue voci compare nel menu dell'area di notifica,
      indipendentemente da ciò che si trova nella cartella ToolTime.

  - Apri cartella ToolTime
      Apre la cartella ToolTime in Esplora file, per aggiungere,
      rinominare o rimuovere collegamenti (vedi sezione 5).

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
      (vedi sezione 5).


-------------------------------------------------------------------
 7. Percorsi di archiviazione
-------------------------------------------------------------------

CCTrayTool salva i propri file nel profilo utente:

  Configurazione:     %LocalAppData%\CCTrayTool\CCTrayTool.ini
  File di log:        %LocalAppData%\CCTrayTool\CCTrayTool.log
  Cartella ToolTime:  %LocalAppData%\CCTrayTool\ToolTime\

(Il percorso può essere incollato nella barra degli indirizzi di
Esplora risorse per accedere direttamente alla cartella.)


-------------------------------------------------------------------
 8. Chiudere il programma
-------------------------------------------------------------------

CCTrayTool viene chiuso tramite la voce di menu "Esci". In questo
modo viene ripristinato automaticamente il normale comportamento
di risparmio energetico di Windows e viene salvata la
configurazione attuale.


-------------------------------------------------------------------
 9. Informazioni / Contatti
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
al reloj). Combina tres funciones útiles en un solo programa:

  1. KeepAwake            - evita que el PC entre en modo de ahorro
                             de energía o que la pantalla se apague
  2. AlwaysOnTop           - mantiene cualquier ventana en primer
                             plano mediante una combinación de
                             teclas
  3. Inicio rápido de herramientas - inicia programas de uso
                             frecuente directamente desde el menú
                             de la bandeja del sistema

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

La opción de menú "Guardar estado" hace que CCTrayTool recuerde la
última configuración de KeepAwake seleccionada y la restaure
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

  - Hotkey activo          Activa o desactiva por completo la
                            combinación de teclas
  - Cambiar hotkey          Abre un cuadro de diálogo en el que se
                            puede definir una combinación de teclas
                            personalizada (combinación de Ctrl,
                            Alt, Mayús, Win más una letra, un
                            número o una tecla de función F1-F12)
  - Mostrar ToolTip          Activa o desactiva el breve aviso en
                            pantalla al cambiar el estado

Nota: El propio escritorio de Windows ("Program Manager") no se
puede configurar como "siempre en primer plano". No todas las
combinaciones de teclas están libres; algunas ya están reservadas
por el sistema u otros programas. En ese caso aparece un aviso y
debe elegirse otra combinación.


-------------------------------------------------------------------
 4. Menú de inicio rápido para programas propios
-------------------------------------------------------------------

Encima de KeepAwake, el menú de la bandeja muestra la sección
"ToolTime": una lista de programas que se pueden iniciar con un
solo clic. Las entradas proceden de una carpeta de su PC (véase la
sección 5): cada acceso directo (archivo .lnk) de esta carpeta se
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
 5. Añadir herramientas y carpetas propias
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
 6. Configuración adicional
-------------------------------------------------------------------

En el submenú "Configuración" también están disponibles:

  - Activar ToolTime
      Activa o desactiva por completo toda la sección de inicio
      rápido de herramientas (véase la sección 4). Si se desactiva,
      ninguna de sus entradas aparece en el menú de la bandeja,
      independientemente de lo que haya en la carpeta ToolTime.

  - Abrir carpeta ToolTime
      Abre la carpeta ToolTime en el Explorador de Windows para
      añadir, renombrar o eliminar accesos directos (véase la
      sección 5).

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
      (véase la sección 5).


-------------------------------------------------------------------
 7. Ubicaciones de almacenamiento
-------------------------------------------------------------------

CCTrayTool guarda sus archivos en el perfil de usuario:

  Configuración:        %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Archivo de registro:  %LocalAppData%\CCTrayTool\CCTrayTool.log
  Carpeta ToolTime:     %LocalAppData%\CCTrayTool\ToolTime\

(La ruta se puede pegar en la barra de direcciones del Explorador
de Windows para ir directamente a la carpeta.)


-------------------------------------------------------------------
 8. Cerrar el programa
-------------------------------------------------------------------

CCTrayTool se cierra mediante la opción de menú "Salir". Esto
restaura automáticamente el comportamiento normal de ahorro de
energía de Windows y guarda la configuración actual.


-------------------------------------------------------------------
 9. Acerca de / Contacto
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
l'horloge). Il regroupe trois fonctions utiles en un seul
programme :

  1. KeepAwake             - empêche le PC de passer en mode
                              d'économie d'énergie ou l'écran de
                              s'éteindre
  2. AlwaysOnTop            - maintient une fenêtre au premier plan
                              via un raccourci clavier
  3. Démarrage rapide d'outils - lance directement les programmes
                              fréquemment utilisés depuis le menu
                              de la zone de notification

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

L'option de menu "Enregistrer l'état" permet à CCTrayTool de
mémoriser le dernier réglage KeepAwake sélectionné et de le
restaurer automatiquement au prochain démarrage.

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

  - Raccourci actif         Active ou désactive complètement le
                             raccourci clavier
  - Modifier le raccourci    Ouvre une boîte de dialogue permettant
                             de définir un raccourci clavier
                             personnalisé (combinaison de Ctrl,
                             Alt, Maj, Win plus une lettre, un
                             chiffre ou une touche de fonction
                             F1-F12)
  - Afficher l'infobulle     Active ou désactive la brève
                             notification à l'écran lors du
                             basculement

Remarque : Le bureau Windows lui-même ("Program Manager") ne peut
pas être défini sur "toujours au premier plan". Toutes les
combinaisons de touches ne sont pas libres : certaines sont déjà
réservées par le système ou d'autres programmes. Dans ce cas, un
message apparaît et une autre combinaison doit être choisie.


-------------------------------------------------------------------
 4. Menu de démarrage rapide pour vos propres programmes
-------------------------------------------------------------------

Au-dessus de KeepAwake, le menu de la zone de notification affiche
la section "ToolTime" : une liste de programmes que l'on peut
démarrer d'un simple clic. Les entrées proviennent d'un dossier de
votre PC (voir section 5) : chaque raccourci (fichier .lnk) de ce
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
 5. Ajouter ses propres outils et dossiers
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
 6. Autres paramètres
-------------------------------------------------------------------

Le sous-menu "Paramètres" propose également :

  - Activer ToolTime
      Active ou désactive entièrement la section de démarrage
      rapide des outils (voir section 4). Si désactivée, aucune de
      ses entrées n'apparaît dans le menu de la zone de
      notification, quel que soit le contenu du dossier ToolTime.

  - Ouvrir le dossier ToolTime
      Ouvre le dossier ToolTime dans l'Explorateur Windows afin
      d'ajouter, de renommer ou de supprimer des raccourcis (voir
      section 5).

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
      modification (voir section 5).


-------------------------------------------------------------------
 7. Emplacements de stockage
-------------------------------------------------------------------

CCTrayTool enregistre ses fichiers dans le profil utilisateur :

  Configuration :     %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Fichier journal :   %LocalAppData%\CCTrayTool\CCTrayTool.log
  Dossier ToolTime :  %LocalAppData%\CCTrayTool\ToolTime\

(Le chemin peut être collé dans la barre d'adresse de l'Explorateur
Windows pour accéder directement au dossier.)


-------------------------------------------------------------------
 8. Fermer le programme
-------------------------------------------------------------------

CCTrayTool se ferme via l'option de menu "Quitter". Cela restaure
automatiquement le comportement normal d'économie d'énergie de
Windows et enregistre la configuration actuelle.


-------------------------------------------------------------------
 9. À propos / Contact
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
Łączy trzy przydatne funkcje w jednym programie:

  1. KeepAwake           - zapobiega przechodzeniu komputera w tryb
                            oszczędzania energii lub wyłączaniu się
                            ekranu
  2. AlwaysOnTop          - utrzymuje dowolne okno na pierwszym
                            planie za pomocą skrótu klawiszowego
  3. Szybkie uruchamianie narzędzi - uruchamia często używane
                            programy bezpośrednio z menu zasobnika

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

Opcja menu "Zapisz stan" powoduje, że CCTrayTool zapamiętuje
ostatnio wybrane ustawienie KeepAwake i przywraca je automatycznie
przy następnym uruchomieniu.

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

  - Skrót aktywny            Całkowicie włącza lub wyłącza skrót
                              klawiszowy
  - Zmień skrót               Otwiera okno dialogowe, w którym
                              można ustawić własny skrót klawiszowy
                              (kombinacja Ctrl, Alt, Shift, Win oraz
                              litery, cyfry lub klawisza funkcyjnego
                              F1-F12)
  - Pokaż dymek                Włącza lub wyłącza krótki komunikat
                              na ekranie podczas przełączania

Uwaga: Samego pulpitu Windows ("Program Manager") nie można ustawić
na "zawsze na wierzchu". Nie każda kombinacja klawiszy jest wolna -
niektóre są już zajęte przez system lub inne programy. W takim
przypadku pojawia się komunikat i należy wybrać inną kombinację.


-------------------------------------------------------------------
 4. Menu szybkiego uruchamiania własnych programów
-------------------------------------------------------------------

Nad KeepAwake menu zasobnika pokazuje sekcję "ToolTime": listę
programów, które można uruchomić jednym kliknięciem. Pozycje
pochodzą z folderu na komputerze (patrz punkt 5): każdy skrót (plik
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
 5. Dodawanie własnych narzędzi i folderów
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
 6. Dodatkowe ustawienia
-------------------------------------------------------------------

W podmenu "Ustawienia" dostępne są dodatkowo:

  - Włącz ToolTime
      Całkowicie włącza lub wyłącza sekcję szybkiego uruchamiania
      narzędzi (patrz punkt 4). Po wyłączeniu żadna z jej pozycji
      nie pojawia się w menu zasobnika, niezależnie od zawartości
      folderu ToolTime.

  - Otwórz folder ToolTime
      Otwiera folder ToolTime w Eksploratorze Windows, aby dodawać,
      zmieniać nazwy lub usuwać skróty (patrz punkt 5).

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
      punkt 5).


-------------------------------------------------------------------
 7. Lokalizacje przechowywania
-------------------------------------------------------------------

CCTrayTool przechowuje swoje pliki w profilu użytkownika:

  Konfiguracja:     %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Plik dziennika:   %LocalAppData%\CCTrayTool\CCTrayTool.log
  Folder ToolTime:  %LocalAppData%\CCTrayTool\ToolTime\

(Ścieżkę można wkleić do paska adresu Eksploratora Windows, aby
przejść bezpośrednio do folderu.)


-------------------------------------------------------------------
 8. Zamykanie programu
-------------------------------------------------------------------

CCTrayTool zamyka się za pomocą opcji menu "Zakończ". Powoduje to
automatyczne przywrócenie normalnego zachowania oszczędzania
energii Windows oraz zapisanie bieżącej konfiguracji.


-------------------------------------------------------------------
 9. Informacje / Kontakt
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
tálcán (jobbra lent, az óra mellett). Három hasznos funkciót
egyesít egyetlen programban:

  1. KeepAwake             - megakadályozza, hogy a számítógép
                              energiatakarékos módba váltson, vagy
                              hogy a képernyő kikapcsoljon
  2. AlwaysOnTop            - billentyűkombinációval bármely ablakot
                              az előtérben tart
  3. Eszközök gyorsindítása - egy kattintással indítja a gyakran
                              használt programokat közvetlenül a
                              tálcamenüből

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

Az "Állapot mentése" menüpont hatására a CCTrayTool megjegyzi az
utoljára kiválasztott KeepAwake-beállítást, és a következő
induláskor automatikusan visszaállítja.

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

  - Gyorsbillentyű aktív      Teljesen be- vagy kikapcsolja a
                               billentyűkombinációt
  - Gyorsbillentyű módosítása  Megnyit egy párbeszédablakot, ahol
                               saját billentyűkombináció adható meg
                               (Ctrl, Alt, Shift, Win kombinációja
                               egy betűvel, számmal vagy F1-F12
                               funkcióbillentyűvel)
  - ToolTip megjelenítése      Be- vagy kikapcsolja a rövid
                               képernyőn megjelenő értesítést
                               váltáskor

Megjegyzés: Maga a Windows asztal ("Program Manager") nem
állítható be "mindig az előtérben" módra. Nem minden
billentyűkombináció szabad - néhányat már a rendszer vagy más
programok lefoglaltak. Ilyenkor egy értesítés jelenik meg, és más
kombinációt kell választani.


-------------------------------------------------------------------
 4. Gyorsindító menü saját programokhoz
-------------------------------------------------------------------

A KeepAwake fölött a tálcamenü megjeleníti a "ToolTime" szakaszt:
egy kattintással indítható programok listáját. A bejegyzések a
számítógép egyik mappájából származnak (lásd 5. pont): a mappában
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
 5. Saját eszközök és mappák hozzáadása
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
 6. További beállítások
-------------------------------------------------------------------

A "Beállítások" almenüben ezenkívül elérhető:

  - ToolTime bekapcsolása
      Teljesen be- vagy kikapcsolja az eszközök gyorsindító
      szakaszát (lásd 4. pont). Kikapcsolt állapotban egyik
      bejegyzése sem jelenik meg a tálcamenüben, függetlenül attól,
      hogy mi van a ToolTime mappában.

  - ToolTime mappa megnyitása
      Megnyitja a ToolTime mappát a Windows Intézőben, hogy
      parancsikonokat lehessen hozzáadni, átnevezni vagy törölni
      (lásd 5. pont).

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
      (lásd az 5. pontot).


-------------------------------------------------------------------
 7. Tárolási helyek
-------------------------------------------------------------------

A CCTrayTool a saját fájljait a felhasználói profilban tárolja:

  Konfiguráció:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Naplófájl:       %LocalAppData%\CCTrayTool\CCTrayTool.log
  ToolTime mappa:  %LocalAppData%\CCTrayTool\ToolTime\

(Az elérési út beilleszthető a Windows Intéző címsorába, hogy
közvetlenül a mappához jusson.)


-------------------------------------------------------------------
 8. A program bezárása
-------------------------------------------------------------------

A CCTrayTool a "Kilépés" menüponttal zárható be. Ez automatikusan
visszaállítja a Windows normál energiatakarékossági viselkedését,
és elmenti az aktuális konfigurációt.


-------------------------------------------------------------------
 9. Névjegy / Kapcsolat
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
Она объединяет три полезные функции в одной программе:

  1. KeepAwake              - не позволяет ПК переходить в режим
                               энергосбережения или отключать экран
  2. AlwaysOnTop             - удерживает любое окно поверх других
                               окон с помощью сочетания клавиш
  3. Быстрый запуск инструментов - запускает часто используемые
                               программы прямо из меню области
                               уведомлений

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

Пункт меню "Сохранить состояние" заставляет CCTrayTool запоминать
последнюю выбранную настройку KeepAwake и автоматически
восстанавливать её при следующем запуске.

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
  - Изменить горячую клавишу   Открывает диалоговое окно, в котором
                               можно задать собственное сочетание
                               клавиш (комбинация Ctrl, Alt, Shift,
                               Win и буквы, цифры или функциональной
                               клавиши F1-F12)
  - Показывать подсказку       Включает или отключает короткое
                               уведомление на экране при
                               переключении

Примечание: Сам рабочий стол Windows ("Program Manager") нельзя
установить в режим "поверх всех окон". Не каждое сочетание клавиш
свободно - некоторые уже заняты системой или другими программами.
В этом случае появляется уведомление, и необходимо выбрать другое
сочетание.


-------------------------------------------------------------------
 4. Меню быстрого запуска собственных программ
-------------------------------------------------------------------

Над разделом KeepAwake меню в области уведомлений показывает раздел
"ToolTime": список программ, которые можно запустить одним щелчком.
Записи берутся из папки на вашем компьютере (см. раздел 5): каждый
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
 5. Добавление собственных инструментов и папок
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
 6. Дополнительные настройки
-------------------------------------------------------------------

В подменю "Настройки" также доступны:

  - Включить ToolTime
      Полностью включает или отключает весь раздел быстрого запуска
      инструментов (см. раздел 4). При отключении ни одна из его
      записей не отображается в меню области уведомлений, независимо
      от того, что находится в папке ToolTime.

  - Открыть папку ToolTime
      Открывает папку ToolTime в проводнике Windows, чтобы
      добавлять, переименовывать или удалять ярлыки (см. раздел 5).

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
      раздел 5).


-------------------------------------------------------------------
 7. Расположение файлов
-------------------------------------------------------------------

CCTrayTool сохраняет свои файлы в профиле пользователя:

  Конфигурация:    %LocalAppData%\CCTrayTool\CCTrayTool.ini
  Файл журнала:    %LocalAppData%\CCTrayTool\CCTrayTool.log
  Папка ToolTime:  %LocalAppData%\CCTrayTool\ToolTime\

(Путь можно вставить в адресную строку проводника Windows, чтобы
перейти прямо в папку.)


-------------------------------------------------------------------
 8. Завершение работы программы
-------------------------------------------------------------------

CCTrayTool закрывается через пункт меню "Выход". При этом
автоматически восстанавливается обычное поведение
энергосбережения Windows и сохраняется текущая конфигурация.


-------------------------------------------------------------------
 9. О программе / Контакты
-------------------------------------------------------------------

Текущую установленную версию можно в любой момент посмотреть через
пункт меню "О программе".

CCTrayTool - Markus Debus
info@markus-debus.de
Лицензия: GNU General Public License, версия 3 или более поздняя
(GPL-3.0-or-later), с дополнительным условием об указании
авторства; см. файлы LICENSE и NOTICE.
