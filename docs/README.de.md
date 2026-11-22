# CCTrayTool – Bedienungsanleitung

[English](../README.md) · **Deutsch** · [Italiano](README.it.md) · [Español](README.es.md) · [Français](README.fr.md) · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool ist ein kleines Windows-Tool, das als Symbol im System-Tray (unten rechts neben der Uhr) läuft. Es vereint drei nützliche Funktionen in einem Programm:

1. **KeepAwake** – verhindert, dass der PC in den Energiesparmodus wechselt oder der Bildschirm sich abschaltet
2. **AlwaysOnTop** – hält per Tastenkombination ein beliebiges Fenster im Vordergrund
3. **Tools-Schnellstart** – startet häufig genutzte Programme direkt über das Traymenü

Alle Funktionen werden über ein Rechtsklick-Menü auf das Tray-Symbol bedient. Eine Installation ist nicht nötig, das Programm kann direkt gestartet werden.

CCTrayTool unterstützt die Sprachen Englisch, Deutsch, Italienisch, Spanisch, Französisch, Polnisch, Ungarisch und Russisch. Die Sprache wird basierend auf der Systemsprache des Computers automatisch eingestellt.

Systemvoraussetzung: Ein 64-Bit-Windows 10 oder neuer ist erforderlich. Auf 32-Bit-Windows läuft das Programm nicht.

## 1. Start und erstes Symbol

Nach dem Start erscheint ein Symbol im Tray-Bereich der Windows-Taskleiste. Die Farbe des Symbols zeigt sofort den aktuellen KeepAwake-Status an:

- Weiß = KeepAwake deaktiviert (normales Windows-Verhalten)
- Rot = KeepAwake für Monitore aktiv
- Blau = KeepAwake für System aktiv
- Grün = KeepAwake für Monitore und System aktiv

Ein Klick mit der rechten Maustaste auf das Symbol öffnet das Menü mit allen Funktionen. Falls das Symbol nicht sichtbar ist, lohnt ein Blick in die "ausgeblendeten Symbole" (kleiner Pfeil in der Taskleiste).

Hinweis: CCTrayTool kann nur einmal gleichzeitig gestartet werden. Ein zweiter Start hat keine Wirkung, falls das Programm bereits läuft.

## 2. KeepAwake - Energiesparen unterbinden

Im Menüabschnitt "KeepAwake" lässt sich auswählen, was der PC NICHT tun soll, während CCTrayTool läuft:

- **Monitore und System**: Weder der Bildschirm schaltet sich ab, noch geht der PC in den Energiesparmodus/Standby. Ideal für Präsentationen oder lang laufende Vorgänge, bei denen der Bildschirm sichtbar bleiben muss.
- **Monitore**: Nur der Bildschirm bleibt an (kein Abschalten, kein Bildschirmschoner). Der PC selbst kann trotzdem nach seiner eigenen Zeit in den Standby wechseln.
- **System**: Der PC geht nicht in den Standby/Energiesparmodus, der Bildschirm kann sich aber nach der Windows-Einstellung trotzdem abschalten. Praktisch z. B. für lange Downloads oder Berechnungen im Hintergrund.
- **Deaktiviert**: CCTrayTool greift nicht ein, es gilt das normale Energiespar-Verhalten von Windows.

Über den Menüpunkt "Status speichern" merkt sich CCTrayTool die zuletzt gewählte KeepAwake-Einstellung und stellt sie beim nächsten Start automatisch wieder her.

Beim Beenden von CCTrayTool wird das normale Energiesparverhalten von Windows automatisch wiederhergestellt.

## 3. AlwaysOnTop - Fenster im Vordergrund halten

Mit der Tastenkombination SHIFT + ALT + T (Standardbelegung) wird das aktuell aktive Fenster dauerhaft im Vordergrund gehalten - auch wenn andere Fenster angeklickt werden. Ein erneutes Drücken hebt diese Fixierung wieder auf.

Beim Umschalten erscheint kurz ein kleiner Hinweis in der Nähe des Mauszeigers, der bestätigt, ob das Fenster nun "im Vordergrund bleibt" oder "wieder normal" ist. Dieser Hinweis lässt sich über den Menüpunkt "ToolTip anzeigen" ein- oder ausschalten.

Im Menü "AlwaysOnTop" stehen folgende Optionen zur Verfügung:

- **Hotkey aktiv**: Schaltet die Tastenkombination komplett ein oder aus
- **Hotkey ändern**: Öffnet einen Dialog, in dem eine eigene Tastenkombination festgelegt werden kann (Kombination aus Strg/Ctrl, Alt, Shift, Win + einem Buchstaben, einer Zahl oder einer Funktionstaste F1-F12)
- **ToolTip anzeigen**: Schaltet den kurzen Bildschirmhinweis beim Umschalten ein oder aus

Hinweis: Der Windows-Desktop selbst ("Program Manager") kann nicht auf "immer im Vordergrund" gesetzt werden. Nicht jede Tastenkombi-nation ist frei - manche sind bereits vom System oder anderen Programmen belegt. In diesem Fall erscheint ein Hinweis, und es muss eine andere Kombination gewählt werden.

## 4. Schnellstart-Menü für eigene Programme

Oberhalb von KeepAwake zeigt das Traymenü den Bereich "ToolTime": eine Liste von Programmen, die sich mit einem Klick starten lassen. Die Einträge stammen aus einem Ordner auf Ihrem PC (siehe Abschnitt 5): Jede Verknüpfung (`.lnk`-Datei) in diesem Ordner wird zu einem Menüeintrag, jeder Unterordner zu einem Untermenü.

Im Auslieferungszustand sind bereits einige Windows-Bordmittel eingerichtet, u. a.:

- Rechner, Notepad (Ordner "Office")
- Explorer (direkt im Hauptmenü)
- Eingabeaufforderung, Registrierungs-Editor, Netzwerkeinstellungen, Systemsteuerung, Ressourcenmonitor, Leistungsüberwachung, Dienste verwalten, Datenträgerbereinigung (Ordner "System")

Verknüpfungen, deren Programm auf dem jeweiligen PC nicht gefunden wird, erscheinen automatisch nicht im Menü - es kommt also zu keiner Fehlermeldung, wenn ein Tool auf einem System fehlt.

Einige Einträge (z. B. Eingabeaufforderung, Regedit) sind so eingerichtet, dass sie automatisch mit Administratorrechten gestartet werden (Windows fragt in diesem Fall über die Benutzerkontensteuerung nach Bestätigung).

## 5. Eigene Tools und Ordner hinzufügen

Die Tools im Schnellstart-Menü sind einfach Verknüpfungen in einem Ordner. Um ein Tool hinzuzufügen, im Menü "Einstellungen" den Punkt "ToolTime-Ordner öffnen" wählen und im geöffneten Ordner eine Verknüpfung (`.lnk`-Datei) ablegen. CCTrayTool bemerkt die Änderung selbstständig und aktualisiert das Traymenü kurz darauf. (Falls das einmal nicht geschieht, hilft "Tools neu laden" im Menü "Einstellungen".)

Eine Verknüpfung lässt sich schnell erstellen: ein Programm mit der rechten Maustaste in den Ordner ziehen und "Verknüpfungen hier erstellen" wählen.

Standardordner: `%LocalAppData%\CCTrayTool\ToolTime` (Ein anderer Ordner kann in der Einstellungsdatei festgelegt werden, siehe unten.)

Beim Anlegen des ToolTime-Ordners legt CCTrayTool außerdem eine kurze Infodatei darin ab ("`ToolTime_Info.txt`", in der Sprache des Systems). Sie erklärt knapp die Grenzen und wie sich Einträge mit einer vorangestellten Zahl sortieren lassen. Das Menü ignoriert die Datei; sie kann jederzeit gelöscht werden.

So wird aus dem Ordner das Menü:

- **Verknüpfung (`.lnk`)**: wird zu einem Menüeintrag. Der Name ist der Dateiname, das Symbol stammt aus der Verknüpfung (bzw. aus dem Programm, auf das sie zeigt).
- **Unterordner**: wird zu einem Untermenü. Das Ordnersymbol lässt sich wie gewohnt im Windows-Explorer ändern (Eigenschaften > Anpassen > Anderes Symbol).
- **Reihenfolge**: Zuerst kommen die Ordner, dann die Verknüpfungen, jeweils alphabetisch sortiert. Für eine eigene Reihenfolge den Namen mit zwei oder drei Ziffern und einem Unterstrich beginnen, z. B. "`01_Notepad.lnk`". Die Zahl dient nur der Sortierung und wird nicht angezeigt.
- **Administrator**: In den Eigenschaften der Verknüpfung "Als Administrator ausführen" aktivieren (Verknüpfung > Erweitert). Windows fragt dann beim Start des Eintrags nach Bestätigung.
- **Nicht angezeigt**: Versteckte Dateien, Dateien, die keine Verknüpfungen sind, Verknüpfungen, deren Programm nicht existiert, und leere Ordner.

Grenzen - damit das Menü bedienbar bleibt:

Ein Traymenü lässt sich nicht mit dem Mausrad scrollen, sondern nur über zwei kleine Pfeilschaltflächen, und ein langes Menü würde KeepAwake, AlwaysOnTop und die Einstellungen aus dem sichtbaren Bereich schieben. Deshalb gilt:

- Pro Menü werden höchstens 15 Einträge (Ordner und Verknüpfungen zusammen) angezeigt. Diese Grenze lässt sich in der Einstellungsdatei auf einen Wert zwischen 10 und 20 ändern (siehe unten).
- Höchstens 3 Menüebenen: das ToolTime-Menü plus zwei Ebenen Untermenüs. Tiefer liegende Ordner werden ignoriert.
- Höchstens 400 Einträge insgesamt.

Tipp: Viele Tools lieber in Unterordnern gruppieren als in einer langen Liste.

Wird eine Grenze überschritten, geht nichts unbemerkt verloren:

- Die überzähligen Einträge werden nicht angezeigt. Stattdessen enthält das Menü eine ausgegraute Zeile wie "... 3 weitere nicht angezeigt (Limit 15)".
- Es erscheint eine Benachrichtigung, und der Bereich ToolTime zeigt den Eintrag "(!) ToolTime: Probleme gefunden - zum Anzeigen der Details klicken". Ein Klick darauf listet genau auf, was ignoriert wurde und warum. Dieselben Informationen werden ins Logfile geschrieben (sofern "Logfile erstellen" aktiviert ist).
- Zu tief verschachtelte Ordner und Verknüpfungen, die nicht gelesen werden können, werden auf dieselbe Weise gemeldet.

Einstellungen in der Einstellungsdatei (Abschnitt `[ToolTime]`):

```ini
[ToolTime]
Enabled=1
MaxEntries=15
Folder=
```

- `Enabled`: 1 = ToolTime anzeigen, 0 = ausblenden (entspricht dem Menüpunkt "ToolTime aktivieren")
- `MaxEntries`: Höchstzahl der Einträge pro Menü, 10 bis 20 (Standard: 15). Andere Werte werden automatisch korrigiert.
- `Folder`: Optional: Pfad eines anderen ToolTime-Ordners. Umgebungsvariablen wie `%USERPROFILE%` sind erlaubt. Leer = Standardordner. Existiert der Ordner nicht, wird er angelegt.

Zum Bearbeiten der Datei im Menü "Einstellungen" den Punkt "Einstellungsdatei bearbeiten" wählen. Nach dem Speichern und Schließen von Notepad liest CCTrayTool die Datei neu ein, übernimmt alle Änderungen sofort (ohne Neustart) und baut das Traymenü neu auf.

Standard-Tools wiederherstellen: CCTrayTool beenden, den ToolTime-Ordner löschen und das Programm neu starten - die Standard-Tools und die Infodatei werden neu angelegt.

## 6. Weitere Einstellungen

Im Untermenü "Einstellungen" stehen zusätzlich zur Verfügung:

- **ToolTime aktivieren**: Schaltet den gesamten Tools-Schnellstart-Bereich (siehe Abschnitt 4) komplett ein oder aus. Bei Deaktivierung erscheinen keine seiner Einträge im Traymenü, unabhängig davon, was sich im ToolTime-Ordner befindet.
- **ToolTime-Ordner öffnen**: Öffnet den ToolTime-Ordner im Windows-Explorer, damit Verknüpfungen hinzugefügt, umbenannt oder entfernt werden können (siehe Abschnitt 5).
- **Tools neu laden**: Liest den ToolTime-Ordner erneut ein und baut das Menü neu auf. Normalerweise nicht nötig, da Änderungen im Ordner automatisch erkannt werden.
- **KeepAwake aktivieren**: Schaltet den gesamten KeepAwake-Bereich (siehe Abschnitt 2) komplett ein oder aus. Bei Deaktivierung verschwinden seine Einträge aus dem Traymenü, und es gilt das normale Energiesparverhalten von Windows.
- **AlwaysOnTop aktivieren**: Schaltet den gesamten AlwaysOnTop-Bereich (siehe Abschnitt 3) komplett ein oder aus. Bei Deaktivierung verschwinden seine Einträge aus dem Traymenü, und die Tastenkombination wird deaktiviert.
- **Automatisch starten**: CCTrayTool startet künftig automatisch bei der Windows-Anmeldung.
- **Logfile erstellen**: Schreibt ein detailliertes Protokoll aller Aktionen in eine Log-Datei. Hilfreich zur Fehlersuche, im Normalbetrieb nicht erforderlich. In der Einstellungsdatei ist das der Eintrag "`UseLog`" im Abschnitt `[Main]`: 1 = ein; 0, ein leerer oder fehlender Eintrag oder jeder andere Wert = aus.
- **Logfile ansehen**: Öffnet die aktuelle Log-Datei in Notepad.
- **Große Icons verwenden**: Zeigt die Symbole im Traymenü größer an (32 statt 16 Pixel).
- **Einstellungsdatei bearbeiten**: Öffnet die Konfigurationsdatei direkt zur Bearbeitung (siehe Abschnitt 5).

## 7. Speicherorte

CCTrayTool legt seine Dateien im Benutzerprofil ab:

- **Konfiguration:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Logfile:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **ToolTime-Ordner:** `%LocalAppData%\CCTrayTool\ToolTime\`

(Der Pfad lässt sich in die Windows-Adressleiste des Explorers einfügen, um direkt zum Ordner zu gelangen.)

## 8. Programm beenden

Über den Menüpunkt "Beenden" wird CCTrayTool geschlossen. Dabei wird automatisch das normale Energiesparverhalten von Windows wiederhergestellt und die aktuelle Konfiguration gespeichert.

## 9. Über / Kontakt

Die aktuell installierte Version lässt sich jederzeit über den Menüpunkt "Über" einsehen.

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Lizenz: GNU General Public License, Version 3 oder später (GPL-3.0-or-later), mit einer zusätzlichen Namensnennungs-Bedingung; siehe die Dateien [LICENSE](../LICENSE) und [NOTICE](../NOTICE).
