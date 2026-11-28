# CCTrayTool – Felhasználói kézikönyv

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Español](README.es.md) · [Français](README.fr.md) · [Polski](README.pl.md) · **Magyar** · [Русский](README.ru.md)

A CCTrayTool egy kis Windows-eszköz, amely ikonként fut a tálcán (jobbra lent, az óra mellett). Négy hasznos funkciót egyesít egyetlen programban:

1. **KeepAwake** – megakadályozza, hogy a számítógép energiatakarékos módba váltson, vagy hogy a képernyő kikapcsoljon
2. **AlwaysOnTop** – billentyűkombinációval bármely ablakot az előtérben tart
3. **Eszközök gyorsindítása** – egy kattintással indítja a gyakran használt programokat közvetlenül a tálcamenüből
4. **CloseGuard** – zárolja a kiválasztott ablakok bezárás gombját (X) billentyűkombinációval vagy szabályokkal

Minden funkció a tálcaikonra kattintva, jobb egérgombbal elérhető menün keresztül működtethető. Telepítés nem szükséges, a program közvetlenül indítható.

A CCTrayTool a következő nyelveket támogatja: angol, német, olasz, spanyol, francia, lengyel, magyar és orosz. A nyelv a számítógép rendszernyelve alapján automatikusan beáll.

Rendszerkövetelmény: 64 bites Windows 10 vagy újabb szükséges. A program 32 bites Windows rendszeren nem fut.

## 1. Indítás és az első ikon

Indítás után egy ikon jelenik meg a Windows tálca értesítési területén. Az ikon színe azonnal mutatja a KeepAwake aktuális állapotát:

- Fehér = KeepAwake letiltva (normál Windows-viselkedés)
- Piros = KeepAwake aktív a monitorokhoz
- Kék = KeepAwake aktív a rendszerhez
- Zöld = KeepAwake aktív a monitorokhoz és a rendszerhez

Az ikonra jobb gombbal kattintva megnyílik a menü az összes funkcióval. Ha az ikon nem látható, érdemes megnézni a "rejtett ikonok" területét (kis nyíl a tálcán).

Megjegyzés: A CCTrayTool egyszerre csak egyszer indítható. Egy második indításnak nincs hatása, ha a program már fut.

## 2. KeepAwake - az energiatakarékosság megakadályozása

A "KeepAwake" menüpontban kiválasztható, hogy a számítógép mit NE tegyen, amíg a CCTrayTool fut:

- **Monitorok és rendszer**: Sem a képernyő nem kapcsol ki, sem a számítógép nem vált készenléti/energiatakarékos módba. Ideális előadásokhoz vagy hosszan futó folyamatokhoz, amelyeknél a képernyőnek láthatónak kell maradnia.
- **Monitorok**: Csak a képernyő marad bekapcsolva (nincs kikapcsolás, nincs képernyővédő). Maga a számítógép a saját időkorlátja után ettől függetlenül készenléti módba válthat.
- **Rendszer**: A számítógép nem vált készenléti/energiatakarékos módba, de a képernyő a Windows beállításának megfelelően továbbra is kikapcsolhat. Hasznos például hosszú letöltésekhez vagy háttérben futó számításokhoz.
- **Letiltva**: A CCTrayTool nem avatkozik be; a Windows normál energiatakarékossági viselkedése érvényes.

A KeepAwake szakasz "Beállítások" almenüjének "Állapot mentése" menüpontja hatására a CCTrayTool megjegyzi az utoljára kiválasztott KeepAwake-beállítást, és a következő induláskor automatikusan visszaállítja.

A CCTrayTool bezárásakor a Windows normál energiatakarékossági viselkedése automatikusan visszaáll.

## 3. AlwaysOnTop - ablak az előtérben tartása

A SHIFT + ALT + T (alapértelmezett) billentyűkombináció tartósan az előtérben tartja az éppen aktív ablakot - még akkor is, ha más ablakokra kattintanak. Ismételt megnyomásra ez a rögzítés megszűnik.

Váltáskor egy kis értesítés jelenik meg röviden az egérmutató közelében, amely megerősíti, hogy az ablak most "az előtérben marad"-e, vagy "visszaállt normálra". Ez az értesítés a "ToolTip megjelenítése" menüponttal ki- és bekapcsolható.

Az "AlwaysOnTop" menüben a következő beállítások érhetők el:

- **Gyorsbillentyű aktív**: Teljesen be- vagy kikapcsolja a billentyűkombinációt
- **Beállítások**: Almenü (fogaskerék ikon) a következő bejegyzésekkel:
  - **Gyorsbillentyű módosítása**: Megnyit egy párbeszédablakot, ahol saját billentyűkombináció adható meg (Ctrl, Alt, Shift, Win kombinációja egy betűvel, számmal vagy F1-F12 funkcióbillentyűvel)
  - **ToolTip megjelenítése**: Be- vagy kikapcsolja a rövid képernyőn megjelenő értesítést váltáskor

Megjegyzés: Maga a Windows asztal ("Program Manager") nem állítható be "mindig az előtérben" módra. Nem minden billentyűkombináció szabad - néhányat már a rendszer vagy más programok lefoglaltak. Ilyenkor egy értesítés jelenik meg, és más kombinációt kell választani.

## 4. CloseGuard - a bezárás gomb zárolása

A CloseGuard megvédi az ablakokat a véletlen bezárástól. A kiválasztott ablakoknál zárolja a bezárás gombot (az ablak jobb felső sarkában lévő "X"-et): a gomb szürkén jelenik meg, és a rákattintás nem csinál semmit. Ez hasznos azoknál a programoknál, amelyeknek folyamatosan futniuk kell, vagy azoknál az ablakoknál, amelyeket újra és újra véletlenül bezárnak.

Egy ablakot kétféleképpen lehet zárolni:

- **Kézzel, billentyűkombinációval**: Kattintson az ablakra, majd nyomja meg a CTRL + ALT + X kombinációt (alapértelmezett). Az ablak bezárás gombja ezzel zárolva lesz. A kombináció ismételt megnyomása feloldja. Az így feloldott ablak akkor is feloldva marad, ha illik rá egy szabály, amíg be nem zárják. Egy rövid értesítés megerősít minden változást. A zárolás addig tart, amíg az ablakot be nem zárják vagy fel nem oldják.
- **Automatikusan, szabályokkal**: Kattintson az ablakra, majd nyomja meg a CTRL + ALT + SHIFT + X kombinációt (alapértelmezett). A CCTrayTool a szabályfájlba menti az ablak címéből és osztályából álló szabályt, és zárolja az ablakot. Ettől kezdve minden olyan ablak, amelyre a szabály illik, automatikusan zárolva lesz, amint megjelenik - a program vagy a CCTrayTool újraindítása után is.

A tálcamenüben a "CloseGuard" szakasz a következő bejegyzéseket kínálja:

- **Az aktív ablak bezárás gombjának zárolása/feloldása**: Ugyanazt teszi, mint az első billentyűkombináció. Amíg a tálcamenü nyitva van, az kapja a fókuszt; ezért a CloseGuard azt az ablakot használja, amely közvetlenül előtte aktív volt.
- **Szabály létrehozása az aktív ablakhoz**: Ugyanazt teszi, mint a második billentyűkombináció.
- **Zárolt ablakok megjelenítése**: Megmutatja, mely ablakok vannak éppen zárolva (szabály alapján vagy kézzel, az ablak osztályával szögletes zárójelben), és hány szabály létezik.

Alattuk a "Beállítások" almenü (fogaskerék ikon) található, amely a következőket tartalmazza:

- **Új ablakok automatikus ellenőrzése**: Bekapcsolva: a CloseGuard folyamatosan figyel, és zárol minden új ablakot, amelyre illik valamelyik szabály. Kikapcsolva: az új ablakok nem lesznek automatikusan zárolva.
- **Induláskor nyitott ablakok ellenőrzése**: Bekapcsolva: a CCTrayTool indulásakor már nyitott ablakokat azonnal összeveti a szabályokkal. Kikapcsolva: ezeket az ablakokat békén hagyja; csak a később megnyitottakat ellenőrzi.
- **Ablak minimalizálása a zárolt X-re kattintáskor**: Bekapcsolva: a szürkített bezárás gombra kattintva az ablak minimalizálódik ahelyett, hogy semmi sem történne. Mint egy valódi gombnál, az ablak csak akkor minimalizálódik, ha az egérgombot is az X-en engedik fel; ha lenyomják a gombot, majd elhúzzák az egeret, a kattintás megszakad. Kikapcsolva (alapértelmezés): a kattintás semmit sem tesz.
- **Gyorsbillentyű módosítása: zárolás/feloldás** / **Gyorsbillentyű módosítása: szabály létrehozása**: Ugyanazt a párbeszédablakot nyitja meg, mint az AlwaysOnTop, egy másik billentyűkombináció megadásához. Az olyan kombinációt, amelyet a CCTrayTool egy másik funkciója már használ, elutasítja.
- **Szabályok szerkesztése...**: Megnyitja a szabályfájlt a Jegyzettömbben (lásd alább). A Jegyzettömb mentése és bezárása után a módosított szabályok azonnal érvénybe lépnek: azok az ablakok, amelyeket egy már nem illő szabály zárolt, feloldódnak, az új szabályok pedig azonnal vonatkoznak a megnyitott ablakokra.

A CloseGuard egésze a "CCTrayTool" szakasz "Beállítások" menüjének "CloseGuard bekapcsolása" pontjával ki- és bekapcsolható (lásd a 7. pontot). Új telepítés után a CloseGuard ki van kapcsolva. Az első bekapcsoláskor egy egyszeri figyelmeztetés elmagyarázza, mely ablakok nem zárolhatók.

Szabályok (külön fájl: `CloseGuardRules.ini`, `[Rules]` szakasz):

A szabályok nem a beállításfájlban vannak, hanem egy külön fájlban: `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`. A program automatikusan létrehozza. Unicode fájl, ezért az ékezetes vagy más különleges karaktereket tartalmazó ablakcímek is működnek. A Jegyzettömb megtartja ezt a formátumot; ha a fájlt más programmal szerkeszti, azt is Unicode (UTF-16) formátumban mentse, különben a különleges karakterek elveszhetnek. A szabályokat a program újra beolvassa, amikor a "Szabályok szerkesztése..." paranccsal megnyitott Jegyzettömböt bezárja, valamint a CCTrayTool minden indításakor.

Minden sor egy szabály `szám=cím|osztály` alakban. A cím olyan szöveg, amelynek szerepelnie kell valahol az ablak címében. Az osztály az ablaktípus technikai neve, és pontosan egyeznie kell. A kis- és nagybetűk nem számítanak. A két rész egyike üres lehet (a "|" jelnek maradnia kell); ha mindkettő ki van töltve, mindkettőnek illeszkednie kell. Példák:

- `1=Calculator|`: minden ablak, amelynek címében szerepel a "Calculator"
- `2=|Notepad`: minden "Notepad" osztályú ablak
- `3=Untitled|Notepad`: a "Notepad" osztályú ablakok, amelyek címében szerepel az "Untitled"

A "szabály létrehozása" billentyűkombináció az ablak teljes, aktuális címét használja. Ha a cím változik (például egy megnyitott dokumentum nevével), utólag rövidítse le a "Szabályok szerkesztése..." paranccsal az állandó részre, vagy hagyja üresen a címet, és csak az osztályt tartsa meg. A zárolt ablak osztályát a "Zárolt ablakok megjelenítése" mutatja. Az üres című és üres osztályú szabályt figyelmen kívül hagyja; legfeljebb 200 szabályt használ.

Beállítások a beállításfájlban (`[CloseGuard]` szakasz):

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

- `Enabled`: 1 = a CloseGuard be van kapcsolva, 0 = ki van kapcsolva (megegyezik a "CloseGuard bekapcsolása" menüponttal). Alapértelmezés: 0.
- `HotkeyToggle`: A zárolás/feloldás billentyűkombinációja. `^` = Ctrl, `!` = Alt, `+` = Shift, `#` = Win, utána a billentyű. Egyszerűbb a "Gyorsbillentyű módosítása" menüponttal megváltoztatni.
- `HotkeyAddRule`: A "szabály létrehozása" billentyűkombinációja.
- `ApplyOnStartup`: 1 = a program indulásakor nyitott ablakokat összeveti a szabályokkal, 0 = békén hagyja őket.
- `AutoApply`: 1 = az új ablakokat automatikusan ellenőrzi, 0 = nem.
- `PollInterval`: Milyen gyakran ellenőrzi az ablakokat, ezredmásodpercben: 250 és 5000 között (alapértelmezés: 500). A többi értéket automatikusan kijavítja.
- `MinimizeOnClick`: 1 = a zárolt bezárás gombra kattintva az ablak minimalizálódik, 0 = a kattintás semmit sem tesz (alapértelmezés). Megfelel a menüpontnak.
- `ClickPollInterval`: Milyen gyakran ellenőrzi ehhez az egérgombot, ezredmásodpercben: 10 és 100 között (alapértelmezés: 30). A kisebb érték a nagyon rövid kattintásokat is megbízhatóbban észleli, a nagyobb kevesebb számítási időt igényel. A többi értéket automatikusan kijavítja. Ehhez a beállításhoz nincs menüpont.
- `ClickGeometryFallback`: 1 = ha egy saját címsorral rendelkező ablak (például az Outlook) nem jelzi a Windowsnak az X-ét, az X-et a pozíciója alapján ismeri fel (alapértelmezés). 0 = csak olyan X-et ismer fel, amelyet az ablak maga jelez.
- `ClickGeometryExtendLeft`: Milyen messzire nyúlik balra az a terület, amelyben az X-et a pozíciója alapján ismeri fel, az X szélességének százalékában: 0 és 100 között (alapértelmezés: 0). Néhány program az X-ét távolabb balra rajzolja, mint amit a Windows jelez. Túl nagy érték belelóg a szomszédos maximalizálás gombba.
- `ClickGeometryExtendDown`: Milyen messzire nyúlik lefelé ez a terület, az X magasságának százalékában: 0 és 100 között (alapértelmezés: 87). Néhány program az X-ét lejjebb rajzolja, mint amit a Windows jelez. Ugyanaz a cél és ugyanazok a határok, mint a `ClickGeometryExtendLeft` esetében.
- `ClickDebugOverlay`: 1 = színes, átlátszó téglalapokként megjeleníti a képernyőn az X felismeréséhez használt területeket: piros = az a terület, ahol a kattintás X-re kattintásnak számít, kék = a bezárás gomb Windows által jelzett területe (vagy, ha a Windows nem jelez ilyet, az ablak megkérdezésével megtalált X-terület), zöld = az X fölötti pajzs (lásd: `ClickShieldClasses`). Csak hibakereséshez. 0 = kikapcsolva (alapértelmezés).
- `ClickShieldClasses`: Olyan programok ablakosztályai (vesszővel elválasztva), amelyek az egérgomb felengedésekor maguktól bezáródnak, például az Edge és a Chrome (`Chrome_WidgetWin_1`), valamint a Firefox (`MozillaWindowClass`); alapértelmezés: mindkettő. Az ilyen ablak X gombját egy szinte láthatatlan ablak takarja, amely felfogja a kattintást, így az ablak az X-szel már nem zárható be. Üres = nincs.

A két CloseGuard-billentyűkombinációnak és az AlwaysOnTop kombinációnak különbözniük kell egymástól. Ha nem így van, helyettük az alapértelmezett kombinációk lesznek használatban.

Tudnivalók:

- A zárolás a véletlen X-kattintástól véd. A programtól függően az ablak más módon továbbra is bezárható: az ALT + F4 kombinációval, a tálca "Ablak bezárása" parancsával, a program saját menüjének Kilépés parancsával vagy a Feladatkezelővel.
- Csak a hagyományos címsorú és rendszermenüs ablakok zárolhatók. Azok a programok, amelyek saját címsort rajzolnak (sok modern alkalmazás, egyes böngészők, a Microsoft Store alkalmazásai), működő X-et tarthatnak meg akkor is, ha a CloseGuard zároltnak jelzi az ablakot. Ha egy ablaknak egyáltalán nincs rendszermenüje, értesítés jelenik meg.
- A CloseGuard első bekapcsolásakor egy egyszeri figyelmeztetés hívja fel erre a figyelmet. Azt, hogy megjelent, a beállítási fájl rögzíti ("NoticeShown=1" a `[CloseGuard]` szakaszban); a bejegyzés törlése után a figyelmeztetés újra megjelenik.
- Minimalizálás kattintásra: a CCTrayTool röviden és rendszeresen ellenőrzi az egérgombot (alapértelmezés: 30 ms-onként), és csak akkor, amíg legalább egy zárolt ablak látható. Nem használ egérhookot, ezért nem lassíthatja le az egeret vagy a rendszert. Abban a valószínűtlen esetben, ha egy nagyon rövid kattintás éppen akkor történik, amikor a CCTrayTool elfoglalt, a program egyszerűen nem veszi észre: az ablak változatlan marad, az X-e pedig zárolt.
- A kattintásra történő minimalizálás az elsődleges egérgombra reagál (a jobbra, ha a Windowsban felcserélték a gombokat), és csak a zárolt ablakok X-ére. Az érintéses és tollas bevitelt nem érzékeli. Ha egy program figyelmen kívül hagyja a minimalizálási parancsot, a CCTrayTool közvetlenül minimalizálja az ablakot.
- Néhány program saját maga rajzolja a címsorát (például az Outlook). Ezek nem mondják meg a Windowsnak, hol van az X-ük, ezért a kattintás felismeréséhez a CCTrayTool kiszámítja az X helyét az ablak jobb felső sarkában (`ClickGeometryFallback` INI-kulcs). A naplófájlban ilyenkor a "recognized by its position" szöveg jelenik meg.
- Az Edge, a Chrome és más Chromium-alapú programok, valamint a Firefox maguk rajzolják az X gombot, és az egérgomb felengedésekor maguk zárják be az ablakot, ezért a zárolt rendszermenü nem állítja meg őket. Az ilyen ablakok X gombja fölé (`ClickShieldClasses` INI-kulcs, alapértelmezés: `Chrome_WidgetWin_1,MozillaWindowClass`) a CCTrayTool egy szinte láthatatlan ablakot, egy pajzsot helyez. A kattintás a pajzsra érkezik, a program sosem látja: nem történik semmi, vagy az ablak minimalizálódik, ha a kattintásra történő minimalizálás be van kapcsolva. A pajzs követi az ablakot, és eltűnik, amíg az ablak minimalizált, feloldott, teljes képernyős, vagy az X-énél egy másik ablak takarja. A `ClickDebugOverlay=1` beállításnál zölden látszik. Amíg egy ilyen osztályú ablak látható, az egérgombot 10 ms-onként ellenőrzi a program, akkor is, ha a kattintásra történő minimalizálás ki van kapcsolva. A Firefox maga rajzolja a címsorát, és a Windows nem jelenti az X gombjának helyét; a CCTrayTool ilyenkor úgy találja meg az X gombot, hogy megkérdezi az ablakot (naplófájl: "found by asking the window"). A helyzet alapján történő tartalék felismerést (`ClickGeometryFallback`) csak azoknál az ablakoknál használja a program, amelyek nem jelentik az X gombjukat a Windowsnak, például az Outlooknál és a Wordnél; a CCTrayTool minden ablakot egyszer megkérdez, és az eredményt a naplófájlba írja ("probe of the X").
- A rendszergazdaként futó programok ablakai nem zárolhatók, amíg a CCTrayTool maga nem fut rendszergazdaként (ez egy Windows-biztonsági szabály). Értesítés jelenik meg.
- Az asztalt, a tálcát és magának a CCTrayTool-nak az ablakait a program soha nem zárolja.
- Feloldáskor az ablak rendszermenüje visszaáll a Windows alapértelmezésére. Azok a bejegyzések, amelyeket a program maga adott ehhez a menühöz, a program újraindításáig hiányozhatnak.
- A zárolás csak addig tart, amíg a CCTrayTool fut: a program bezárásakor vagy a CloseGuard kikapcsolásakor minden ablak visszakapja a bezárás gombját. Ha a CCTrayTool-t erőszakkal fejezik be (például a Feladatkezelővel), a zárolt ablakok zárolva maradnak. Ilyenkor nyomja meg egy ilyen ablakban a zárolás/feloldás billentyűkombinációt (a CCTrayTool-nak ismét futnia kell), vagy zárja be az ablakot, és nyissa meg újra.

## 5. Gyorsindító menü saját programokhoz

A KeepAwake fölött a tálcamenü megjeleníti a "ToolTime" szakaszt: egy kattintással indítható programok listáját. A bejegyzések a számítógép egyik mappájából származnak (lásd 6. pont): a mappában lévő minden parancsikon (`.lnk` fájl) menübejegyzéssé, minden almappa almenüvé válik.

Alapértelmezés szerint már több beépített Windows-eszköz be van állítva, például:

- Számológép, Notepad (mappa: "Office")
- Explorer (közvetlenül a főmenüben)
- Parancssor, Rendszerleíró adatbázis-szerkesztő, Hálózati beállítások, Vezérlőpult, Erőforrás-figyelő, Teljesítményfigyelő, Szolgáltatások kezelése, Lemezkarbantartó (mappa: "Rendszer")

Azok a parancsikonok, amelyek programja nem található meg az adott számítógépen, automatikusan nem jelennek meg a menüben - így nem keletkezik hibaüzenet, ha egy eszköz hiányzik egy rendszerről.

Egyes bejegyzések (pl. Parancssor, Rendszerleíró adatbázis-szerkesztő) úgy vannak beállítva, hogy automatikusan rendszergazdai jogosultsággal induljanak (ilyenkor a Windows a Felhasználói fiókok felügyeletén keresztül megerősítést kér).

## 6. Saját eszközök és mappák hozzáadása

A gyorsindító menü eszközei egyszerűen egy mappában lévő parancsikonok. Eszköz hozzáadásához válassza a "Beállítások" menü "ToolTime mappa megnyitása" pontját, és helyezzen el egy parancsikont (`.lnk` fájlt) a megnyíló mappában. A CCTrayTool magától észleli a változást, és egy pillanattal később frissíti a tálcamenüt. (Ha ez nem történne meg, használja a "Beállítások" menü "Eszközök újratöltése" pontját.)

Gyors mód parancsikon létrehozására: húzza a programot a mappába a jobb egérgombbal, és válassza a "Parancsikonok létrehozása itt" lehetőséget.

Alapértelmezett mappa: `%LocalAppData%\CCTrayTool\ToolTime` (Másik mappa megadható a beállításfájlban, lásd alább.)

A ToolTime mappa létrehozásakor a CCTrayTool egy rövid tájékoztató fájlt is elhelyez benne ("`ToolTime_Info.txt`", a rendszer nyelvén). Röviden elmagyarázza a korlátokat, valamint azt, hogyan rendezhetők a bejegyzések a név elé írt számmal. A menü figyelmen kívül hagyja a fájlt; bármikor törölhető.

Hogyan lesz a mappából menü:

- **Parancsikon (`.lnk`)**: menübejegyzéssé válik. A név a fájlnév; az ikon a parancsikoné (ennek hiányában annak a programnak az ikonja, amelyre mutat).
- **Almappa**: almenüvé válik. Az ikonja a szokott módon módosítható a Windows Intézőben (Tulajdonságok > Testreszabás > Ikon módosítása).
- **Sorrend**: Először a mappák, utána a parancsikonok következnek, mindkettő betűrendben. Saját sorrendhez kezdje a nevet két vagy három számjeggyel és egy aláhúzással, pl. "`01_Notepad.lnk`". A szám csak a rendezést szolgálja, és nem jelenik meg.
- **Rendszergazda**: Kapcsolja be a "Futtatás rendszergazdaként" lehetőséget a parancsikon tulajdonságaiban (Parancsikon > Speciális). A Windows ekkor a bejegyzés indításakor megerősítést kér.
- **Nem jelennek meg**: Rejtett fájlok, nem parancsikon fájlok, olyan parancsikonok, amelyek programja nem létezik, valamint üres mappák.

Korlátok - hogy a menü használható maradjon:

A tálcamenü nem görgethető az egérgörgővel, csak két kis nyílgombbal, és egy hosszú menü kiszorítaná a KeepAwake, az AlwaysOnTop és a beállítások szakaszt a látható területről. Ezért:

- Menünként legfeljebb 15 bejegyzés (mappák és parancsikonok együtt) jelenik meg. Ez a korlát a beállításfájlban 10 és 20 közötti értékre módosítható (lásd alább).
- Legfeljebb 3 menüszint: a ToolTime menü és két almenüszint. A mélyebben lévő mappákat a program figyelmen kívül hagyja.
- Összesen legfeljebb 400 bejegyzés.

Tipp: sok eszközt inkább almappákba csoportosítson, ne egyetlen hosszú listába.

Ha egy korlát túllépésre kerül, semmi sem vész el észrevétlenül:

- A felesleges bejegyzések nem jelennek meg. Helyettük a menü egy szürkített sort tartalmaz, például "... további 3 nem jelenik meg (korlát: 15)".
- Értesítés jelenik meg, és a ToolTime szakasz megjeleníti a "(!) ToolTime: problémák találhatók - kattintson a részletekért" bejegyzést. Rákattintva pontosan látható, mi maradt ki és miért. Ugyanezek az információk a naplófájlba is bekerülnek (ha a "Naplófájl létrehozása" be van kapcsolva).
- A túl mélyen egymásba ágyazott mappákat és az olvashatatlan parancsikonokat a program ugyanígy jelzi.

Beállítások a beállításfájlban (`[ToolTime]` szakasz):

```ini
[ToolTime]
Enabled=1
MaxEntries=15
Folder=
```

- `Enabled`: 1 = a ToolTime megjelenik, 0 = el van rejtve (megegyezik a "ToolTime bekapcsolása" menüponttal)
- `MaxEntries`: A bejegyzések maximális száma menünként, 10 és 20 között (alapérték: 15). A többi értéket a program automatikusan javítja.
- `Folder`: Nem kötelező: másik ToolTime mappa elérési útja. Környezeti változók, például `%USERPROFILE%`, használhatók. Üres = alapértelmezett mappa. Ha a mappa nem létezik, a program létrehozza.

A fájl szerkesztéséhez válassza a "Beállítások" menü "Beállításfájl szerkesztése" pontját. A Jegyzettömb mentése és bezárása után a CCTrayTool újra beolvassa a fájlt, azonnal alkalmazza az összes módosítást (újraindítás nélkül), és újraépíti a tálcamenüt.

Az alapértelmezett eszközök visszaállítása: lépjen ki a CCTrayTool-ból, törölje a ToolTime mappát, majd indítsa újra a programot - az alapértelmezett eszközök és a tájékoztató fájl újra létrejön.

## 7. További beállítások

A "Beállítások" almenüben ezenkívül elérhető:

- **ToolTime bekapcsolása**: Teljesen be- vagy kikapcsolja az eszközök gyorsindító szakaszát (lásd 5. pont). Kikapcsolt állapotban egyik bejegyzése sem jelenik meg a tálcamenüben, függetlenül attól, hogy mi van a ToolTime mappában.
- **ToolTime mappa megnyitása**: Megnyitja a ToolTime mappát a Windows Intézőben, hogy parancsikonokat lehessen hozzáadni, átnevezni vagy törölni (lásd 6. pont).
- **Eszközök újratöltése**: Újra beolvassa a ToolTime mappát, és újraépíti a menüt. Általában nem szükséges, mert a mappában történt változásokat a program automatikusan észleli.
- **KeepAwake bekapcsolása**: Teljesen be- vagy kikapcsolja a KeepAwake szakaszt (lásd 2. pont). Kikapcsolt állapotban bejegyzései eltűnnek a tálcamenüből, és a Windows normál energiatakarékossági viselkedése érvényes.
- **AlwaysOnTop bekapcsolása**: Teljesen be- vagy kikapcsolja az AlwaysOnTop szakaszt (lásd 3. pont). Kikapcsolt állapotban bejegyzései eltűnnek a tálcamenüből, és a billentyűkombináció letiltásra kerül.
- **CloseGuard bekapcsolása**: Teljesen be- vagy kikapcsolja a CloseGuard egész szakaszát (lásd 4. pont). Kikapcsolt állapotban bejegyzései eltűnnek a tálcamenüből, a billentyűkombinációk letiltásra kerülnek, és minden zárolt ablak visszakapja a bezárás gombját.
- **\<Funkció\> almenüként**: A ToolTime, a KeepAwake, az AlwaysOnTop és a CloseGuard esetében is megtalálható, mindig közvetlenül az adott funkciót be- és kikapcsoló bejegyzés alatt. A szakaszt a tálcamenüben a funkció nevét viselő almenüként jeleníti meg a bejegyzések listája helyett, így a menü rövidebb lesz. A funkció változatlanul működik tovább. Átkapcsoláskor a tálcamenü bezárul; egyszerűen nyissa meg újra. Amíg maga a funkció ki van kapcsolva, a bejegyzés szürkén jelenik meg. A beállítási fájlban ez a funkció szakaszában (`[ToolTime]`, `[KeepAwake]`, `[AlwaysOnTop]`, `[CloseGuard]`) található "AsSubmenu" bejegyzés: 1 = almenü, 0 = normál (alapértelmezett).
- **Automatikus indítás**: A CCTrayTool ezentúl automatikusan elindul a Windows bejelentkezéskor.
- **Naplófájl létrehozása**: Részletes naplót ír az összes műveletről egy naplófájlba. Hasznos hibakereséshez, normál üzemben nem szükséges. A beállításfájlban ez a `[Main]` szakasz "`UseLog`" bejegyzése: 1 = be; 0, üres vagy hiányzó bejegyzés, illetve bármilyen más érték = ki.
- **Naplófájl megtekintése**: Megnyitja az aktuális naplófájlt a Jegyzettömbben.
- **Nagy ikonok használata**: Nagyobban jeleníti meg az ikonokat a tálcamenüben (32 a 16 pixel helyett).
- **Beállításfájl szerkesztése**: Közvetlenül megnyitja a konfigurációs fájlt szerkesztésre (lásd a 6. pontot).

## 8. Tárolási helyek

A CCTrayTool a saját fájljait a felhasználói profilban tárolja:

- **Konfiguráció:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Naplófájl:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **ToolTime mappa:** `%LocalAppData%\CCTrayTool\ToolTime\`
- **CloseGuard-szabályok:** `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`

(Az elérési út beilleszthető a Windows Intéző címsorába, hogy közvetlenül a mappához jusson.)

## 9. A program bezárása

A CCTrayTool a "Kilépés" menüponttal zárható be. Ez automatikusan visszaállítja a Windows normál energiatakarékossági viselkedését, és elmenti az aktuális konfigurációt.

Azok az ablakok, amelyek bezárás gombját a CloseGuard zárolta, ilyenkor visszakapják a bezárás gombjukat.

## 10. Névjegy / Kapcsolat

A jelenleg telepített verzió bármikor megtekinthető a "Névjegy" menüponttal.

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licenc: GNU General Public License, 3. vagy újabb verzió (GPL-3.0-or-later), kiegészítő szerzőmegjelölési feltétellel; lásd a [LICENSE](../LICENSE) és a [NOTICE](../NOTICE) fájlt.
