# CCTrayTool – Instrukcja obsługi

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Español](README.es.md) · [Français](README.fr.md) · **Polski** · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool to małe narzędzie dla systemu Windows, które działa jako ikona w zasobniku systemowym (w prawym dolnym rogu, obok zegara). Łączy trzy przydatne funkcje w jednym programie:

1. **KeepAwake** – zapobiega przechodzeniu komputera w tryb oszczędzania energii lub wyłączaniu się ekranu
2. **AlwaysOnTop** – utrzymuje dowolne okno na pierwszym planie za pomocą skrótu klawiszowego
3. **Szybkie uruchamianie narzędzi** – uruchamia często używane programy bezpośrednio z menu zasobnika

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

Opcja menu "Zapisz stan" powoduje, że CCTrayTool zapamiętuje ostatnio wybrane ustawienie KeepAwake i przywraca je automatycznie przy następnym uruchomieniu.

Po zamknięciu CCTrayTool automatycznie przywracane jest normalne zachowanie oszczędzania energii Windows.

## 3. AlwaysOnTop - utrzymywanie okna na pierwszym planie

Skrót klawiszowy SHIFT + ALT + T (domyślny) trwale utrzymuje aktualnie aktywne okno na pierwszym planie - nawet gdy klikane są inne okna. Ponowne naciśnięcie znosi to przypięcie.

Podczas przełączania w pobliżu kursora myszy pojawia się na chwilę mały komunikat potwierdzający, czy okno "pozostaje na pierwszym planie", czy "wróciło do normalnego" stanu. Ten komunikat można włączyć lub wyłączyć za pomocą opcji menu "Pokaż dymek".

W menu "AlwaysOnTop" dostępne są następujące opcje:

- **Skrót aktywny**: Całkowicie włącza lub wyłącza skrót klawiszowy
- **Zmień skrót**: Otwiera okno dialogowe, w którym można ustawić własny skrót klawiszowy (kombinacja Ctrl, Alt, Shift, Win oraz litery, cyfry lub klawisza funkcyjnego F1-F12)
- **Pokaż dymek**: Włącza lub wyłącza krótki komunikat na ekranie podczas przełączania

Uwaga: Samego pulpitu Windows ("Program Manager") nie można ustawić na "zawsze na wierzchu". Nie każda kombinacja klawiszy jest wolna - niektóre są już zajęte przez system lub inne programy. W takim przypadku pojawia się komunikat i należy wybrać inną kombinację.

## 4. Menu szybkiego uruchamiania własnych programów

Nad KeepAwake menu zasobnika pokazuje sekcję "ToolTime": listę programów, które można uruchomić jednym kliknięciem. Pozycje pochodzą z folderu na komputerze (patrz punkt 5): każdy skrót (plik `.lnk`) w tym folderze staje się pozycją menu, a każdy podfolder - podmenu.

Domyślnie skonfigurowano już kilka wbudowanych narzędzi Windows, w tym:

- Kalkulator, Notepad (folder "Office")
- Explorer (bezpośrednio w menu głównym)
- Wiersz poleceń, Edytor rejestru, Ustawienia sieciowe, Panel sterowania, Monitor zasobów, Monitor wydajności, Zarządzaj usługami, Oczyszczanie dysku (folder "System")

Skróty, których program nie zostanie znaleziony na danym komputerze, automatycznie nie pojawiają się w menu - dzięki temu nie występuje komunikat o błędzie, jeśli narzędzia brakuje w systemie.

Niektóre pozycje (np. Wiersz poleceń, Edytor rejestru) są skonfigurowane tak, aby uruchamiały się automatycznie z uprawnieniami administratora (w takim przypadku system Windows prosi o potwierdzenie za pomocą Kontroli konta użytkownika).

## 5. Dodawanie własnych narzędzi i folderów

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

## 6. Dodatkowe ustawienia

W podmenu "Ustawienia" dostępne są dodatkowo:

- **Włącz ToolTime**: Całkowicie włącza lub wyłącza sekcję szybkiego uruchamiania narzędzi (patrz punkt 4). Po wyłączeniu żadna z jej pozycji nie pojawia się w menu zasobnika, niezależnie od zawartości folderu ToolTime.
- **Otwórz folder ToolTime**: Otwiera folder ToolTime w Eksploratorze Windows, aby dodawać, zmieniać nazwy lub usuwać skróty (patrz punkt 5).
- **Wczytaj narzędzia ponownie**: Ponownie odczytuje folder ToolTime i odbudowuje menu. Zwykle nie jest to konieczne, ponieważ zmiany w folderze są wykrywane automatycznie.
- **Włącz KeepAwake**: Całkowicie włącza lub wyłącza sekcję KeepAwake (patrz punkt 2). Po wyłączeniu jej pozycje znikają z menu zasobnika i obowiązuje normalne zachowanie oszczędzania energii Windows.
- **Włącz AlwaysOnTop**: Całkowicie włącza lub wyłącza sekcję AlwaysOnTop (patrz punkt 3). Po wyłączeniu jej pozycje znikają z menu zasobnika, a skrót klawiszowy zostaje dezaktywowany.
- **Uruchamiaj automatycznie**: CCTrayTool będzie odtąd uruchamiał się automatycznie przy logowaniu do Windows.
- **Utwórz plik dziennika**: Zapisuje szczegółowy dziennik wszystkich działań w pliku dziennika. Przydatne przy rozwiązywaniu problemów, niepotrzeb-ne w normalnej pracy. W pliku ustawień jest to wpis "`UseLog`" w sekcji `[Main]`: 1 = włączone; 0, pusty lub brakujący wpis albo dowolna inna wartość = wyłączone.
- **Pokaż plik dziennika**: Otwiera bieżący plik dziennika w Notatniku.
- **Używaj dużych ikon**: Wyświetla ikony w menu zasobnika w większym rozmiarze (32 zamiast 16 pikseli).
- **Edytuj plik ustawień**: Otwiera plik konfiguracyjny bezpośrednio do edycji (patrz punkt 5).

## 7. Lokalizacje przechowywania

CCTrayTool przechowuje swoje pliki w profilu użytkownika:

- **Konfiguracja:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Plik dziennika:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Folder ToolTime:** `%LocalAppData%\CCTrayTool\ToolTime\`

(Ścieżkę można wkleić do paska adresu Eksploratora Windows, aby przejść bezpośrednio do folderu.)

## 8. Zamykanie programu

CCTrayTool zamyka się za pomocą opcji menu "Zakończ". Powoduje to automatyczne przywrócenie normalnego zachowania oszczędzania energii Windows oraz zapisanie bieżącej konfiguracji.

## 9. Informacje / Kontakt

Aktualnie zainstalowaną wersję można w każdej chwili sprawdzić za pomocą opcji menu "Informacje".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licencja: GNU General Public License, wersja 3 lub nowsza (GPL-3.0-or-later), z dodatkowym warunkiem uznania autorstwa; patrz pliki [LICENSE](../LICENSE) i [NOTICE](../NOTICE).
