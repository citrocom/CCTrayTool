# CCTrayTool – Manuale d'uso

[English](../README.md) · [Deutsch](README.de.md) · **Italiano** · [Español](README.es.md) · [Français](README.fr.md) · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool è un piccolo strumento per Windows che viene eseguito come icona nell'area di notifica (in basso a destra, accanto all'orologio). Riunisce quattro funzioni utili in un unico programma:

1. **KeepAwake** – impedisce che il PC entri in modalità di risparmio energetico o che lo schermo si spenga
2. **AlwaysOnTop** – mantiene una finestra qualsiasi sempre in primo piano tramite una combinazione di tasti
3. **Avvio rapido strumenti** – avvia i programmi usati più spesso direttamente dal menu dell'area di notifica
4. **CloseGuard** – blocca il pulsante di chiusura (X) di finestre selezionate, con una combinazione di tasti o con regole

Tutte le funzioni si utilizzano tramite un clic destro sull'icona nell'area di notifica. Non è necessaria alcuna installazione, il programma può essere avviato direttamente.

CCTrayTool supporta le lingue inglese, tedesco, italiano, spagnolo, francese, polacco, ungherese e russo. La lingua viene impostata automaticamente in base alla lingua di sistema del computer.

Requisiti di sistema: è necessario Windows 10 o successivo a 64 bit. Il programma non funziona su Windows a 32 bit.

## 1. Avvio e prima icona

Dopo l'avvio, viene visualizzata un'icona nell'area di notifica della barra delle applicazioni di Windows. Il colore dell'icona indica immediatamente lo stato attuale di KeepAwake:

- Bianco = KeepAwake disattivato (comportamento normale di Windows)
- Rosso = KeepAwake attivo per i monitor
- Blu = KeepAwake attivo per il sistema
- Verde = KeepAwake attivo per monitor e sistema

Un clic con il tasto destro del mouse sull'icona apre il menu con tutte le funzioni. Se l'icona non è visibile, controllare l'area delle "icone nascoste" (piccola freccia nella barra delle applicazioni).

Nota: CCTrayTool può essere avviato una sola volta alla volta. Un secondo avvio non ha alcun effetto se il programma è già in esecuzione.

## 2. KeepAwake - impedire il risparmio energetico

Nella sezione di menu "KeepAwake" è possibile selezionare cosa il PC NON deve fare mentre CCTrayTool è in esecuzione:

- **Monitor e sistema**: Né lo schermo si spegne, né il PC entra in standby/modalità di risparmio energetico. Ideale per presentazioni o processi di lunga durata in cui lo schermo deve rimanere visibile.
- **Monitor**: Solo lo schermo rimane acceso (nessuno spegnimento, nessun salvaschermo). Il PC stesso può comunque entrare in standby dopo il proprio timeout.
- **Sistema**: Il PC non entra in standby/modalità di risparmio energetico, ma lo schermo può comunque spegnersi secondo le impostazioni di Windows. Utile, ad esempio, per download lunghi o calcoli in background.
- **Disattivato**: CCTrayTool non interviene; si applica il normale comportamento di risparmio energetico di Windows.

La voce di menu "Salva stato" nel sottomenu "Impostazioni" della sezione KeepAwake fa sì che CCTrayTool memorizzi l'ultima impostazione KeepAwake selezionata e la ripristini automaticamente al successivo avvio.

Alla chiusura di CCTrayTool, il normale comportamento di risparmio energetico di Windows viene ripristinato automaticamente.

## 3. AlwaysOnTop - mantenere una finestra in primo piano

La combinazione di tasti MAIUSC + ALT + T (predefinita) mantiene permanentemente in primo piano la finestra attualmente attiva, anche quando si fa clic su altre finestre. Premendola di nuovo si annulla questo blocco.

Al momento del cambio, vicino al puntatore del mouse compare brevemente un piccolo avviso che conferma se la finestra ora "rimane in primo piano" oppure è "tornata normale". Questo avviso può essere attivato o disattivato tramite la voce di menu "Mostra ToolTip".

Nel menu "AlwaysOnTop" sono disponibili le seguenti opzioni:

- **Hotkey attivo**: Attiva o disattiva completamente la combinazione di tasti
- **Impostazioni**: Sottomenu (icona a forma di ingranaggio) con le voci seguenti:
  - **Cambia hotkey**: Apre una finestra di dialogo in cui è possibile impostare una combinazione di tasti personalizzata (combinazione di Ctrl, Alt, Maiusc, Win più una lettera, un numero o un tasto funzione F1-F12)
  - **Mostra ToolTip**: Attiva o disattiva il breve avviso a schermo al momento del cambio

Nota: Il desktop di Windows stesso ("Program Manager") non può essere impostato su "sempre in primo piano". Non tutte le combinazioni di tasti sono libere: alcune sono già occupate dal sistema o da altri programmi. In questo caso viene visualizzato un avviso ed è necessario scegliere un'altra combinazione.

## 4. CloseGuard - bloccare il pulsante di chiusura

CloseGuard protegge le finestre dalla chiusura accidentale. Per le finestre scelte blocca il pulsante di chiusura (la "X" in alto a destra nella finestra): il pulsante appare disattivato e un clic su di esso non ha alcun effetto. È utile per i programmi che devono rimanere in esecuzione o per le finestre che vengono chiuse per errore di continuo.

Una finestra può essere bloccata in due modi:

- **A mano, con una combinazione di tasti**: Fare clic sulla finestra e premere CTRL + ALT + X (predefinita). Il pulsante di chiusura di questa finestra è ora bloccato. Premendo di nuovo la combinazione lo si sblocca. Una finestra sbloccata in questo modo resta libera, anche se una regola corrisponde, finché non viene chiusa. Una breve notifica conferma ogni modifica. Il blocco dura finché la finestra non viene chiusa o sbloccata.
- **Automaticamente, con regole**: Fare clic sulla finestra e premere CTRL + ALT + MAIUSC + X (predefinita). CCTrayTool salva nel file delle regole una regola composta dal titolo e dalla classe della finestra e blocca la finestra. Da quel momento ogni finestra che corrisponde alla regola viene bloccata automaticamente non appena compare - anche dopo il riavvio del programma o di CCTrayTool.

Nel menu dell'area di notifica, la sezione "CloseGuard" offre queste voci:

- **Blocca/sblocca il pulsante di chiusura della finestra attiva**: Fa la stessa cosa della prima combinazione di tasti. Finché il menu dell'area di notifica è aperto, il focus è sul menu stesso; CloseGuard usa quindi la finestra che era attiva subito prima.
- **Crea regola per la finestra attiva**: Fa la stessa cosa della seconda combinazione di tasti.
- **Mostra finestre bloccate**: Mostra quali finestre sono bloccate al momento (da una regola o a mano, con la classe della finestra tra parentesi quadre) e quante regole esistono.

Sotto di esse, il sottomenu "Impostazioni" (icona a forma di ingranaggio) contiene:

- **Controlla automaticamente le nuove finestre**: Attivo: CloseGuard resta in osservazione e blocca ogni nuova finestra che corrisponde a una regola. Disattivo: le nuove finestre non vengono bloccate automaticamente.
- **Controlla le finestre aperte all'avvio**: Attivo: le finestre già aperte all'avvio di CCTrayTool vengono confrontate subito con le regole. Disattivo: queste finestre restano intatte; vengono controllate solo quelle aperte in seguito.
- **Riduci a icona la finestra al clic sulla X bloccata**: Attivo: un clic sul pulsante di chiusura disattivato riduce a icona la finestra invece di non fare nulla. Come con un pulsante vero, la finestra viene ridotta a icona solo se il pulsante del mouse viene rilasciato anch'esso sulla X; premere il pulsante e spostarsi altrove annulla il clic. Disattivo (predefinito): un clic non fa nulla.
- **Cambia hotkey: blocca/sblocca** / **Cambia hotkey: crea regola**: Apre la stessa finestra di dialogo di AlwaysOnTop per definire un'altra combinazione di tasti. Una combinazione già usata da un'altra funzione di CCTrayTool viene rifiutata.
- **Modifica regole...**: Apre il file delle regole in Blocco note (vedi sotto). Dopo aver salvato e chiuso Blocco note, le regole modificate vengono applicate subito: le finestre bloccate da una regola che non corrisponde più vengono sbloccate e le nuove regole valgono subito per le finestre aperte.

CloseGuard nel suo complesso si attiva e si disattiva con "Attiva CloseGuard" nel menu "Impostazioni" della sezione "CCTrayTool" (vedi sezione 7).

Regole (file dedicato `CloseGuardRules.ini`, sezione `[Rules]`):

Le regole non sono nel file di configurazione, ma in un file dedicato: `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`. Viene creato automaticamente. È un file Unicode, quindi funzionano anche i titoli di finestra con lettere accentate o altri caratteri speciali. Blocco note mantiene questo formato; se il file viene modificato con un altro programma, salvarlo ugualmente come Unicode (UTF-16), altrimenti i caratteri speciali possono andare persi. Le regole vengono rilette quando si chiude Blocco note dopo "Modifica regole..." e a ogni avvio di CCTrayTool.

Ogni riga è una regola nella forma `numero=titolo|classe`. Il titolo è un testo che deve comparire in un punto qualsiasi del titolo della finestra. La classe è il nome tecnico del tipo di finestra e deve corrispondere esattamente. Maiuscole e minuscole non contano. Una delle due parti può essere vuota (il "|" deve restare); se sono compilate entrambe, devono corrispondere entrambe. Esempi:

- `1=Calculator|`: ogni finestra con "Calculator" nel titolo
- `2=|Notepad`: ogni finestra della classe "Notepad"
- `3=Untitled|Notepad`: finestre della classe "Notepad" con "Untitled" nel titolo

La combinazione di tasti "crea regola" usa il titolo attuale completo della finestra. Se il titolo cambia (ad esempio con il nome di un documento aperto), accorciarlo in seguito con "Modifica regole..." alla parte che rimane uguale, oppure lasciare vuoto il titolo e tenere solo la classe. La classe di una finestra bloccata è mostrata da "Mostra finestre bloccate". Una regola con titolo e classe vuoti viene ignorata; vengono usate al massimo 200 regole.

Impostazioni nel file di configurazione (sezione `[CloseGuard]`):

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

- `Enabled`: 1 = CloseGuard attivo, 0 = disattivo (come la voce di menu "Attiva CloseGuard").
- `HotkeyToggle`: Combinazione di tasti per bloccare/sbloccare. `^` = Ctrl, `!` = Alt, `+` = Maiusc, `#` = Win, seguito dal tasto. È più semplice cambiarla con la voce di menu "Cambia hotkey".
- `HotkeyAddRule`: Combinazione di tasti per "crea regola".
- `ApplyOnStartup`: 1 = le finestre aperte all'avvio del programma vengono confrontate con le regole, 0 = restano intatte.
- `AutoApply`: 1 = le nuove finestre vengono controllate automaticamente, 0 = no.
- `PollInterval`: Ogni quanto vengono controllate le finestre, in millisecondi: da 250 a 5000 (predefinito: 500). Gli altri valori vengono corretti automaticamente.
- `MinimizeOnClick`: 1 = un clic sul pulsante di chiusura bloccato riduce a icona la finestra, 0 = non fa nulla (predefinito). Equivale alla voce di menu.
- `ClickPollInterval`: Ogni quanto viene controllato a tale scopo il pulsante del mouse, in millisecondi: da 10 a 100 (predefinito: 30). Un valore minore riconosce con più sicurezza anche i clic molto brevi, uno maggiore richiede meno tempo di calcolo. Gli altri valori vengono corretti automaticamente. Per questa impostazione non esiste una voce di menu.
- `ClickGeometryFallback`: 1 = se una finestra con barra del titolo propria (per esempio Outlook) non comunica a Windows la sua X, la X viene riconosciuta in base alla posizione (predefinito). 0 = viene riconosciuta solo una X che la finestra comunica da sé.
- `ClickGeometryExtendLeft`: Quanto si estende verso sinistra l'area in cui la X viene riconosciuta in base alla posizione, in percentuale della larghezza della X: da 0 a 100 (predefinito: 0). Alcuni programmi disegnano la loro X più a sinistra di quanto indica Windows. Un valore troppo grande arriva fino al pulsante di ingrandimento vicino.
- `ClickGeometryExtendDown`: Quanto si estende verso il basso quest'area, in percentuale dell'altezza della X: da 0 a 100 (predefinito: 87). Alcuni programmi disegnano la loro X più in basso di quanto indica Windows. Stesso scopo e stessi limiti di `ClickGeometryExtendLeft`.
- `ClickDebugOverlay`: 1 = mostra sullo schermo, come rettangoli colorati e trasparenti, le aree usate per riconoscere la X: rosso = l'area in cui un clic vale come clic sulla X, blu = l'area del pulsante di chiusura indicata da Windows (o, se Windows non ne indica una, l'area della X trovata interrogando la finestra), verde = lo scudo sopra la X (vedi `ClickShieldClasses`). Solo per la ricerca di errori. 0 = disattivato (predefinito).
- `ClickShieldClasses`: Classi di finestre (separate da virgole) di programmi che si chiudono da soli quando il pulsante del mouse viene rilasciato, ad esempio Edge e Chrome (`Chrome_WidgetWin_1`) e Firefox (`MozillaWindowClass`); per impostazione predefinita entrambe. La X di tale finestra viene coperta da una finestra quasi invisibile che intercetta il clic, così la finestra non può più essere chiusa con la X. Vuoto = nessuna.

Le due combinazioni di tasti di CloseGuard e quella di AlwaysOnTop devono essere diverse tra loro. In caso contrario vengono usate quelle predefinite.

Da sapere:

- Il blocco protegge da un clic accidentale sulla X. A seconda del programma, una finestra può comunque essere chiusa in altri modi: con ALT + F4, con "Chiudi finestra" nella barra delle applicazioni, con un comando Esci nel menu del programma o con Gestione attività.
- Si possono bloccare solo le finestre con una normale barra del titolo e un menu di sistema. I programmi che disegnano da soli la barra del titolo (molte app moderne, alcuni browser, app del Microsoft Store) possono mantenere una X funzionante anche se CloseGuard segnala la finestra come bloccata. Se una finestra non ha affatto un menu di sistema, compare un avviso.
- Riduzione a icona con un clic: CCTrayTool controlla il pulsante del mouse brevemente e a intervalli regolari (predefinito: ogni 30 ms), e solo finché è visibile almeno una finestra bloccata. Non usa alcun hook del mouse, quindi non può rallentare né il mouse né il sistema. Nel caso improbabile in cui un clic molto breve cada in un momento in cui CCTrayTool è occupato, semplicemente non viene rilevato: la finestra resta com'è e la sua X resta bloccata.
- La riduzione a icona con un clic reagisce al pulsante primario del mouse (quello destro, se in Windows i pulsanti sono invertiti) e solo alla X delle finestre bloccate. L'input tattile e con penna non viene rilevato. Se un programma ignora il comando di riduzione a icona, CCTrayTool riduce a icona la finestra direttamente.
- Alcuni programmi disegnano da sé la propria barra del titolo (per esempio Outlook). Non comunicano a Windows dove si trova la loro X, quindi per il rilevamento del clic CCTrayTool calcola la posizione della X nell'angolo in alto a destra della finestra (chiave INI `ClickGeometryFallback`). Nel file di log compare allora "recognized by its position".
- Edge, Chrome e altri programmi basati su Chromium, così come Firefox, disegnano da soli la X e chiudono la finestra da soli quando il pulsante del mouse viene rilasciato, quindi il menu di sistema bloccato non li ferma. Sopra la X di tali finestre (chiave INI `ClickShieldClasses`, predefinita `Chrome_WidgetWin_1,MozillaWindowClass`) CCTrayTool pone una finestra quasi invisibile, uno scudo. Il clic finisce sullo scudo e il programma non lo vede mai: non succede nulla, oppure la finestra viene ridotta a icona se la riduzione a icona al clic è attiva. Lo scudo segue la finestra e scompare finché la finestra è ridotta a icona, sbloccata, a schermo intero o coperta da un'altra finestra sopra la X. Con `ClickDebugOverlay=1` viene mostrato in verde. Finché una finestra di tale classe è visibile, il pulsante del mouse viene controllato ogni 10 ms, anche se la riduzione a icona al clic è disattivata. Firefox disegna da solo la barra del titolo e Windows non comunica la posizione della sua X; CCTrayTool trova allora la X interrogando la finestra (file di log: "found by asking the window"). Il riconoscimento di riserva in base alla posizione (`ClickGeometryFallback`) viene usato solo per le finestre che non comunicano la loro X a Windows, come Outlook e Word; CCTrayTool interroga ogni finestra una volta e scrive il risultato nel file di log ("probe of the X").
- Le finestre dei programmi eseguiti come amministratore non possono essere bloccate finché CCTrayTool non è a sua volta eseguito come amministratore (una regola di sicurezza di Windows). Compare un avviso.
- Il desktop, la barra delle applicazioni e le finestre di CCTrayTool stesso non vengono mai bloccati.
- Quando una finestra viene sbloccata, il suo menu di sistema viene riportato allo standard di Windows. Le voci che il programma stesso ha aggiunto a questo menu possono mancare finché il programma non viene riavviato.
- Un blocco dura solo finché CCTrayTool è in esecuzione: alla chiusura del programma o alla disattivazione di CloseGuard tutte le finestre riottengono il pulsante di chiusura. Se CCTrayTool viene terminato forzatamente (ad esempio con Gestione attività), le finestre bloccate restano bloccate. In tal caso premere in una di esse la combinazione per bloccare/sbloccare (CCTrayTool deve essere di nuovo in esecuzione) oppure chiudere la finestra e riaprirla.

## 5. Menu di avvio rapido per programmi personalizzati

Sopra KeepAwake, il menu dell'area di notifica mostra la sezione "ToolTime": un elenco di programmi che si avviano con un solo clic. Le voci provengono da una cartella del PC (vedi sezione 6): ogni collegamento (file `.lnk`) in questa cartella diventa una voce di menu e ogni sottocartella diventa un sottomenu.

Per impostazione predefinita sono già configurati alcuni strumenti integrati di Windows, tra cui:

- Calcolatrice, Notepad (cartella "Office")
- Explorer (direttamente nel menu principale)
- Prompt dei comandi, Editor del Registro di sistema, Impostazioni di rete, Pannello di controllo, Monitor risorse, Monitor prestazioni, Gestisci servizi, Pulizia disco (cartella "Sistema")

I collegamenti il cui programma non viene trovato sul rispettivo PC non compaiono automaticamente nel menu: non viene quindi visualizzato alcun messaggio di errore se uno strumento manca su un sistema.

Alcune voci (ad es. Prompt dei comandi, Editor del Registro di sistema) sono configurate per avviarsi automaticamente con privilegi di amministratore (in questo caso Windows chiede conferma tramite il Controllo account utente).

## 6. Aggiungere strumenti e cartelle personalizzati

Gli strumenti del menu di avvio rapido sono semplici collegamenti in una cartella. Per aggiungere uno strumento, selezionare nel menu "Impostazioni" la voce "Apri cartella ToolTime" e inserire un collegamento (file `.lnk`) nella cartella che si apre. CCTrayTool rileva la modifica da solo e aggiorna il menu poco dopo. (Se ciò non avviene, usare la voce "Ricarica strumenti" nel menu "Impostazioni".)

Un modo rapido per creare un collegamento: trascinare un programma nella cartella con il tasto destro del mouse e scegliere "Crea collegamenti qui".

Cartella predefinita: `%LocalAppData%\CCTrayTool\ToolTime` (Un'altra cartella può essere impostata nel file di configurazione, vedi sotto.)

Quando CCTrayTool crea la cartella ToolTime, vi inserisce anche un breve file informativo ("`ToolTime_Info.txt`", nella lingua del sistema). Spiega in breve i limiti e come ordinare le voci con un numero iniziale. Il menu ignora il file; può essere eliminato in qualsiasi momento.

Come la cartella diventa un menu:

- **Collegamento (`.lnk`)**: diventa una voce di menu. Il nome è il nome del file; l'icona è quella del collegamento (o, se manca, quella del programma a cui punta).
- **Sottocartella**: diventa un sottomenu. La sua icona si può modificare come di consueto in Esplora file (Proprietà > Personalizza > Cambia icona).
- **Ordine**: Prima le cartelle, poi i collegamenti, ciascuno in ordine alfabetico. Per un ordine personalizzato, iniziare il nome con due o tre cifre e un trattino basso, ad es. "`01_Notepad.lnk`". Il numero serve solo per l'ordinamento e non viene mostrato.
- **Amministratore**: Attivare "Esegui come amministratore" nelle proprietà del collegamento (Collegamento > Avanzate). All'avvio della voce Windows chiede conferma.
- **Non visualizzati**: File nascosti, file che non sono collegamenti, collegamenti il cui programma non esiste e cartelle vuote.

Limiti - affinché il menu resti utilizzabile:

Un menu dell'area di notifica non si può scorrere con la rotellina del mouse, ma solo con due piccoli pulsanti a freccia, e un menu lungo spingerebbe KeepAwake, AlwaysOnTop e le impostazioni fuori dalla vista. Pertanto:

- Per ogni menu vengono mostrate al massimo 15 voci (cartelle e collegamenti insieme). Questo limite può essere modificato nel file di configurazione con un valore compreso tra 10 e 20 (vedi sotto).
- Al massimo 3 livelli di menu: il menu ToolTime più due livelli di sottomenu. Le cartelle più profonde vengono ignorate.
- Al massimo 400 voci in totale.

Suggerimento: raggruppare molti strumenti in sottocartelle invece di un unico elenco lungo.

Se un limite viene superato, nulla va perso inosservato:

- Le voci in eccesso non vengono mostrate. Al loro posto il menu contiene una riga disattivata come "... altri 3 non visualizzati (limite 15)".
- Compare una notifica e la sezione ToolTime mostra la voce "(!) ToolTime: rilevati problemi - fare clic per i dettagli". Facendo clic si ottiene l'elenco esatto di ciò che è stato ignorato e del motivo. Le stesse informazioni vengono scritte nel file di log (se "Crea file di log" è attivato).
- Le cartelle annidate troppo in profondità e i collegamenti che non possono essere letti vengono segnalati allo stesso modo.

Impostazioni nel file di configurazione (sezione `[ToolTime]`):

```ini
[ToolTime]
Enabled=1
MaxEntries=15
Folder=
```

- `Enabled`: 1 = mostra ToolTime, 0 = nascondi (come la voce di menu "Attiva ToolTime")
- `MaxEntries`: Numero massimo di voci per menu, da 10 a 20 (predefinito: 15). Gli altri valori vengono corretti automaticamente.
- `Folder`: Facoltativo: percorso di un'altra cartella ToolTime. Sono ammesse variabili d'ambiente come `%USERPROFILE%`. Vuoto = cartella predefinita. Se la cartella non esiste, viene creata.

Per modificare il file, selezionare nel menu "Impostazioni" la voce "Modifica file di configurazione". Dopo aver salvato e chiuso Blocco note, CCTrayTool rilegge il file, applica subito tutte le modifiche (senza riavvio) e ricostruisce il menu.

Ripristinare gli strumenti predefiniti: chiudere CCTrayTool, eliminare la cartella ToolTime e riavviare il programma: gli strumenti predefiniti e il file informativo vengono ricreati.

## 7. Altre impostazioni

Nel sottomenu "Impostazioni" sono inoltre disponibili:

- **Attiva ToolTime**: Attiva o disattiva completamente l'intera sezione di avvio rapido degli strumenti (vedi sezione 5). Se disattivata, nessuna delle sue voci compare nel menu dell'area di notifica, indipendentemente da ciò che si trova nella cartella ToolTime.
- **Apri cartella ToolTime**: Apre la cartella ToolTime in Esplora file, per aggiungere, rinominare o rimuovere collegamenti (vedi sezione 6).
- **Ricarica strumenti**: Rilegge la cartella ToolTime e ricostruisce il menu. Normalmente non è necessario, poiché le modifiche nella cartella vengono rilevate automaticamente.
- **Attiva KeepAwake**: Attiva o disattiva completamente l'intera sezione KeepAwake (vedi sezione 2). Se disattivata, le sue voci scompaiono dal menu dell'area di notifica e si applica il normale comportamento di risparmio energetico di Windows.
- **Attiva AlwaysOnTop**: Attiva o disattiva completamente l'intera sezione AlwaysOnTop (vedi sezione 3). Se disattivata, le sue voci scompaiono dal menu dell'area di notifica e la combinazione di tasti viene disattivata.
- **Attiva CloseGuard**: Attiva o disattiva completamente l'intera sezione CloseGuard (vedi sezione 4). Se disattivata, le sue voci scompaiono dal menu dell'area di notifica, le combinazioni di tasti vengono disattivate e tutte le finestre bloccate riottengono il pulsante di chiusura.
- **Avvio automatico**: CCTrayTool si avvierà automaticamente in futuro all'accesso a Windows.
- **Crea file di log**: Scrive un registro dettagliato di tutte le azioni in un file di log. Utile per la risoluzione dei problemi, non necessario nel funzionamento normale. Nel file di configurazione è la voce "`UseLog`" nella sezione `[Main]`: 1 = attivo; 0, una voce vuota o mancante o qualsiasi altro valore = disattivato.
- **Visualizza file di log**: Apre il file di log corrente in Blocco note.
- **Usa icone grandi**: Visualizza le icone nel menu dell'area di notifica più grandi (32 invece di 16 pixel).
- **Modifica file di configurazione**: Apre direttamente il file di configurazione per la modifica (vedi sezione 6).

## 8. Percorsi di archiviazione

CCTrayTool salva i propri file nel profilo utente:

- **Configurazione:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **File di log:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Cartella ToolTime:** `%LocalAppData%\CCTrayTool\ToolTime\`
- **Regole di CloseGuard:** `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`

(Il percorso può essere incollato nella barra degli indirizzi di Esplora risorse per accedere direttamente alla cartella.)

## 9. Chiudere il programma

CCTrayTool viene chiuso tramite la voce di menu "Esci". In questo modo viene ripristinato automaticamente il normale comportamento di risparmio energetico di Windows e viene salvata la configurazione attuale.

Tutte le finestre il cui pulsante di chiusura è bloccato da CloseGuard riottengono così il proprio pulsante di chiusura.

## 10. Informazioni / Contatti

La versione attualmente installata può essere consultata in qualsiasi momento tramite la voce di menu "Informazioni".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licenza: GNU General Public License, versione 3 o successiva (GPL-3.0-or-later), con una condizione aggiuntiva di attribuzione; vedi i file [LICENSE](../LICENSE) e [NOTICE](../NOTICE).
