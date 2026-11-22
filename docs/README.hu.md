# CCTrayTool – Felhasználói kézikönyv

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Español](README.es.md) · [Français](README.fr.md) · [Polski](README.pl.md) · **Magyar** · [Русский](README.ru.md)

A CCTrayTool egy kis Windows-eszköz, amely ikonként fut a tálcán (jobbra lent, az óra mellett). Három hasznos funkciót egyesít egyetlen programban:

1. **KeepAwake** – megakadályozza, hogy a számítógép energiatakarékos módba váltson, vagy hogy a képernyő kikapcsoljon
2. **AlwaysOnTop** – billentyűkombinációval bármely ablakot az előtérben tart
3. **Eszközök gyorsindítása** – egy kattintással indítja a gyakran használt programokat közvetlenül a tálcamenüből

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

Az "Állapot mentése" menüpont hatására a CCTrayTool megjegyzi az utoljára kiválasztott KeepAwake-beállítást, és a következő induláskor automatikusan visszaállítja.

A CCTrayTool bezárásakor a Windows normál energiatakarékossági viselkedése automatikusan visszaáll.

## 3. AlwaysOnTop - ablak az előtérben tartása

A SHIFT + ALT + T (alapértelmezett) billentyűkombináció tartósan az előtérben tartja az éppen aktív ablakot - még akkor is, ha más ablakokra kattintanak. Ismételt megnyomásra ez a rögzítés megszűnik.

Váltáskor egy kis értesítés jelenik meg röviden az egérmutató közelében, amely megerősíti, hogy az ablak most "az előtérben marad"-e, vagy "visszaállt normálra". Ez az értesítés a "ToolTip megjelenítése" menüponttal ki- és bekapcsolható.

Az "AlwaysOnTop" menüben a következő beállítások érhetők el:

- **Gyorsbillentyű aktív**: Teljesen be- vagy kikapcsolja a billentyűkombinációt
- **Gyorsbillentyű módosítása**: Megnyit egy párbeszédablakot, ahol saját billentyűkombináció adható meg (Ctrl, Alt, Shift, Win kombinációja egy betűvel, számmal vagy F1-F12 funkcióbillentyűvel)
- **ToolTip megjelenítése**: Be- vagy kikapcsolja a rövid képernyőn megjelenő értesítést váltáskor

Megjegyzés: Maga a Windows asztal ("Program Manager") nem állítható be "mindig az előtérben" módra. Nem minden billentyűkombináció szabad - néhányat már a rendszer vagy más programok lefoglaltak. Ilyenkor egy értesítés jelenik meg, és más kombinációt kell választani.

## 4. Gyorsindító menü saját programokhoz

A KeepAwake fölött a tálcamenü megjeleníti a "ToolTime" szakaszt: egy kattintással indítható programok listáját. A bejegyzések a számítógép egyik mappájából származnak (lásd 5. pont): a mappában lévő minden parancsikon (`.lnk` fájl) menübejegyzéssé, minden almappa almenüvé válik.

Alapértelmezés szerint már több beépített Windows-eszköz be van állítva, például:

- Számológép, Notepad (mappa: "Office")
- Explorer (közvetlenül a főmenüben)
- Parancssor, Rendszerleíró adatbázis-szerkesztő, Hálózati beállítások, Vezérlőpult, Erőforrás-figyelő, Teljesítményfigyelő, Szolgáltatások kezelése, Lemezkarbantartó (mappa: "Rendszer")

Azok a parancsikonok, amelyek programja nem található meg az adott számítógépen, automatikusan nem jelennek meg a menüben - így nem keletkezik hibaüzenet, ha egy eszköz hiányzik egy rendszerről.

Egyes bejegyzések (pl. Parancssor, Rendszerleíró adatbázis-szerkesztő) úgy vannak beállítva, hogy automatikusan rendszergazdai jogosultsággal induljanak (ilyenkor a Windows a Felhasználói fiókok felügyeletén keresztül megerősítést kér).

## 5. Saját eszközök és mappák hozzáadása

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

## 6. További beállítások

A "Beállítások" almenüben ezenkívül elérhető:

- **ToolTime bekapcsolása**: Teljesen be- vagy kikapcsolja az eszközök gyorsindító szakaszát (lásd 4. pont). Kikapcsolt állapotban egyik bejegyzése sem jelenik meg a tálcamenüben, függetlenül attól, hogy mi van a ToolTime mappában.
- **ToolTime mappa megnyitása**: Megnyitja a ToolTime mappát a Windows Intézőben, hogy parancsikonokat lehessen hozzáadni, átnevezni vagy törölni (lásd 5. pont).
- **Eszközök újratöltése**: Újra beolvassa a ToolTime mappát, és újraépíti a menüt. Általában nem szükséges, mert a mappában történt változásokat a program automatikusan észleli.
- **KeepAwake bekapcsolása**: Teljesen be- vagy kikapcsolja a KeepAwake szakaszt (lásd 2. pont). Kikapcsolt állapotban bejegyzései eltűnnek a tálcamenüből, és a Windows normál energiatakarékossági viselkedése érvényes.
- **AlwaysOnTop bekapcsolása**: Teljesen be- vagy kikapcsolja az AlwaysOnTop szakaszt (lásd 3. pont). Kikapcsolt állapotban bejegyzései eltűnnek a tálcamenüből, és a billentyűkombináció letiltásra kerül.
- **Automatikus indítás**: A CCTrayTool ezentúl automatikusan elindul a Windows bejelentkezéskor.
- **Naplófájl létrehozása**: Részletes naplót ír az összes műveletről egy naplófájlba. Hasznos hibakereséshez, normál üzemben nem szükséges. A beállításfájlban ez a `[Main]` szakasz "`UseLog`" bejegyzése: 1 = be; 0, üres vagy hiányzó bejegyzés, illetve bármilyen más érték = ki.
- **Naplófájl megtekintése**: Megnyitja az aktuális naplófájlt a Jegyzettömbben.
- **Nagy ikonok használata**: Nagyobban jeleníti meg az ikonokat a tálcamenüben (32 a 16 pixel helyett).
- **Beállításfájl szerkesztése**: Közvetlenül megnyitja a konfigurációs fájlt szerkesztésre (lásd az 5. pontot).

## 7. Tárolási helyek

A CCTrayTool a saját fájljait a felhasználói profilban tárolja:

- **Konfiguráció:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Naplófájl:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **ToolTime mappa:** `%LocalAppData%\CCTrayTool\ToolTime\`

(Az elérési út beilleszthető a Windows Intéző címsorába, hogy közvetlenül a mappához jusson.)

## 8. A program bezárása

A CCTrayTool a "Kilépés" menüponttal zárható be. Ez automatikusan visszaállítja a Windows normál energiatakarékossági viselkedését, és elmenti az aktuális konfigurációt.

## 9. Névjegy / Kapcsolat

A jelenleg telepített verzió bármikor megtekinthető a "Névjegy" menüponttal.

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licenc: GNU General Public License, 3. vagy újabb verzió (GPL-3.0-or-later), kiegészítő szerzőmegjelölési feltétellel; lásd a [LICENSE](../LICENSE) és a [NOTICE](../NOTICE) fájlt.
