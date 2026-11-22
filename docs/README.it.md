# CCTrayTool – Manuale d'uso

[English](../README.md) · [Deutsch](README.de.md) · **Italiano** · [Español](README.es.md) · [Français](README.fr.md) · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool è un piccolo strumento per Windows che viene eseguito come icona nell'area di notifica (in basso a destra, accanto all'orologio). Riunisce tre funzioni utili in un unico programma:

1. **KeepAwake** – impedisce che il PC entri in modalità di risparmio energetico o che lo schermo si spenga
2. **AlwaysOnTop** – mantiene una finestra qualsiasi sempre in primo piano tramite una combinazione di tasti
3. **Avvio rapido strumenti** – avvia i programmi usati più spesso direttamente dal menu dell'area di notifica

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

La voce di menu "Salva stato" fa sì che CCTrayTool memorizzi l'ultima impostazione KeepAwake selezionata e la ripristini automaticamente al successivo avvio.

Alla chiusura di CCTrayTool, il normale comportamento di risparmio energetico di Windows viene ripristinato automaticamente.

## 3. AlwaysOnTop - mantenere una finestra in primo piano

La combinazione di tasti MAIUSC + ALT + T (predefinita) mantiene permanentemente in primo piano la finestra attualmente attiva, anche quando si fa clic su altre finestre. Premendola di nuovo si annulla questo blocco.

Al momento del cambio, vicino al puntatore del mouse compare brevemente un piccolo avviso che conferma se la finestra ora "rimane in primo piano" oppure è "tornata normale". Questo avviso può essere attivato o disattivato tramite la voce di menu "Mostra ToolTip".

Nel menu "AlwaysOnTop" sono disponibili le seguenti opzioni:

- **Hotkey attivo**: Attiva o disattiva completamente la combinazione di tasti
- **Cambia hotkey**: Apre una finestra di dialogo in cui è possibile impostare una combinazione di tasti personalizzata (combinazione di Ctrl, Alt, Maiusc, Win più una lettera, un numero o un tasto funzione F1-F12)
- **Mostra ToolTip**: Attiva o disattiva il breve avviso a schermo al momento del cambio

Nota: Il desktop di Windows stesso ("Program Manager") non può essere impostato su "sempre in primo piano". Non tutte le combinazioni di tasti sono libere: alcune sono già occupate dal sistema o da altri programmi. In questo caso viene visualizzato un avviso ed è necessario scegliere un'altra combinazione.

## 4. Menu di avvio rapido per programmi personalizzati

Sopra KeepAwake, il menu dell'area di notifica mostra la sezione "ToolTime": un elenco di programmi che si avviano con un solo clic. Le voci provengono da una cartella del PC (vedi sezione 5): ogni collegamento (file `.lnk`) in questa cartella diventa una voce di menu e ogni sottocartella diventa un sottomenu.

Per impostazione predefinita sono già configurati alcuni strumenti integrati di Windows, tra cui:

- Calcolatrice, Notepad (cartella "Office")
- Explorer (direttamente nel menu principale)
- Prompt dei comandi, Editor del Registro di sistema, Impostazioni di rete, Pannello di controllo, Monitor risorse, Monitor prestazioni, Gestisci servizi, Pulizia disco (cartella "Sistema")

I collegamenti il cui programma non viene trovato sul rispettivo PC non compaiono automaticamente nel menu: non viene quindi visualizzato alcun messaggio di errore se uno strumento manca su un sistema.

Alcune voci (ad es. Prompt dei comandi, Editor del Registro di sistema) sono configurate per avviarsi automaticamente con privilegi di amministratore (in questo caso Windows chiede conferma tramite il Controllo account utente).

## 5. Aggiungere strumenti e cartelle personalizzati

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

## 6. Altre impostazioni

Nel sottomenu "Impostazioni" sono inoltre disponibili:

- **Attiva ToolTime**: Attiva o disattiva completamente l'intera sezione di avvio rapido degli strumenti (vedi sezione 4). Se disattivata, nessuna delle sue voci compare nel menu dell'area di notifica, indipendentemente da ciò che si trova nella cartella ToolTime.
- **Apri cartella ToolTime**: Apre la cartella ToolTime in Esplora file, per aggiungere, rinominare o rimuovere collegamenti (vedi sezione 5).
- **Ricarica strumenti**: Rilegge la cartella ToolTime e ricostruisce il menu. Normalmente non è necessario, poiché le modifiche nella cartella vengono rilevate automaticamente.
- **Attiva KeepAwake**: Attiva o disattiva completamente l'intera sezione KeepAwake (vedi sezione 2). Se disattivata, le sue voci scompaiono dal menu dell'area di notifica e si applica il normale comportamento di risparmio energetico di Windows.
- **Attiva AlwaysOnTop**: Attiva o disattiva completamente l'intera sezione AlwaysOnTop (vedi sezione 3). Se disattivata, le sue voci scompaiono dal menu dell'area di notifica e la combinazione di tasti viene disattivata.
- **Avvio automatico**: CCTrayTool si avvierà automaticamente in futuro all'accesso a Windows.
- **Crea file di log**: Scrive un registro dettagliato di tutte le azioni in un file di log. Utile per la risoluzione dei problemi, non necessario nel funzionamento normale. Nel file di configurazione è la voce "`UseLog`" nella sezione `[Main]`: 1 = attivo; 0, una voce vuota o mancante o qualsiasi altro valore = disattivato.
- **Visualizza file di log**: Apre il file di log corrente in Blocco note.
- **Usa icone grandi**: Visualizza le icone nel menu dell'area di notifica più grandi (32 invece di 16 pixel).
- **Modifica file di configurazione**: Apre direttamente il file di configurazione per la modifica (vedi sezione 5).

## 7. Percorsi di archiviazione

CCTrayTool salva i propri file nel profilo utente:

- **Configurazione:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **File di log:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Cartella ToolTime:** `%LocalAppData%\CCTrayTool\ToolTime\`

(Il percorso può essere incollato nella barra degli indirizzi di Esplora risorse per accedere direttamente alla cartella.)

## 8. Chiudere il programma

CCTrayTool viene chiuso tramite la voce di menu "Esci". In questo modo viene ripristinato automaticamente il normale comportamento di risparmio energetico di Windows e viene salvata la configurazione attuale.

## 9. Informazioni / Contatti

La versione attualmente installata può essere consultata in qualsiasi momento tramite la voce di menu "Informazioni".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licenza: GNU General Public License, versione 3 o successiva (GPL-3.0-or-later), con una condizione aggiuntiva di attribuzione; vedi i file [LICENSE](../LICENSE) e [NOTICE](../NOTICE).
