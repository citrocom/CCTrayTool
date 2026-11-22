# CCTrayTool – Guide d'utilisation

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Español](README.es.md) · **Français** · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool est un petit outil Windows qui s'exécute sous forme d'icône dans la zone de notification (en bas à droite, à côté de l'horloge). Il regroupe quatre fonctions utiles en un seul programme :

1. **KeepAwake** – empêche le PC de passer en mode d'économie d'énergie ou l'écran de s'éteindre
2. **AlwaysOnTop** – maintient une fenêtre au premier plan via un raccourci clavier
3. **Démarrage rapide d'outils** – lance directement les programmes fréquemment utilisés depuis le menu de la zone de notification
4. **CloseGuard** – verrouille le bouton de fermeture (X) de fenêtres choisies, par raccourci clavier ou par des règles

Toutes les fonctions se gèrent via un menu accessible par clic droit sur l'icône de la zone de notification. Aucune installation n'est nécessaire, le programme peut être lancé directement.

CCTrayTool prend en charge les langues anglais, allemand, italien, espagnol, français, polonais, hongrois et russe. La langue est définie automatiquement en fonction de la langue système de l'ordinateur.

Configuration requise : une version 64 bits de Windows 10 ou plus récente est nécessaire. Le programme ne fonctionne pas sous Windows 32 bits.

## 1. Démarrage et première icône

Après le démarrage, une icône apparaît dans la zone de notification de la barre des tâches Windows. La couleur de l'icône indique immédiatement l'état actuel de KeepAwake :

- Blanc = KeepAwake désactivé (comportement normal de Windows)
- Rouge = KeepAwake actif pour les moniteurs
- Bleu = KeepAwake actif pour le système
- Vert = KeepAwake actif pour les moniteurs et le système

Un clic droit sur l'icône ouvre le menu avec toutes les fonctions. Si l'icône n'est pas visible, vérifiez la zone des "icônes masquées" (petite flèche dans la barre des tâches).

Remarque : CCTrayTool ne peut être démarré qu'une seule fois à la fois. Un second démarrage n'a aucun effet si le programme est déjà en cours d'exécution.

## 2. KeepAwake - empêcher la mise en veille

Dans la section de menu "KeepAwake", vous pouvez sélectionner ce que le PC ne doit PAS faire pendant que CCTrayTool est en cours d'exécution :

- **Moniteurs et système**: Ni l'écran ne s'éteint, ni le PC ne passe en veille/mode d'économie d'énergie. Idéal pour les présentations ou les opérations de longue durée où l'écran doit rester visible.
- **Moniteurs**: Seul l'écran reste allumé (pas d'extinction, pas d'économiseur d'écran). Le PC lui-même peut néanmoins passer en veille après son propre délai.
- **Système**: Le PC ne passe pas en veille/mode d'économie d'énergie, mais l'écran peut tout de même s'éteindre selon les paramètres de Windows. Utile, par exemple, pour les téléchargements longs ou les calculs en arrière-plan.
- **Désactivé**: CCTrayTool n'intervient pas ; le comportement normal d'économie d'énergie de Windows s'applique.

L'option de menu "Enregistrer l'état" du sous-menu "Paramètres" de la section KeepAwake permet à CCTrayTool de mémoriser le dernier réglage KeepAwake sélectionné et de le restaurer automatiquement au prochain démarrage.

À la fermeture de CCTrayTool, le comportement normal d'économie d'énergie de Windows est automatiquement rétabli.

## 3. AlwaysOnTop - maintenir une fenêtre au premier plan

Le raccourci clavier MAJ + ALT + T (par défaut) maintient de façon permanente la fenêtre actuellement active au premier plan, même lorsque d'autres fenêtres sont cliquées. Appuyer à nouveau dessus annule cette fixation.

Lors du basculement, une petite notification apparaît brièvement près du pointeur de la souris, confirmant si la fenêtre "reste au premier plan" ou est "revenue à la normale". Cette notification peut être activée ou désactivée via l'option de menu "Afficher l'infobulle".

Le menu "AlwaysOnTop" propose les options suivantes :

- **Raccourci actif**: Active ou désactive complètement le raccourci clavier
- **Paramètres**: Sous-menu (icône d'engrenage) avec les entrées suivantes :
  - **Modifier le raccourci**: Ouvre une boîte de dialogue permettant de définir un raccourci clavier personnalisé (combinaison de Ctrl, Alt, Maj, Win plus une lettre, un chiffre ou une touche de fonction F1-F12)
  - **Afficher l'infobulle**: Active ou désactive la brève notification à l'écran lors du basculement

Remarque : Le bureau Windows lui-même ("Program Manager") ne peut pas être défini sur "toujours au premier plan". Toutes les combinaisons de touches ne sont pas libres : certaines sont déjà réservées par le système ou d'autres programmes. Dans ce cas, un message apparaît et une autre combinaison doit être choisie.

## 4. CloseGuard - verrouiller le bouton de fermeture

CloseGuard protège les fenêtres contre une fermeture accidentelle. Pour les fenêtres que vous choisissez, il verrouille le bouton de fermeture (le "X" en haut à droite de la fenêtre) : le bouton est grisé et un clic dessus ne fait rien. C'est utile pour les programmes qui doivent rester en cours d'exécution ou pour les fenêtres qui sont sans cesse fermées par erreur.

Une fenêtre peut être verrouillée de deux façons :

- **À la main, avec un raccourci clavier**: Cliquez sur la fenêtre, puis appuyez sur CTRL + ALT + X (par défaut). Le bouton de fermeture de cette fenêtre est alors verrouillé. Un nouvel appui sur le raccourci le déverrouille. Une fenêtre déverrouillée ainsi reste libre, même si une règle correspond, jusqu'à sa fermeture. Une brève notification confirme chaque changement. Le verrouillage dure jusqu'à ce que la fenêtre soit fermée ou déverrouillée.
- **Automatiquement, avec des règles**: Cliquez sur la fenêtre, puis appuyez sur CTRL + ALT + MAJ + X (par défaut). CCTrayTool enregistre dans le fichier de règles une règle composée du titre et de la classe de la fenêtre, et verrouille la fenêtre. Dès lors, chaque fenêtre correspondant à la règle est verrouillée automatiquement dès qu'elle apparaît - même après un redémarrage du programme ou de CCTrayTool.

Dans le menu de la zone de notification, la section "CloseGuard" propose ces entrées :

- **Verrouiller/déverrouiller le bouton de fermeture de la fenêtre active**: Fait la même chose que le premier raccourci clavier. Tant que le menu de la zone de notification est ouvert, c'est lui qui a le focus ; CloseGuard utilise donc la fenêtre qui était active juste avant.
- **Créer une règle pour la fenêtre active**: Fait la même chose que le deuxième raccourci clavier.
- **Afficher les fenêtres verrouillées**: Indique quelles fenêtres sont verrouillées en ce moment (par règle ou à la main, avec la classe de la fenêtre entre crochets) et combien de règles existent.

En dessous, le sous-menu "Paramètres" (icône d'engrenage) contient :

- **Vérifier automatiquement les nouvelles fenêtres**: Activé : CloseGuard surveille en permanence et verrouille chaque nouvelle fenêtre correspondant à une règle. Désactivé : les nouvelles fenêtres ne sont pas verrouillées automatiquement.
- **Vérifier les fenêtres ouvertes au démarrage**: Activé : les fenêtres déjà ouvertes au démarrage de CCTrayTool sont comparées immédiatement aux règles. Désactivé : ces fenêtres sont laissées telles quelles ; seules les fenêtres ouvertes plus tard sont vérifiées.
- **Réduire la fenêtre au clic sur le X verrouillé**: Activé : un clic sur le bouton de fermeture grisé réduit la fenêtre au lieu de ne rien faire. Comme avec un vrai bouton, la fenêtre n'est réduite que si le bouton de la souris est aussi relâché sur le X ; appuyer sur le bouton puis s'éloigner annule le clic. Désactivé (par défaut) : un clic ne fait rien.
- **Modifier le raccourci : verrouiller/déverrouiller** / **Modifier le raccourci : créer une règle**: Ouvre la même boîte de dialogue que pour AlwaysOnTop afin de définir un autre raccourci clavier. Une combinaison déjà utilisée par une autre fonction de CCTrayTool est refusée.
- **Modifier les règles...**: Ouvre le fichier de règles dans le Bloc-notes (voir ci-dessous). Après l'enregistrement et la fermeture du Bloc-notes, les règles modifiées sont appliquées aussitôt : les fenêtres verrouillées par une règle qui ne correspond plus sont déverrouillées, et les nouvelles règles s'appliquent tout de suite aux fenêtres ouvertes.

CloseGuard dans son ensemble s'active et se désactive avec "Activer CloseGuard" dans le menu "Paramètres" de la section "CCTrayTool" (voir section 7).

Règles (fichier dédié `CloseGuardRules.ini`, section `[Rules]`) :

Les règles ne sont pas dans le fichier de configuration, mais dans un fichier dédié : `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`. Il est créé automatiquement. C'est un fichier Unicode ; les titres de fenêtre contenant des accents ou d'autres caractères spéciaux fonctionnent donc aussi. Le Bloc-notes conserve ce format ; si le fichier est modifié avec un autre programme, enregistrez-le également en Unicode (UTF-16), sinon des caractères spéciaux peuvent être perdus. Les règles sont relues à la fermeture du Bloc-notes après "Modifier les règles..." et à chaque démarrage de CCTrayTool.

Chaque ligne est une règle de la forme `numéro=titre|classe`. Le titre est un texte qui doit apparaître quelque part dans le titre de la fenêtre. La classe est le nom technique du type de fenêtre et doit correspondre exactement. La casse n'a pas d'importance. L'une des deux parties peut être vide (le "|" doit rester) ; si les deux sont renseignées, les deux doivent correspondre. Exemples :

- `1=Calculator|`: chaque fenêtre dont le titre contient "Calculator"
- `2=|Notepad`: chaque fenêtre de la classe "Notepad"
- `3=Untitled|Notepad`: fenêtres de la classe "Notepad" dont le titre contient "Untitled"

Le raccourci "créer une règle" utilise le titre actuel complet de la fenêtre. Si le titre change (par exemple avec le nom d'un document ouvert), raccourcissez-le ensuite avec "Modifier les règles..." à la partie qui reste identique, ou laissez le titre vide et ne gardez que la classe. La classe d'une fenêtre verrouillée est indiquée par "Afficher les fenêtres verrouillées". Une règle dont le titre et la classe sont vides est ignorée ; 200 règles au maximum sont utilisées.

Paramètres dans le fichier de configuration (section `[CloseGuard]`) :

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

- `Enabled`: 1 = CloseGuard activé, 0 = désactivé (comme l'option de menu "Activer CloseGuard").
- `HotkeyToggle`: Raccourci clavier pour verrouiller/déverrouiller. `^` = Ctrl, `!` = Alt, `+` = Maj, `#` = Win, suivi de la touche. Il est plus simple de le modifier avec l'option de menu "Modifier le raccourci".
- `HotkeyAddRule`: Raccourci clavier pour "créer une règle".
- `ApplyOnStartup`: 1 = les fenêtres ouvertes au démarrage du programme sont comparées aux règles, 0 = elles sont laissées telles quelles.
- `AutoApply`: 1 = les nouvelles fenêtres sont vérifiées automatiquement, 0 = non.
- `PollInterval`: Fréquence de vérification des fenêtres, en millisecondes : de 250 à 5000 (par défaut : 500). Les autres valeurs sont corrigées automatiquement.
- `MinimizeOnClick`: 1 = un clic sur le bouton de fermeture verrouillé réduit la fenêtre, 0 = il ne fait rien (par défaut). Équivaut à l'option de menu.
- `ClickPollInterval`: Fréquence à laquelle le bouton de la souris est vérifié pour cela, en millisecondes : de 10 à 100 (par défaut : 30). Une valeur plus petite détecte plus sûrement les clics très brefs, une valeur plus grande demande moins de temps de calcul. Les autres valeurs sont corrigées automatiquement. Ce réglage n'a pas d'option de menu.
- `ClickGeometryFallback`: 1 = si une fenêtre avec sa propre barre de titre (par exemple Outlook) ne signale pas son X à Windows, le X est reconnu d'après sa position (par défaut). 0 = seul un X que la fenêtre signale elle-même est reconnu.
- `ClickGeometryExtendLeft`: Jusqu'où la zone dans laquelle le X est reconnu d'après sa position s'étend vers la gauche, en pourcentage de la largeur du X : de 0 à 100 (par défaut : 0). Certains programmes dessinent leur X plus à gauche que ne l'indique Windows. Une valeur trop grande empiète sur le bouton d'agrandissement voisin.
- `ClickGeometryExtendDown`: Jusqu'où cette zone s'étend vers le bas, en pourcentage de la hauteur du X : de 0 à 100 (par défaut : 87). Certains programmes dessinent leur X plus bas que ne l'indique Windows. Même objet et mêmes limites que `ClickGeometryExtendLeft`.
- `ClickDebugOverlay`: 1 = affiche à l'écran, sous forme de rectangles colorés et transparents, les zones utilisées pour reconnaître le X : rouge = la zone dans laquelle un clic compte comme un clic sur le X, bleu = la zone du bouton de fermeture indiquée par Windows (ou, si Windows n'en indique aucune, la zone du X trouvée en interrogeant la fenêtre), vert = le bouclier au-dessus du X (voir `ClickShieldClasses`). Uniquement pour le dépannage. 0 = désactivé (par défaut).
- `ClickShieldClasses`: Classes de fenêtres (séparées par des virgules) de programmes qui se ferment eux-mêmes lorsque le bouton de la souris est relâché, par exemple Edge et Chrome (`Chrome_WidgetWin_1`) et Firefox (`MozillaWindowClass`) ; les deux sont la valeur par défaut. Le X d'une telle fenêtre est recouvert par une fenêtre presque invisible qui intercepte le clic ; la fenêtre ne peut alors plus être fermée avec le X. Vide = aucune.

Les deux raccourcis de CloseGuard et celui d'AlwaysOnTop doivent être différents les uns des autres. Sinon, les raccourcis par défaut sont utilisés à la place.

Bon à savoir :

- Le verrouillage protège contre un clic accidentel sur le X. Selon le programme, une fenêtre peut encore être fermée d'autres façons : avec ALT + F4, avec "Fermer la fenêtre" dans la barre des tâches, avec une commande Quitter dans le menu du programme ou avec le Gestionnaire des tâches.
- Seules les fenêtres dotées d'une barre de titre normale et d'un menu système peuvent être verrouillées. Les programmes qui dessinent eux-mêmes leur barre de titre (de nombreuses applications modernes, certains navigateurs, les applications du Microsoft Store) peuvent conserver un X fonctionnel même si CloseGuard signale la fenêtre comme verrouillée. Si une fenêtre n'a aucun menu système, un avis s'affiche.
- Réduction par clic : CCTrayTool vérifie brièvement et régulièrement le bouton de la souris (par défaut : toutes les 30 ms), et seulement tant qu'au moins une fenêtre verrouillée est visible. Il n'utilise aucun hook de souris et ne peut donc ralentir ni la souris ni le système. Dans le cas improbable où un clic très bref tombe à un moment où CCTrayTool est occupé, il n'est simplement pas détecté : la fenêtre reste telle quelle et son X reste verrouillé.
- La réduction par clic réagit au bouton principal de la souris (le droit si les boutons sont inversés dans Windows) et uniquement au X des fenêtres verrouillées. La saisie tactile et au stylet n'est pas détectée. Si un programme ignore la commande de réduction, CCTrayTool réduit la fenêtre directement.
- Certains programmes dessinent eux-mêmes leur barre de titre (par exemple Outlook). Ils n'indiquent pas à Windows où se trouve leur X ; pour la détection du clic, CCTrayTool calcule donc la position du X dans le coin supérieur droit de la fenêtre (clé INI `ClickGeometryFallback`). Le fichier journal indique alors "recognized by its position".
- Edge, Chrome et d'autres programmes basés sur Chromium ainsi que Firefox dessinent eux-mêmes leur X et ferment la fenêtre eux-mêmes lorsque le bouton de la souris est relâché ; le menu système verrouillé ne les arrête donc pas. Au-dessus du X de ces fenêtres (clé INI `ClickShieldClasses`, valeur par défaut `Chrome_WidgetWin_1,MozillaWindowClass`), CCTrayTool place une fenêtre presque invisible, un bouclier. Le clic tombe sur le bouclier et le programme ne le voit jamais : rien ne se passe, ou la fenêtre est réduite si la réduction au clic est activée. Le bouclier suit la fenêtre et disparaît tant que la fenêtre est réduite, déverrouillée, en plein écran ou recouverte par une autre fenêtre au niveau de son X. Avec `ClickDebugOverlay=1`, il s'affiche en vert. Tant qu'une fenêtre de cette classe est visible, le bouton de la souris est vérifié toutes les 10 ms, même si la réduction au clic est désactivée. Firefox dessine lui-même sa barre de titre et Windows ne signale pas la position de son X ; CCTrayTool trouve alors le X en interrogeant la fenêtre (fichier journal : "found by asking the window"). La reconnaissance de secours par la position (`ClickGeometryFallback`) n'est utilisée que pour les fenêtres qui ne signalent pas leur X à Windows, comme Outlook et Word ; CCTrayTool interroge chaque fenêtre une fois et inscrit le résultat dans le fichier journal ("probe of the X").
- Les fenêtres des programmes exécutés en tant qu'administrateur ne peuvent pas être verrouillées tant que CCTrayTool ne s'exécute pas lui-même en tant qu'administrateur (une règle de sécurité de Windows). Un avis s'affiche.
- Le bureau, la barre des tâches et les fenêtres de CCTrayTool lui-même ne sont jamais verrouillés.
- Lorsqu'une fenêtre est déverrouillée, son menu système est rétabli au standard de Windows. Les entrées que le programme avait lui-même ajoutées à ce menu peuvent manquer jusqu'au redémarrage du programme.
- Un verrouillage ne dure que tant que CCTrayTool est en cours d'exécution : à la fermeture du programme ou à la désactivation de CloseGuard, toutes les fenêtres retrouvent leur bouton de fermeture. Si CCTrayTool est arrêté de force (par exemple avec le Gestionnaire des tâches), les fenêtres verrouillées restent verrouillées. Dans ce cas, appuyez dans une telle fenêtre sur le raccourci verrouiller/déverrouiller (CCTrayTool doit de nouveau être en cours d'exécution) ou fermez la fenêtre et rouvrez-la.

## 5. Menu de démarrage rapide pour vos propres programmes

Au-dessus de KeepAwake, le menu de la zone de notification affiche la section "ToolTime" : une liste de programmes que l'on peut démarrer d'un simple clic. Les entrées proviennent d'un dossier de votre PC (voir section 6) : chaque raccourci (fichier `.lnk`) de ce dossier devient une entrée de menu et chaque sous-dossier devient un sous-menu.

Par défaut, plusieurs outils intégrés de Windows sont déjà configurés, notamment :

- Calculatrice, Notepad (dossier "Office")
- Explorer (directement dans le menu principal)
- Invite de commandes, Éditeur du registre, Paramètres réseau, Panneau de configuration, Moniteur de ressources, Analyseur de performances, Gérer les services, Nettoyage de disque (dossier "Système")

Les raccourcis dont le programme est introuvable sur le PC concerné n'apparaissent automatiquement pas dans le menu - aucun message d'erreur ne s'affiche donc si un outil manque sur un système.

Certaines entrées (p. ex. Invite de commandes, Éditeur du registre) sont configurées pour démarrer automatiquement avec les droits d'administrateur (dans ce cas, Windows demande une confirmation via le Contrôle de compte d'utilisateur).

## 6. Ajouter ses propres outils et dossiers

Les outils du menu de démarrage rapide sont de simples raccourcis placés dans un dossier. Pour ajouter un outil, sélectionnez dans le menu "Paramètres" l'option "Ouvrir le dossier ToolTime" et placez un raccourci (fichier `.lnk`) dans le dossier qui s'ouvre. CCTrayTool remarque lui-même la modification et met à jour le menu peu après. (Si ce n'est pas le cas, utilisez "Recharger les outils" dans le menu "Paramètres".)

Pour créer rapidement un raccourci : faites glisser un programme dans le dossier avec le bouton droit de la souris et choisissez "Créer des raccourcis ici".

Dossier par défaut : `%LocalAppData%\CCTrayTool\ToolTime` (Un autre dossier peut être défini dans le fichier de paramètres, voir ci-dessous.)

Lorsque CCTrayTool crée le dossier ToolTime, il y place aussi un court fichier d'information ("`ToolTime_Info.txt`", dans la langue du système). Il explique brièvement les limites et comment trier les entrées à l'aide d'un nombre placé devant le nom. Le menu ignore ce fichier ; il peut être supprimé à tout moment.

Comment le dossier devient un menu :

- **Raccourci (`.lnk`)**: devient une entrée de menu. Le nom est celui du fichier ; l'icône est celle du raccourci (ou, à défaut, celle du programme ciblé).
- **Sous-dossier**: devient un sous-menu. Son icône peut être modifiée comme d'habitude dans l'Explorateur Windows (Propriétés > Personnaliser > Changer d'icône).
- **Ordre**: D'abord les dossiers, puis les raccourcis, chacun trié par ordre alphabétique. Pour un ordre personnalisé, faites commencer le nom par deux ou trois chiffres et un trait de soulignement, p. ex. "`01_Notepad.lnk`". Le nombre ne sert qu'au tri et n'est pas affiché.
- **Administrateur**: Activez "Exécuter en tant qu'administrateur" dans les propriétés du raccourci (Raccourci > Avancé). Windows demande alors une confirmation au démarrage de l'entrée.
- **Non affichés**: Fichiers masqués, fichiers qui ne sont pas des raccourcis, raccourcis dont le programme n'existe pas et dossiers vides.

Limites - pour que le menu reste utilisable :

Un menu de la zone de notification ne peut pas être défilé avec la molette de la souris, uniquement avec deux petits boutons fléchés, et un menu long repousserait KeepAwake, AlwaysOnTop et les paramètres hors de la zone visible. C'est pourquoi :

- Au maximum 15 entrées (dossiers et raccourcis confondus) sont affichées par menu. Cette limite peut être modifiée dans le fichier de paramètres, avec une valeur comprise entre 10 et 20 (voir ci-dessous).
- Au maximum 3 niveaux de menu : le menu ToolTime plus deux niveaux de sous-menus. Les dossiers plus profonds sont ignorés.
- Au maximum 400 entrées au total.

Conseil : regroupez de nombreux outils dans des sous-dossiers plutôt que dans une longue liste.

Si une limite est dépassée, rien n'est perdu sans que vous le sachiez :

- Les entrées en trop ne sont pas affichées. À la place, le menu contient une ligne grisée du type "... 3 autres non affichés (limite 15)".
- Une notification apparaît et la section ToolTime affiche l'entrée "(!) ToolTime : problèmes détectés - cliquer pour les détails". Un clic dessus indique précisément ce qui a été ignoré et pourquoi. Les mêmes informations sont écrites dans le fichier journal (si "Créer un fichier journal" est activé).
- Les dossiers imbriqués trop profondément et les raccourcis qui ne peuvent pas être lus sont signalés de la même manière.

Paramètres dans le fichier de paramètres (section `[ToolTime]`) :

```ini
[ToolTime]
Enabled=1
MaxEntries=15
Folder=
```

- `Enabled`: 1 = afficher ToolTime, 0 = le masquer (comme l'option de menu "Activer ToolTime")
- `MaxEntries`: Nombre maximal d'entrées par menu, de 10 à 20 (par défaut : 15). Les autres valeurs sont corrigées automatiquement.
- `Folder`: Facultatif : chemin d'un autre dossier ToolTime. Les variables d'environnement comme `%USERPROFILE%` sont autorisées. Vide = dossier par défaut. Si le dossier n'existe pas, il est créé.

Pour modifier le fichier, sélectionnez dans le menu "Paramètres" l'option "Modifier le fichier de paramètres". Après avoir enregistré et fermé le Bloc-notes, CCTrayTool relit le fichier, applique immédiatement toutes les modifications (sans redémarrage) et reconstruit le menu.

Rétablir les outils par défaut : quittez CCTrayTool, supprimez le dossier ToolTime et redémarrez le programme - les outils par défaut et le fichier d'information sont recréés.

## 7. Autres paramètres

Le sous-menu "Paramètres" propose également :

- **Activer ToolTime**: Active ou désactive entièrement la section de démarrage rapide des outils (voir section 5). Si désactivée, aucune de ses entrées n'apparaît dans le menu de la zone de notification, quel que soit le contenu du dossier ToolTime.
- **Ouvrir le dossier ToolTime**: Ouvre le dossier ToolTime dans l'Explorateur Windows afin d'ajouter, de renommer ou de supprimer des raccourcis (voir section 6).
- **Recharger les outils**: Relit le dossier ToolTime et reconstruit le menu. Normalement inutile, car les modifications du dossier sont détectées automatiquement.
- **Activer KeepAwake**: Active ou désactive entièrement la section KeepAwake (voir section 2). Si désactivée, ses entrées disparaissent du menu de la zone de notification et le comportement normal d'économie d'énergie de Windows s'applique.
- **Activer AlwaysOnTop**: Active ou désactive entièrement la section AlwaysOnTop (voir section 3). Si désactivée, ses entrées disparaissent du menu de la zone de notification et le raccourci clavier est désactivé.
- **Activer CloseGuard**: Active ou désactive entièrement toute la section CloseGuard (voir section 4). Si elle est désactivée, ses entrées disparaissent du menu de la zone de notification, les raccourcis clavier sont désactivés et toutes les fenêtres verrouillées retrouvent leur bouton de fermeture.
- **Démarrage automatique**: CCTrayTool démarrera désormais automatiquement à l'ouverture de session Windows.
- **Créer un fichier journal**: Écrit un journal détaillé de toutes les actions dans un fichier journal. Utile pour le dépannage, non nécessaire en fonctionnement normal. Dans le fichier de paramètres, il s'agit de l'entrée "`UseLog`" de la section `[Main]` : 1 = activé ; 0, une entrée vide ou absente ou toute autre valeur = désactivé.
- **Afficher le fichier journal**: Ouvre le fichier journal actuel dans le Bloc-notes.
- **Utiliser de grandes icônes**: Affiche les icônes du menu de la zone de notification en plus grand (32 au lieu de 16 pixels).
- **Modifier le fichier de paramètres**: Ouvre directement le fichier de configuration pour modification (voir section 6).

## 8. Emplacements de stockage

CCTrayTool enregistre ses fichiers dans le profil utilisateur :

- **Configuration :** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Fichier journal :** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Dossier ToolTime :** `%LocalAppData%\CCTrayTool\ToolTime\`
- **Règles de CloseGuard :** `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`

(Le chemin peut être collé dans la barre d'adresse de l'Explorateur Windows pour accéder directement au dossier.)

## 9. Fermer le programme

CCTrayTool se ferme via l'option de menu "Quitter". Cela restaure automatiquement le comportement normal d'économie d'énergie de Windows et enregistre la configuration actuelle.

Toutes les fenêtres dont le bouton de fermeture est verrouillé par CloseGuard retrouvent ainsi leur bouton de fermeture.

## 10. À propos / Contact

La version actuellement installée peut être consultée à tout moment via l'option de menu "À propos".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licence : GNU General Public License, version 3 ou ultérieure (GPL-3.0-or-later), avec une condition supplémentaire d'attribution ; voir les fichiers [LICENSE](../LICENSE) et [NOTICE](../NOTICE).
