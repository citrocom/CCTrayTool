# CCTrayTool – Instrukcja obsługi

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Español](README.es.md) · [Français](README.fr.md) · **Polski** · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool to małe narzędzie dla systemu Windows, które działa jako ikona w zasobniku systemowym (w prawym dolnym rogu, obok zegara). Łączy cztery przydatne funkcje w jednym programie:

1. **KeepAwake** – zapobiega przechodzeniu komputera w tryb oszczędzania energii lub wyłączaniu się ekranu
2. **AlwaysOnTop** – utrzymuje dowolne okno na pierwszym planie za pomocą skrótu klawiszowego
3. **Szybkie uruchamianie narzędzi** – uruchamia często używane programy bezpośrednio z menu zasobnika
4. **CloseGuard** – blokuje przycisk zamykania (X) wybranych okien za pomocą skrótu klawiszowego lub reguł

Wszystkie funkcje obsługuje się za pomocą menu wywoływanego kliknięciem prawym przyciskiem myszy na ikonie w zasobniku. Instalacja nie jest wymagana, program można uruchomić bezpośrednio.

CCTrayTool obsługuje języki: angielski, niemiecki, włoski, hiszpański, francuski, polski, węgierski i rosyjski. Język jest ustawiany automatycznie na podstawie języka systemowego komputera.

Wymagania systemowe: wymagany jest 64-bitowy system Windows 10 lub nowszy. Program nie działa w 32-bitowym systemie Windows.

## 1. Uruchomienie i pierwsza ikona

Po uruchomieniu w obszarze zasobnika paska zadań Windows pojawia się ikona. Kolor ikony od razu pokazuje aktualny stan KeepAwake:

- Biały = KeepAwake wyłączone (normalne zachowanie Windows)
- Czerwony = KeepAwake aktywne dla monitorów
- Niebieski = KeepAwake aktywne dla systemu
- Zielony = KeepAwake aktywne dla monitorów i systemu

Kliknięcie prawym przyciskiem myszy na ikonę otwiera menu ze wszystkimi funkcjami. Jeśli ikona nie jest widoczna, warto sprawdzić obszar "ukrytych ikon" (mała strzałka na pasku zadań).

Uwaga: CCTrayTool można uruchomić tylko raz jednocześnie. Ponowne uruchomienie nie ma żadnego efektu, jeśli program już działa.

## 2. KeepAwake - blokowanie oszczędzania energii

W sekcji menu "KeepAwake" można wybrać, czego komputer NIE powinien robić, gdy CCTrayTool jest uruchomiony:

- **Monitory i system**: Ani ekran się nie wyłącza, ani komputer nie przechodzi w tryb wstrzymania/oszczędzania energii. Idealne do prezentacji lub długotrwałych procesów, podczas których ekran musi pozostać widoczny.
- **Monitory**: Wyłącznie ekran pozostaje włączony (brak wyłączania, brak wygaszacza ekranu). Sam komputer może mimo to przejść w tryb wstrzymania po swoim własnym czasie oczekiwania.
- **System**: Komputer nie przechodzi w tryb wstrzymania/oszczędzania energii, ale ekran może się mimo to wyłączyć zgodnie z ustawieniami Windows. Przydatne np. przy długich pobieraniach lub obliczeniach w tle.
- **Wyłączone**: CCTrayTool nie ingeruje; obowiązuje normalne zachowanie oszczędzania energii Windows.

Opcja menu "Zapisz stan" w podmenu "Ustawienia" sekcji KeepAwake powoduje, że CCTrayTool zapamiętuje ostatnio wybrane ustawienie KeepAwake i przywraca je automatycznie przy następnym uruchomieniu.

Po zamknięciu CCTrayTool automatycznie przywracane jest normalne zachowanie oszczędzania energii Windows.

## 3. AlwaysOnTop - utrzymywanie okna na pierwszym planie

Skrót klawiszowy SHIFT + ALT + T (domyślny) trwale utrzymuje aktualnie aktywne okno na pierwszym planie - nawet gdy klikane są inne okna. Ponowne naciśnięcie znosi to przypięcie.

Podczas przełączania w pobliżu kursora myszy pojawia się na chwilę mały komunikat potwierdzający, czy okno "pozostaje na pierwszym planie", czy "wróciło do normalnego" stanu. Ten komunikat można włączyć lub wyłączyć za pomocą opcji menu "Pokaż dymek".

W menu "AlwaysOnTop" dostępne są następujące opcje:

- **Skrót aktywny**: Całkowicie włącza lub wyłącza skrót klawiszowy
- **Ustawienia**: Podmenu (ikona zębatki) z następującymi pozycjami:
  - **Zmień skrót**: Otwiera okno dialogowe, w którym można ustawić własny skrót klawiszowy (kombinacja Ctrl, Alt, Shift, Win oraz litery, cyfry lub klawisza funkcyjnego F1-F12)
  - **Pokaż dymek**: Włącza lub wyłącza krótki komunikat na ekranie podczas przełączania

Uwaga: Samego pulpitu Windows ("Program Manager") nie można ustawić na "zawsze na wierzchu". Nie każda kombinacja klawiszy jest wolna - niektóre są już zajęte przez system lub inne programy. W takim przypadku pojawia się komunikat i należy wybrać inną kombinację.

## 4. CloseGuard - blokowanie przycisku zamykania

CloseGuard chroni okna przed przypadkowym zamknięciem. Dla wybranych okien blokuje przycisk zamykania (znak "X" w prawym górnym rogu okna): przycisk jest wyszarzony, a kliknięcie go nic nie daje. Jest to przydatne w przypadku programów, które muszą stale działać, oraz okien, które wciąż są zamykane przez pomyłkę.

Okno można zablokować na dwa sposoby:

- **Ręcznie, za pomocą skrótu klawiszowego**: Kliknij okno, a następnie naciśnij CTRL + ALT + X (ustawienie domyślne). Przycisk zamykania tego okna zostaje zablokowany. Ponowne naciśnięcie skrótu odblokowuje go. Okno odblokowane w ten sposób pozostaje wolne, nawet jeśli pasuje do reguły, aż do zamknięcia. Krótki komunikat potwierdza każdą zmianę. Blokada trwa do zamknięcia lub odblokowania okna.
- **Automatycznie, za pomocą reguł**: Kliknij okno, a następnie naciśnij CTRL + ALT + SHIFT + X (ustawienie domyślne). CCTrayTool zapisuje w pliku reguł regułę składającą się z tytułu i klasy okna i blokuje okno. Od tej chwili każde okno pasujące do reguły jest blokowane automatycznie, gdy tylko się pojawi - także po ponownym uruchomieniu programu lub CCTrayTool.

W menu zasobnika sekcja "CloseGuard" oferuje następujące pozycje:

- **Zablokuj/odblokuj przycisk zamykania aktywnego okna**: Robi to samo co pierwszy skrót klawiszowy. Dopóki menu zasobnika jest otwarte, to ono ma fokus; dlatego CloseGuard używa okna, które było aktywne tuż przed tym.
- **Utwórz regułę dla aktywnego okna**: Robi to samo co drugi skrót klawiszowy.
- **Pokaż zablokowane okna**: Pokazuje, które okna są obecnie zablokowane (przez regułę lub ręcznie, z klasą okna w nawiasach kwadratowych) oraz ile jest reguł.

Pod nimi znajduje się podmenu "Ustawienia" (ikona zębatki), które zawiera:

- **Automatycznie sprawdzaj nowe okna**: Włączone: CloseGuard stale obserwuje i blokuje każde nowe okno pasujące do reguły. Wyłączone: nowe okna nie są blokowane automatycznie.
- **Sprawdzaj okna otwarte przy uruchomieniu**: Włączone: okna, które są już otwarte w chwili uruchomienia CCTrayTool, są od razu porównywane z regułami. Wyłączone: te okna pozostają nietknięte; sprawdzane są tylko okna otwarte później.
- **Minimalizuj okno po kliknięciu zablokowanego X**: Włączone: kliknięcie wyszarzonego przycisku zamykania minimalizuje okno zamiast nie robić nic. Tak jak przy prawdziwym przycisku, okno jest minimalizowane tylko wtedy, gdy przycisk myszy zostanie zwolniony również nad X; naciśnięcie przycisku i odsunięcie kursora anuluje kliknięcie. Wyłączone (domyślnie): kliknięcie nic nie robi.
- **Zmień skrót: zablokuj/odblokuj** / **Zmień skrót: utwórz regułę**: Otwiera to samo okno dialogowe co w AlwaysOnTop, aby ustawić inny skrót klawiszowy. Kombinacja, której używa już inna funkcja CCTrayTool, zostaje odrzucona.
- **Edytuj reguły...**: Otwiera plik reguł w Notatniku (patrz niżej). Po zapisaniu i zamknięciu Notatnika zmienione reguły są stosowane od razu: okna zablokowane przez regułę, która już nie pasuje, zostają odblokowane, a nowe reguły obowiązują natychmiast dla otwartych okien.

CloseGuard jako całość włącza się i wyłącza pozycją "Włącz CloseGuard" w menu "Ustawienia" sekcji "CCTrayTool" (patrz punkt 7). Po nowej instalacji CloseGuard jest wyłączony. Przy pierwszym włączeniu jednorazowa informacja wyjaśnia, których okien nie da się zablokować.

Reguły (osobny plik `CloseGuardRules.ini`, sekcja `[Rules]`):

Reguły nie są zapisane w pliku ustawień, lecz w osobnym pliku: `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`. Jest on tworzony automatycznie. To plik Unicode, więc działają także tytuły okien ze znakami diakrytycznymi i innymi znakami specjalnymi. Notatnik zachowuje ten format; jeśli plik jest edytowany innym programem, zapisz go również jako Unicode (UTF-16), w przeciwnym razie znaki specjalne mogą zostać utracone. Reguły są wczytywane ponownie po zamknięciu Notatnika otwartego przez "Edytuj reguły..." oraz przy każdym uruchomieniu CCTrayTool.

Każdy wiersz to jedna reguła w postaci `numer=tytuł|klasa`. Tytuł to tekst, który musi występować gdziekolwiek w tytule okna. Klasa to techniczna nazwa typu okna i musi się dokładnie zgadzać. Wielkość liter nie ma znaczenia. Jedna z dwóch części może być pusta (znak "|" musi pozostać); jeśli wypełnione są obie, muszą pasować obie. Przykłady:

- `1=Calculator|`: każde okno z "Calculator" w tytule
- `2=|Notepad`: każde okno klasy "Notepad"
- `3=Untitled|Notepad`: okna klasy "Notepad" z "Untitled" w tytule

Skrót "utwórz regułę" używa pełnego, aktualnego tytułu okna. Jeśli tytuł się zmienia (na przykład o nazwę otwartego dokumentu), skróć go później przez "Edytuj reguły..." do części, która się nie zmienia, albo zostaw tytuł pusty i zachowaj tylko klasę. Klasę zablokowanego okna pokazuje "Pokaż zablokowane okna". Reguła z pustym tytułem i pustą klasą jest ignorowana; używanych jest najwyżej 200 reguł.

Ustawienia w pliku ustawień (sekcja `[CloseGuard]`):

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

- `Enabled`: 1 = CloseGuard włączony, 0 = wyłączony (tak jak pozycja menu "Włącz CloseGuard"). Domyślnie: 0.
- `HotkeyToggle`: Skrót klawiszowy blokowania/odblokowywania. `^` = Ctrl, `!` = Alt, `+` = Shift, `#` = Win, a po nich klawisz. Łatwiej zmienić go pozycją menu "Zmień skrót".
- `HotkeyAddRule`: Skrót klawiszowy dla "utwórz regułę".
- `ApplyOnStartup`: 1 = okna otwarte przy uruchomieniu programu są porównywane z regułami, 0 = pozostają nietknięte.
- `AutoApply`: 1 = nowe okna są sprawdzane automatycznie, 0 = nie.
- `PollInterval`: Jak często okna są sprawdzane, w milisekundach: od 250 do 5000 (domyślnie: 500). Inne wartości są korygowane automatycznie.
- `MinimizeOnClick`: 1 = kliknięcie zablokowanego przycisku zamykania minimalizuje okno, 0 = nic nie robi (domyślnie). Odpowiada opcji menu.
- `ClickPollInterval`: Jak często przycisk myszy jest w tym celu sprawdzany, w milisekundach: od 10 do 100 (domyślnie: 30). Mniejsza wartość pewniej wykrywa bardzo krótkie kliknięcia, większa wymaga mniej czasu obliczeniowego. Inne wartości są korygowane automatycznie. Dla tego ustawienia nie ma opcji menu.
- `ClickGeometryFallback`: 1 = jeśli okno z własnym paskiem tytułu (na przykład Outlook) nie zgłasza systemowi Windows swojego X, X jest rozpoznawany na podstawie położenia (domyślnie). 0 = rozpoznawany jest tylko X, który okno zgłasza samo.
- `ClickGeometryExtendLeft`: Jak daleko w lewo sięga obszar, w którym X jest rozpoznawany na podstawie położenia, w procentach szerokości X: od 0 do 100 (domyślnie: 0). Niektóre programy rysują swój X bardziej na lewo, niż zgłasza Windows. Zbyt duża wartość sięga do sąsiedniego przycisku maksymalizacji.
- `ClickGeometryExtendDown`: Jak daleko w dół sięga ten obszar, w procentach wysokości X: od 0 do 100 (domyślnie: 87). Niektóre programy rysują swój X niżej, niż zgłasza Windows. Ten sam cel i te same granice co `ClickGeometryExtendLeft`.
- `ClickDebugOverlay`: 1 = pokazuje na ekranie, jako kolorowe, przezroczyste prostokąty, obszary używane do rozpoznawania X: czerwony = obszar, w którym kliknięcie liczy się jako kliknięcie X, niebieski = obszar przycisku zamykania zgłaszany przez Windows (lub, jeśli Windows żadnego nie zgłasza, obszar X znaleziony przez zapytanie okna), zielony = tarcza nad X (zob. `ClickShieldClasses`). Tylko do diagnostyki. 0 = wyłączone (domyślnie).
- `ClickShieldClasses`: Klasy okien (rozdzielone przecinkami) programów, które same się zamykają po zwolnieniu przycisku myszy, na przykład Edge i Chrome (`Chrome_WidgetWin_1`) oraz Firefox (`MozillaWindowClass`); domyślnie obie. X takiego okna jest przykryty prawie niewidocznym oknem, które przejmuje kliknięcie, więc okna nie można już zamknąć przyciskiem X. Puste = brak.

Oba skróty CloseGuard i skrót AlwaysOnTop muszą się od siebie różnić. W przeciwnym razie używane są skróty domyślne.

Warto wiedzieć:

- Blokada chroni przed przypadkowym kliknięciem X. W zależności od programu okno nadal można zamknąć w inny sposób: za pomocą ALT + F4, poleceniem "Zamknij okno" na pasku zadań, poleceniem Zakończ w menu samego programu lub w Menedżerze zadań.
- Zablokować można tylko okna ze zwykłym paskiem tytułu i menu systemowym. Programy rysujące własny pasek tytułu (wiele nowoczesnych aplikacji, niektóre przeglądarki, aplikacje ze sklepu Microsoft Store) mogą zachować działający przycisk X, mimo że CloseGuard zgłasza okno jako zablokowane. Jeśli okno w ogóle nie ma menu systemowego, pojawia się komunikat.
- Przy pierwszym włączeniu CloseGuard jednorazowa informacja zwraca na to uwagę. To, że została pokazana, jest zapisane w pliku ustawień ("NoticeShown=1" w sekcji `[CloseGuard]`); po usunięciu wpisu informacja pojawi się ponownie.
- Minimalizowanie kliknięciem: CCTrayTool sprawdza przycisk myszy krótko i regularnie (domyślnie co 30 ms), i tylko wtedy, gdy widoczne jest co najmniej jedno zablokowane okno. Nie używa haka myszy, więc nie może spowolnić myszy ani systemu. W mało prawdopodobnym przypadku, gdy bardzo krótkie kliknięcie przypadnie na moment, w którym CCTrayTool jest zajęty, po prostu nie zostanie zauważone: okno pozostaje bez zmian, a jego X nadal jest zablokowany.
- Minimalizowanie kliknięciem reaguje na główny przycisk myszy (prawy, jeśli w Windows zamieniono przyciski) i tylko na X zablokowanych okien. Dotyk i pióro nie są wykrywane. Jeśli program ignoruje polecenie minimalizacji, CCTrayTool minimalizuje okno bezpośrednio.
- Niektóre programy rysują własny pasek tytułu (na przykład Outlook). Nie informują systemu Windows, gdzie znajduje się ich X, dlatego do wykrywania kliknięcia CCTrayTool oblicza położenie X w prawym górnym rogu okna (klucz INI `ClickGeometryFallback`). W pliku dziennika pojawia się wtedy "recognized by its position".
- Edge, Chrome i inne programy oparte na Chromium oraz Firefox same rysują swój przycisk X i same zamykają okno, gdy przycisk myszy zostanie zwolniony, więc zablokowane menu systemowe ich nie powstrzymuje. Nad X takich okien (klucz INI `ClickShieldClasses`, domyślnie `Chrome_WidgetWin_1,MozillaWindowClass`) CCTrayTool umieszcza prawie niewidoczne okno, czyli tarczę. Kliknięcie trafia w tarczę, a program nigdy go nie widzi: nic się nie dzieje albo okno jest minimalizowane, jeśli minimalizowanie po kliknięciu jest włączone. Tarcza podąża za oknem i znika, dopóki okno jest zminimalizowane, odblokowane, na pełnym ekranie lub przykryte innym oknem w miejscu X. Przy `ClickDebugOverlay=1` jest pokazywana na zielono. Dopóki okno takiej klasy jest widoczne, przycisk myszy jest sprawdzany co 10 ms, nawet gdy minimalizowanie po kliknięciu jest wyłączone. Firefox sam rysuje pasek tytułu i Windows nie zgłasza położenia jego X; CCTrayTool znajduje wtedy X, pytając okno (plik dziennika: "found by asking the window"). Rozpoznawanie zastępcze według położenia (`ClickGeometryFallback`) jest stosowane tylko dla okien, które nie zgłaszają swojego X do Windows, takich jak Outlook i Word; CCTrayTool pyta każde okno jeden raz i zapisuje wynik w pliku dziennika ("probe of the X").
- Okien programów uruchomionych jako administrator nie można blokować, dopóki CCTrayTool sam nie działa jako administrator (reguła bezpieczeństwa systemu Windows). Pojawia się komunikat.
- Pulpit, pasek zadań i okna samego CCTrayTool nigdy nie są blokowane.
- Po odblokowaniu okna jego menu systemowe jest przywracane do standardu Windows. Pozycje, które program sam dodał do tego menu, mogą zniknąć do czasu ponownego uruchomienia programu.
- Blokada trwa tylko wtedy, gdy działa CCTrayTool: po zamknięciu programu lub wyłączeniu CloseGuard wszystkie okna odzyskują przycisk zamykania. Jeśli CCTrayTool zostanie zakończony siłowo (na przykład w Menedżerze zadań), zablokowane okna pozostają zablokowane. Wtedy naciśnij w takim oknie skrót blokowania/odblokowywania (CCTrayTool musi znów działać) albo zamknij okno i otwórz je ponownie.

## 5. Menu szybkiego uruchamiania własnych programów

Nad KeepAwake menu zasobnika pokazuje sekcję "ToolTime": listę programów, które można uruchomić jednym kliknięciem. Pozycje pochodzą z folderu na komputerze (patrz punkt 6): każdy skrót (plik `.lnk`) w tym folderze staje się pozycją menu, a każdy podfolder - podmenu.

Domyślnie skonfigurowano już kilka wbudowanych narzędzi Windows, w tym:

- Kalkulator, Notepad (folder "Office")
- Explorer (bezpośrednio w menu głównym)
- Wiersz poleceń, Edytor rejestru, Ustawienia sieciowe, Panel sterowania, Monitor zasobów, Monitor wydajności, Zarządzaj usługami, Oczyszczanie dysku (folder "System")

Skróty, których program nie zostanie znaleziony na danym komputerze, automatycznie nie pojawiają się w menu - dzięki temu nie występuje komunikat o błędzie, jeśli narzędzia brakuje w systemie.

Niektóre pozycje (np. Wiersz poleceń, Edytor rejestru) są skonfigurowane tak, aby uruchamiały się automatycznie z uprawnieniami administratora (w takim przypadku system Windows prosi o potwierdzenie za pomocą Kontroli konta użytkownika).

## 6. Dodawanie własnych narzędzi i folderów

Narzędzia w menu szybkiego uruchamiania to po prostu skróty w folderze. Aby dodać narzędzie, wybierz w menu "Ustawienia" pozycję "Otwórz folder ToolTime" i umieść skrót (plik `.lnk`) w otwartym folderze. CCTrayTool sam zauważa zmianę i chwilę później aktualizuje menu zasobnika. (Jeśli tak się nie stanie, użyj pozycji "Wczytaj narzędzia ponownie" w menu "Ustawienia".)

Szybki sposób utworzenia skrótu: przeciągnij program do folderu prawym przyciskiem myszy i wybierz "Utwórz skróty tutaj".

Folder domyślny: `%LocalAppData%\CCTrayTool\ToolTime` (Inny folder można ustawić w pliku ustawień, patrz niżej.)

Podczas tworzenia folderu ToolTime CCTrayTool umieszcza w nim także krótki plik informacyjny ("`ToolTime_Info.txt`", w języku systemu). Wyjaśnia on pokrótce limity oraz sposób sortowania pozycji za pomocą liczby na początku nazwy. Menu ignoruje ten plik; można go w każdej chwili usunąć.

Jak folder zamienia się w menu:

- **Skrót (`.lnk`)**: staje się pozycją menu. Nazwą jest nazwa pliku; ikona to ikona skrótu (a jeśli jej brak - ikona programu, na który skrót wskazuje).
- **Podfolder**: staje się podmenu. Jego ikonę można zmienić jak zwykle w Eksploratorze Windows (Właściwości > Dostosowywanie > Zmień ikonę).
- **Kolejność**: Najpierw foldery, potem skróty, każde posortowane alfabetycznie. Aby ustalić własną kolejność, zacznij nazwę od dwóch lub trzech cyfr i podkreślenia, np. "`01_Notepad.lnk`". Liczba służy tylko do sortowania i nie jest wyświetlana.
- **Administrator**: Włącz "Uruchom jako administrator" we właściwościach skrótu (Skrót > Zaawansowane). Przy uruchamianiu pozycji Windows poprosi wtedy o potwierdzenie.
- **Niewyświetlane**: Ukryte pliki, pliki niebędące skrótami, skróty, których program nie istnieje, oraz puste foldery.

Limity - aby menu pozostało użyteczne:

Menu zasobnika nie da się przewijać kółkiem myszy, a jedynie dwoma małymi przyciskami ze strzałkami, a długie menu wypchnęłoby KeepAwake, AlwaysOnTop i ustawienia poza widoczny obszar. Dlatego obowiązuje:

- W jednym menu wyświetlanych jest co najwyżej 15 pozycji (foldery i skróty łącznie). Ten limit można zmienić w pliku ustawień na wartość od 10 do 20 (patrz niżej).
- Co najwyżej 3 poziomy menu: menu ToolTime plus dwa poziomy podmenu. Głębsze foldery są ignorowane.
- Co najwyżej 400 pozycji łącznie.

Wskazówka: wiele narzędzi lepiej pogrupować w podfolderach niż umieszczać na jednej długiej liście.

Jeśli limit zostanie przekroczony, nic nie ginie niezauważone:

- Nadmiarowe pozycje nie są wyświetlane. Zamiast nich menu zawiera wyszarzony wiersz, np. "... 3 kolejnych nie wyświetlono (limit 15)".
- Pojawia się powiadomienie, a sekcja ToolTime pokazuje pozycję "(!) ToolTime: znaleziono problemy - kliknij, aby zobaczyć szczegóły". Kliknięcie jej wyświetla dokładnie, co zostało pominięte i dlaczego. Te same informacje są zapisywane w pliku dziennika (jeśli włączono "Utwórz plik dziennika").
- Zbyt głęboko zagnieżdżone foldery oraz skróty, których nie można odczytać, są zgłaszane w ten sam sposób.

Ustawienia w pliku ustawień (sekcja `[ToolTime]`):

```ini
[ToolTime]
Enabled=1
MaxEntries=15
Folder=
```

- `Enabled`: 1 = pokaż ToolTime, 0 = ukryj (jak pozycja menu "Włącz ToolTime")
- `MaxEntries`: Maksymalna liczba pozycji w jednym menu, od 10 do 20 (domyślnie: 15). Inne wartości są korygowane automatycznie.
- `Folder`: Opcjonalnie: ścieżka innego folderu ToolTime. Dozwolone są zmienne środowiskowe, np. `%USERPROFILE%`. Puste = folder domyślny. Jeśli folder nie istnieje, zostanie utworzony.

Aby edytować plik, wybierz w menu "Ustawienia" pozycję "Edytuj plik ustawień". Po zapisaniu i zamknięciu Notatnika CCTrayTool ponownie wczytuje plik, od razu stosuje wszystkie zmiany (bez ponownego uruchamiania) i odbudowuje menu.

Przywracanie narzędzi domyślnych: zamknij CCTrayTool, usuń folder ToolTime i uruchom program ponownie - narzędzia domyślne i plik informacyjny zostaną utworzone od nowa.

## 7. Dodatkowe ustawienia

W podmenu "Ustawienia" dostępne są dodatkowo:

- **Włącz ToolTime**: Całkowicie włącza lub wyłącza sekcję szybkiego uruchamiania narzędzi (patrz punkt 5). Po wyłączeniu żadna z jej pozycji nie pojawia się w menu zasobnika, niezależnie od zawartości folderu ToolTime.
- **Otwórz folder ToolTime**: Otwiera folder ToolTime w Eksploratorze Windows, aby dodawać, zmieniać nazwy lub usuwać skróty (patrz punkt 6).
- **Wczytaj narzędzia ponownie**: Ponownie odczytuje folder ToolTime i odbudowuje menu. Zwykle nie jest to konieczne, ponieważ zmiany w folderze są wykrywane automatycznie.
- **Włącz KeepAwake**: Całkowicie włącza lub wyłącza sekcję KeepAwake (patrz punkt 2). Po wyłączeniu jej pozycje znikają z menu zasobnika i obowiązuje normalne zachowanie oszczędzania energii Windows.
- **Włącz AlwaysOnTop**: Całkowicie włącza lub wyłącza sekcję AlwaysOnTop (patrz punkt 3). Po wyłączeniu jej pozycje znikają z menu zasobnika, a skrót klawiszowy zostaje dezaktywowany.
- **Włącz CloseGuard**: Całkowicie włącza lub wyłącza sekcję CloseGuard (patrz punkt 4). Po wyłączeniu jej pozycje znikają z menu zasobnika, skróty klawiszowe zostają dezaktywowane, a wszystkie zablokowane okna odzyskują przycisk zamykania.
- **\<Funkcja\> jako podmenu**: Dostępne dla ToolTime, KeepAwake, AlwaysOnTop i CloseGuard, zawsze bezpośrednio pod pozycją, która włącza i wyłącza daną funkcję. Pokazuje sekcję w menu zasobnika jako podmenu z nazwą funkcji zamiast listy pozycji, dzięki czemu menu jest krótsze. Funkcja działa dalej bez zmian. Po przełączeniu menu zasobnika się zamyka; wystarczy otworzyć je ponownie. Dopóki sama funkcja jest wyłączona, pozycja jest wyszarzona. W pliku ustawień jest to wpis "AsSubmenu" w sekcji danej funkcji (`[ToolTime]`, `[KeepAwake]`, `[AlwaysOnTop]`, `[CloseGuard]`): 1 = podmenu, 0 = normalnie (domyślnie).
- **Uruchamiaj automatycznie**: CCTrayTool będzie odtąd uruchamiał się automatycznie przy logowaniu do Windows.
- **Utwórz plik dziennika**: Zapisuje szczegółowy dziennik wszystkich działań w pliku dziennika. Przydatne przy rozwiązywaniu problemów, niepotrzebne w normalnej pracy. W pliku ustawień jest to wpis "`UseLog`" w sekcji `[Main]`: 1 = włączone; 0, pusty lub brakujący wpis albo dowolna inna wartość = wyłączone.
- **Pokaż plik dziennika**: Otwiera bieżący plik dziennika w Notatniku.
- **Używaj dużych ikon**: Wyświetla ikony w menu zasobnika w większym rozmiarze (32 zamiast 16 pikseli).
- **Edytuj plik ustawień**: Otwiera plik konfiguracyjny bezpośrednio do edycji (patrz punkt 6).

## 8. Lokalizacje przechowywania

CCTrayTool przechowuje swoje pliki w profilu użytkownika:

- **Konfiguracja:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Plik dziennika:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Folder ToolTime:** `%LocalAppData%\CCTrayTool\ToolTime\`
- **Reguły CloseGuard:** `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`

(Ścieżkę można wkleić do paska adresu Eksploratora Windows, aby przejść bezpośrednio do folderu.)

## 9. Zamykanie programu

CCTrayTool zamyka się za pomocą opcji menu "Zakończ". Powoduje to automatyczne przywrócenie normalnego zachowania oszczędzania energii Windows oraz zapisanie bieżącej konfiguracji.

Wszystkie okna, których przycisk zamykania jest zablokowany przez CloseGuard, odzyskują przy tym swój przycisk zamykania.

## 10. Informacje / Kontakt

Aktualnie zainstalowaną wersję można w każdej chwili sprawdzić za pomocą opcji menu "Informacje".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licencja: GNU General Public License, wersja 3 lub nowsza (GPL-3.0-or-later), z dodatkowym warunkiem uznania autorstwa; patrz pliki [LICENSE](../LICENSE) i [NOTICE](../NOTICE).
