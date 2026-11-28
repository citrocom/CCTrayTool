# CCTrayTool – Bedienungsanleitung

[English](../README.md) · **Deutsch** · [Italiano](README.it.md) · [Español](README.es.md) · [Français](README.fr.md) · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool ist ein kleines Windows-Tool, das als Symbol im System-Tray (unten rechts neben der Uhr) läuft. Es vereint vier nützliche Funktionen in einem Programm:

1. **KeepAwake** – verhindert, dass der PC in den Energiesparmodus wechselt oder der Bildschirm sich abschaltet
2. **AlwaysOnTop** – hält per Tastenkombination ein beliebiges Fenster im Vordergrund
3. **Tools-Schnellstart** – startet häufig genutzte Programme direkt über das Traymenü
4. **CloseGuard** – sperrt den Schließen-Button (X) ausgewählter Fenster, per Tastenkombination oder über Regeln

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

Über den Menüpunkt "Status speichern" im Untermenü "Einstellungen" des KeepAwake-Bereichs merkt sich CCTrayTool die zuletzt gewählte KeepAwake-Einstellung und stellt sie beim nächsten Start automatisch wieder her.

Beim Beenden von CCTrayTool wird das normale Energiesparverhalten von Windows automatisch wiederhergestellt.

## 3. AlwaysOnTop - Fenster im Vordergrund halten

Mit der Tastenkombination SHIFT + ALT + T (Standardbelegung) wird das aktuell aktive Fenster dauerhaft im Vordergrund gehalten - auch wenn andere Fenster angeklickt werden. Ein erneutes Drücken hebt diese Fixierung wieder auf.

Beim Umschalten erscheint kurz ein kleiner Hinweis in der Nähe des Mauszeigers, der bestätigt, ob das Fenster nun "im Vordergrund bleibt" oder "wieder normal" ist. Dieser Hinweis lässt sich über den Menüpunkt "ToolTip anzeigen" ein- oder ausschalten.

Im Menü "AlwaysOnTop" stehen folgende Optionen zur Verfügung:

- **Hotkey aktiv**: Schaltet die Tastenkombination komplett ein oder aus
- **Einstellungen**: Untermenü (Zahnrad-Symbol) mit folgenden Einträgen:
  - **Hotkey ändern**: Öffnet einen Dialog, in dem eine eigene Tastenkombination festgelegt werden kann (Kombination aus Strg/Ctrl, Alt, Shift, Win + einem Buchstaben, einer Zahl oder einer Funktionstaste F1-F12)
  - **ToolTip anzeigen**: Schaltet den kurzen Bildschirmhinweis beim Umschalten ein oder aus

Hinweis: Der Windows-Desktop selbst ("Program Manager") kann nicht auf "immer im Vordergrund" gesetzt werden. Nicht jede Tastenkombination ist frei - manche sind bereits vom System oder anderen Programmen belegt. In diesem Fall erscheint ein Hinweis, und es muss eine andere Kombination gewählt werden.

## 4. CloseGuard - Schließen-Button sperren

CloseGuard schützt Fenster davor, versehentlich geschlossen zu werden. Bei den Fenstern, die Sie auswählen, sperrt es den Schließen-Button (das "X" oben rechts im Fenster): Der Button wird ausgegraut, und ein Klick darauf bewirkt nichts. Das ist nützlich für Programme, die dauerhaft laufen müssen, oder für Fenster, die immer wieder aus Versehen geschlossen werden.

Ein Fenster lässt sich auf zwei Arten sperren:

- **Von Hand, per Tastenkombination**: Das Fenster anklicken und dann STRG + ALT + X (Standardbelegung) drücken. Der Schließen-Button dieses Fensters ist nun gesperrt. Erneutes Drücken gibt ihn wieder frei. Ein so freigegebenes Fenster bleibt frei, auch wenn eine Regel passt, bis es geschlossen wird. Ein kurzer Hinweis bestätigt jede Änderung. Die Sperre gilt, bis das Fenster geschlossen oder freigegeben wird.
- **Automatisch, über Regeln**: Das Fenster anklicken und dann STRG + ALT + UMSCHALT + X (Standardbelegung) drücken. CCTrayTool speichert eine Regel aus Fenstertitel und Fensterklasse in der Regeldatei und sperrt das Fenster. Ab dann wird jedes Fenster, auf das die Regel passt, automatisch gesperrt, sobald es erscheint - auch nach einem Neustart des Programms oder von CCTrayTool.

Im Traymenü bietet der Bereich "CloseGuard" diese Einträge:

- **Schließen-Button des aktiven Fensters sperren/freigeben**: Macht dasselbe wie die erste Tastenkombination. Solange das Traymenü offen ist, hat es selbst den Fokus; CloseGuard verwendet daher das Fenster, das unmittelbar davor aktiv war.
- **Regel für aktives Fenster anlegen**: Macht dasselbe wie die zweite Tastenkombination.
- **Gesperrte Fenster anzeigen**: Zeigt, welche Fenster gerade gesperrt sind (per Regel oder von Hand, mit der Fensterklasse in eckigen Klammern) und wie viele Regeln es gibt.

Darunter enthält das Untermenü "Einstellungen" (Zahnrad-Symbol):

- **Neue Fenster automatisch prüfen**: Ein: CloseGuard beobachtet dauerhaft und sperrt jedes neue Fenster, auf das eine Regel passt. Aus: Neue Fenster werden nicht automatisch gesperrt.
- **Beim Start offene Fenster prüfen**: Ein: Fenster, die beim Start von CCTrayTool schon offen sind, werden sofort mit den Regeln verglichen. Aus: Diese Fenster bleiben unberührt; nur später geöffnete Fenster werden geprüft.
- **Fenster minimieren bei Klick auf gesperrtes X**: Ein: Ein Klick auf den ausgegrauten Schließen-Button minimiert das Fenster, statt nichts zu bewirken. Wie bei einem echten Button wird das Fenster nur minimiert, wenn die Maustaste ebenfalls auf dem X losgelassen wird; wer die Taste drückt und wegzieht, bricht den Klick ab. Aus (Standard): Ein Klick bewirkt nichts.
- **Hotkey ändern: Sperren/Freigeben** / **Hotkey ändern: Regel anlegen**: Öffnet denselben Dialog wie bei AlwaysOnTop, um eine andere Tastenkombination festzulegen. Eine Kombination, die eine andere Funktion von CCTrayTool bereits verwendet, wird abgelehnt.
- **Regeln bearbeiten...**: Öffnet die Regeldatei in Notepad (siehe unten). Nach dem Speichern und Schließen von Notepad werden die geänderten Regeln sofort angewendet: Fenster, die wegen einer nicht mehr passenden Regel gesperrt waren, werden freigegeben, neue Regeln gelten sofort für die offenen Fenster.

CloseGuard insgesamt lässt sich mit "CloseGuard aktivieren" im Menü "Einstellungen" des Bereichs "CCTrayTool" ein- und ausschalten (siehe Abschnitt 7). Nach einer Neuinstallation ist CloseGuard ausgeschaltet. Beim ersten Einschalten erklärt ein einmaliger Hinweis, welche Fenster sich nicht sperren lassen.

Regeln (eigene Datei `CloseGuardRules.ini`, Abschnitt `[Rules]`):

Die Regeln stehen nicht in der Einstellungsdatei, sondern in einer eigenen Datei: `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`. Sie wird automatisch angelegt. Es ist eine Unicode-Datei, daher funktionieren auch Fenstertitel mit Umlauten oder anderen Sonderzeichen. Notepad behält dieses Format bei; wird die Datei mit einem anderen Programm bearbeitet, bitte ebenfalls als Unicode (UTF-16) speichern, sonst können Sonderzeichen verloren gehen. Die Regeln werden neu eingelesen, wenn Notepad nach "Regeln bearbeiten..." geschlossen wird, und bei jedem Start von CCTrayTool.

Jede Zeile ist eine Regel in der Form `Nummer=Titel|Klasse`. Der Titel ist ein Text, der irgendwo im Fenstertitel vorkommen muss. Die Klasse ist der technische Name des Fenstertyps und muss genau übereinstimmen. Groß- und Kleinschreibung spielen keine Rolle. Einer der beiden Teile darf leer sein (das "|" muss bleiben); sind beide ausgefüllt, müssen beide passen. Beispiele:

- `1=Calculator|`: jedes Fenster mit "Calculator" im Titel
- `2=|Notepad`: jedes Fenster der Klasse "Notepad"
- `3=Untitled|Notepad`: Fenster der Klasse "Notepad" mit "Untitled" im Titel

Die Tastenkombination "Regel anlegen" verwendet den vollständigen aktuellen Titel des Fensters. Ändert sich der Titel (zum Beispiel durch den Namen eines geöffneten Dokuments), über "Regeln bearbeiten..." auf den gleichbleibenden Teil kürzen oder den Titel leer lassen und nur die Klasse behalten. Die Klasse eines gesperrten Fensters zeigt "Gesperrte Fenster anzeigen". Eine Regel mit leerem Titel und leerer Klasse wird ignoriert; höchstens 200 Regeln werden verwendet.

Einstellungen in der Einstellungsdatei (Abschnitt `[CloseGuard]`):

```ini
[CloseGuard]
Enabled=0
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

- `Enabled`: 1 = CloseGuard ein, 0 = aus (wie der Menüpunkt "CloseGuard aktivieren"). Standard: 0.
- `HotkeyToggle`: Tastenkombination für Sperren/Freigeben. `^` = Strg, `!` = Alt, `+` = Umschalt, `#` = Win, danach die Taste. Einfacher geht es mit dem Menüpunkt "Hotkey ändern".
- `HotkeyAddRule`: Tastenkombination für "Regel anlegen".
- `ApplyOnStartup`: 1 = Fenster, die beim Programmstart offen sind, werden mit den Regeln verglichen, 0 = sie bleiben unberührt.
- `AutoApply`: 1 = neue Fenster werden automatisch geprüft, 0 = nicht.
- `PollInterval`: Wie oft die Fenster geprüft werden, in Millisekunden: 250 bis 5000 (Standard: 500). Andere Werte werden automatisch korrigiert.
- `MinimizeOnClick`: 1 = Ein Klick auf den gesperrten Schließen-Button minimiert das Fenster, 0 = er bewirkt nichts (Standard). Entspricht dem Menüpunkt.
- `ClickPollInterval`: Wie oft die Maustaste dafür geprüft wird, in Millisekunden: 10 bis 100 (Standard: 30). Ein kleinerer Wert erkennt auch sehr kurze Klicks sicherer, ein größerer braucht weniger Rechenzeit. Andere Werte werden automatisch korrigiert. Für diese Einstellung gibt es keinen Menüpunkt.
- `ClickGeometryFallback`: 1 = Meldet ein Fenster mit eigener Titelleiste (zum Beispiel Outlook) sein X nicht an Windows, wird das X an seiner Position erkannt (Standard). 0 = Es wird nur ein X erkannt, das das Fenster selbst meldet.
- `ClickGeometryExtendLeft`: Wie weit der Bereich, in dem das X an seiner Position erkannt wird, nach links reicht, in Prozent der Breite des X: 0 bis 100 (Standard: 0). Manche Programme zeichnen ihr X weiter links, als Windows meldet. Ein zu großer Wert reicht in den benachbarten Maximieren-Button hinein.
- `ClickGeometryExtendDown`: Wie weit dieser Bereich nach unten reicht, in Prozent der Höhe des X: 0 bis 100 (Standard: 87). Manche Programme zeichnen ihr X tiefer, als Windows meldet. Gleicher Zweck und gleiche Grenzen wie `ClickGeometryExtendLeft`.
- `ClickDebugOverlay`: 1 = zeigt die Bereiche, in denen das X erkannt wird, als farbige, durchsichtige Rechtecke auf dem Bildschirm: rot = der Bereich, in dem ein Klick als Klick auf das X zählt, blau = der Button-Bereich, den Windows meldet (oder, wenn Windows keinen meldet, der beim Fragen des Fensters gefundene Bereich des X), grün = das Schutzfenster über dem X (siehe `ClickShieldClasses`). Nur zur Fehlersuche. 0 = aus (Standard).
- `ClickShieldClasses`: Fensterklassen (durch Komma getrennt) von Programmen, die sich selbst schließen, sobald die Maustaste losgelassen wird, zum Beispiel Edge und Chrome (`Chrome_WidgetWin_1`) und Firefox (`MozillaWindowClass`); Standard sind beide. Das X eines solchen Fensters wird von einem fast unsichtbaren Fenster abgedeckt, das den Klick abfängt; das Fenster lässt sich dann nicht mehr mit dem X schließen. Leer = keine.

Die beiden CloseGuard-Tastenkombinationen und die AlwaysOnTop-Tastenkombination müssen sich voneinander unterscheiden. Andernfalls werden stattdessen die Standardkombinationen verwendet.

Wissenswertes:

- Die Sperre schützt vor einem versehentlichen Klick auf das X. Je nach Programm lässt sich ein Fenster weiterhin auf anderen Wegen schließen: mit ALT + F4, mit "Fenster schließen" in der Taskleiste, mit einem Beenden-Befehl im Menü des Programms oder über den Task-Manager.
- Gesperrt werden können nur Fenster mit normaler Titelleiste und Systemmenü. Programme, die ihre Titelleiste selbst zeichnen (viele moderne Apps, einige Browser, Apps aus dem Microsoft Store), behalten unter Umständen ein funktionierendes X, obwohl CloseGuard das Fenster als gesperrt meldet. Hat ein Fenster gar kein Systemmenü, erscheint ein Hinweis.
- Beim ersten Einschalten von CloseGuard weist ein einmaliger Hinweis darauf hin. Dass er gezeigt wurde, steht in der Einstellungsdatei ("NoticeShown=1" im Abschnitt `[CloseGuard]`); wird der Eintrag gelöscht, erscheint der Hinweis erneut.
- Minimieren per Klick: CCTrayTool prüft die Maustaste kurz und regelmäßig (Standard: alle 30 ms), und nur, solange mindestens ein gesperrtes Fenster sichtbar ist. Es wird kein Maus-Hook verwendet, die Maus und das System können dadurch nicht ausgebremst werden. Fällt ein sehr kurzer Klick ausnahmsweise in einen Moment, in dem CCTrayTool beschäftigt ist, wird er einfach nicht bemerkt: Das Fenster bleibt unverändert und sein X gesperrt.
- Minimieren per Klick reagiert auf die primäre Maustaste (die rechte, wenn die Tasten in Windows vertauscht sind) und nur auf das X gesperrter Fenster. Eingaben per Touch und Stift werden nicht erkannt. Ignoriert ein Programm den Minimieren-Befehl, minimiert CCTrayTool das Fenster direkt.
- Manche Programme zeichnen ihre Titelleiste selbst (zum Beispiel Outlook). Sie sagen Windows nicht, wo ihr X liegt; deshalb berechnet CCTrayTool für die Klick-Erkennung die Position des X in der oberen rechten Ecke des Fensters (INI-Schlüssel `ClickGeometryFallback`). In der Log-Datei steht dann "recognized by its position".
- Edge, Chrome und andere Chromium-Programme sowie Firefox zeichnen ihr X selbst und schließen das Fenster von sich aus, sobald die Maustaste losgelassen wird. Das gesperrte Systemmenü hält sie deshalb nicht auf. Über dem X solcher Fenster (INI-Schlüssel `ClickShieldClasses`, Standard `Chrome_WidgetWin_1,MozillaWindowClass`) legt CCTrayTool darum ein fast unsichtbares Schutzfenster. Der Klick landet auf dem Schutzfenster, das Programm bekommt ihn nie zu sehen: Es passiert nichts, oder das Fenster wird minimiert, wenn das Minimieren beim Klick eingeschaltet ist. Das Schutzfenster folgt dem Fenster und ist weg, solange das Fenster minimiert, entsperrt, im Vollbild oder an seinem X von einem anderen Fenster überdeckt ist. Mit `ClickDebugOverlay=1` wird es grün angezeigt. Solange ein Fenster einer solchen Klasse sichtbar ist, wird die Maustaste alle 10 ms geprüft, auch wenn das Minimieren beim Klick ausgeschaltet ist. Firefox zeichnet seine Titelleiste selbst, Windows meldet keine Position für sein X; CCTrayTool findet das X dann, indem es das Fenster fragt (Logdatei: "found by asking the window"). Der Positions-Ersatz (`ClickGeometryFallback`) wird nur für Fenster verwendet, die ihr X nicht an Windows melden, etwa Outlook und Word; CCTrayTool fragt dazu jedes Fenster einmal und schreibt das Ergebnis in die Logdatei ("probe of the X").
- Fenster von Programmen, die als Administrator laufen, lassen sich nicht sperren, solange CCTrayTool nicht selbst als Administrator läuft (eine Sicherheitsregel von Windows). Es erscheint ein Hinweis.
- Der Desktop, die Taskleiste und die Fenster von CCTrayTool selbst werden nie gesperrt.
- Beim Freigeben wird das Systemmenü des Fensters auf den Windows-Standard zurückgesetzt. Einträge, die das Programm selbst zu diesem Menü hinzugefügt hat, fehlen unter Umständen, bis das Programm neu gestartet wird.
- Eine Sperre gilt nur, solange CCTrayTool läuft: Beim Beenden des Programms oder beim Ausschalten von CloseGuard erhalten alle Fenster ihren Schließen-Button zurück. Wird CCTrayTool zwangsweise beendet (zum Beispiel über den Task-Manager), bleiben gesperrte Fenster gesperrt. Dann in einem solchen Fenster die Tastenkombination zum Sperren/Freigeben drücken (CCTrayTool muss wieder laufen) oder das Fenster schließen und neu öffnen.

## 5. Schnellstart-Menü für eigene Programme

Oberhalb von KeepAwake zeigt das Traymenü den Bereich "ToolTime": eine Liste von Programmen, die sich mit einem Klick starten lassen. Die Einträge stammen aus einem Ordner auf Ihrem PC (siehe Abschnitt 6): Jede Verknüpfung (`.lnk`-Datei) in diesem Ordner wird zu einem Menüeintrag, jeder Unterordner zu einem Untermenü.

Im Auslieferungszustand sind bereits einige Windows-Bordmittel eingerichtet, u. a.:

- Rechner, Notepad (Ordner "Office")
- Explorer (direkt im Hauptmenü)
- Eingabeaufforderung, Registrierungs-Editor, Netzwerkeinstellungen, Systemsteuerung, Ressourcenmonitor, Leistungsüberwachung, Dienste verwalten, Datenträgerbereinigung (Ordner "System")

Verknüpfungen, deren Programm auf dem jeweiligen PC nicht gefunden wird, erscheinen automatisch nicht im Menü - es kommt also zu keiner Fehlermeldung, wenn ein Tool auf einem System fehlt.

Einige Einträge (z. B. Eingabeaufforderung, Regedit) sind so eingerichtet, dass sie automatisch mit Administratorrechten gestartet werden (Windows fragt in diesem Fall über die Benutzerkontensteuerung nach Bestätigung).

## 6. Eigene Tools und Ordner hinzufügen

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

## 7. Weitere Einstellungen

Im Untermenü "Einstellungen" stehen zusätzlich zur Verfügung:

- **ToolTime aktivieren**: Schaltet den gesamten Tools-Schnellstart-Bereich (siehe Abschnitt 5) komplett ein oder aus. Bei Deaktivierung erscheinen keine seiner Einträge im Traymenü, unabhängig davon, was sich im ToolTime-Ordner befindet.
- **ToolTime-Ordner öffnen**: Öffnet den ToolTime-Ordner im Windows-Explorer, damit Verknüpfungen hinzugefügt, umbenannt oder entfernt werden können (siehe Abschnitt 6).
- **Tools neu laden**: Liest den ToolTime-Ordner erneut ein und baut das Menü neu auf. Normalerweise nicht nötig, da Änderungen im Ordner automatisch erkannt werden.
- **KeepAwake aktivieren**: Schaltet den gesamten KeepAwake-Bereich (siehe Abschnitt 2) komplett ein oder aus. Bei Deaktivierung verschwinden seine Einträge aus dem Traymenü, und es gilt das normale Energiesparverhalten von Windows.
- **AlwaysOnTop aktivieren**: Schaltet den gesamten AlwaysOnTop-Bereich (siehe Abschnitt 3) komplett ein oder aus. Bei Deaktivierung verschwinden seine Einträge aus dem Traymenü, und die Tastenkombination wird deaktiviert.
- **CloseGuard aktivieren**: Schaltet den gesamten CloseGuard-Bereich (siehe Abschnitt 4) komplett ein oder aus. Bei Deaktivierung verschwinden seine Einträge aus dem Traymenü, die Tastenkombinationen werden deaktiviert, und alle gesperrten Fenster erhalten ihren Schließen-Button zurück.
- **\<Funktion\> als Untermenü**: Gibt es für ToolTime, KeepAwake, AlwaysOnTop und CloseGuard, jeweils direkt unter dem Eintrag, der die Funktion ein- und ausschaltet. Zeigt den Bereich im Traymenü als Untermenü mit dem Namen der Funktion statt als Liste von Einträgen; das Menü wird dadurch kürzer. Die Funktion arbeitet unverändert weiter. Beim Umschalten schließt sich das Traymenü; danach einfach neu öffnen. Solange die Funktion selbst ausgeschaltet ist, ist der Eintrag ausgegraut. In der Einstellungsdatei ist das der Eintrag "AsSubmenu" im Abschnitt der Funktion (`[ToolTime]`, `[KeepAwake]`, `[AlwaysOnTop]`, `[CloseGuard]`): 1 = Untermenü, 0 = normal (Standard).
- **Automatisch starten**: CCTrayTool startet künftig automatisch bei der Windows-Anmeldung.
- **Logfile erstellen**: Schreibt ein detailliertes Protokoll aller Aktionen in eine Log-Datei. Hilfreich zur Fehlersuche, im Normalbetrieb nicht erforderlich. In der Einstellungsdatei ist das der Eintrag "`UseLog`" im Abschnitt `[Main]`: 1 = ein; 0, ein leerer oder fehlender Eintrag oder jeder andere Wert = aus.
- **Logfile ansehen**: Öffnet die aktuelle Log-Datei in Notepad.
- **Große Icons verwenden**: Zeigt die Symbole im Traymenü größer an (32 statt 16 Pixel).
- **Einstellungsdatei bearbeiten**: Öffnet die Konfigurationsdatei direkt zur Bearbeitung (siehe Abschnitt 6).

## 8. Speicherorte

CCTrayTool legt seine Dateien im Benutzerprofil ab:

- **Konfiguration:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Logfile:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **ToolTime-Ordner:** `%LocalAppData%\CCTrayTool\ToolTime\`
- **CloseGuard-Regeln:** `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`

(Der Pfad lässt sich in die Windows-Adressleiste des Explorers einfügen, um direkt zum Ordner zu gelangen.)

## 9. Programm beenden

Über den Menüpunkt "Beenden" wird CCTrayTool geschlossen. Dabei wird automatisch das normale Energiesparverhalten von Windows wiederhergestellt und die aktuelle Konfiguration gespeichert.

Alle Fenster, deren Schließen-Button von CloseGuard gesperrt ist, erhalten dabei ihren Schließen-Button zurück.

## 10. Über / Kontakt

Die aktuell installierte Version lässt sich jederzeit über den Menüpunkt "Über" einsehen.

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Lizenz: GNU General Public License, Version 3 oder später (GPL-3.0-or-later), mit einer zusätzlichen Namensnennungs-Bedingung; siehe die Dateien [LICENSE](../LICENSE) und [NOTICE](../NOTICE).
