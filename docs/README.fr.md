# CCTrayTool – Guide d'utilisation

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Español](README.es.md) · **Français** · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool est un petit outil Windows qui s'exécute sous forme d'icône dans la zone de notification (en bas à droite, à côté de l'horloge). Il regroupe trois fonctions utiles en un seul programme :

1. **KeepAwake** – empêche le PC de passer en mode d'économie d'énergie ou l'écran de s'éteindre
2. **AlwaysOnTop** – maintient une fenêtre au premier plan via un raccourci clavier
3. **Démarrage rapide d'outils** – lance directement les programmes fréquemment utilisés depuis le menu de la zone de notification

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

L'option de menu "Enregistrer l'état" permet à CCTrayTool de mémoriser le dernier réglage KeepAwake sélectionné et de le restaurer automatiquement au prochain démarrage.

À la fermeture de CCTrayTool, le comportement normal d'économie d'énergie de Windows est automatiquement rétabli.

## 3. AlwaysOnTop - maintenir une fenêtre au premier plan

Le raccourci clavier MAJ + ALT + T (par défaut) maintient de façon permanente la fenêtre actuellement active au premier plan, même lorsque d'autres fenêtres sont cliquées. Appuyer à nouveau dessus annule cette fixation.

Lors du basculement, une petite notification apparaît brièvement près du pointeur de la souris, confirmant si la fenêtre "reste au premier plan" ou est "revenue à la normale". Cette notification peut être activée ou désactivée via l'option de menu "Afficher l'infobulle".

Le menu "AlwaysOnTop" propose les options suivantes :

- **Raccourci actif**: Active ou désactive complètement le raccourci clavier
- **Modifier le raccourci**: Ouvre une boîte de dialogue permettant de définir un raccourci clavier personnalisé (combinaison de Ctrl, Alt, Maj, Win plus une lettre, un chiffre ou une touche de fonction F1-F12)
- **Afficher l'infobulle**: Active ou désactive la brève notification à l'écran lors du basculement

Remarque : Le bureau Windows lui-même ("Program Manager") ne peut pas être défini sur "toujours au premier plan". Toutes les combinaisons de touches ne sont pas libres : certaines sont déjà réservées par le système ou d'autres programmes. Dans ce cas, un message apparaît et une autre combinaison doit être choisie.

## 4. Menu de démarrage rapide pour vos propres programmes

Au-dessus de KeepAwake, le menu de la zone de notification affiche la section "ToolTime" : une liste de programmes que l'on peut démarrer d'un simple clic. Les entrées proviennent d'un dossier de votre PC (voir section 5) : chaque raccourci (fichier `.lnk`) de ce dossier devient une entrée de menu et chaque sous-dossier devient un sous-menu.

Par défaut, plusieurs outils intégrés de Windows sont déjà configurés, notamment :

- Calculatrice, Notepad (dossier "Office")
- Explorer (directement dans le menu principal)
- Invite de commandes, Éditeur du registre, Paramètres réseau, Panneau de configuration, Moniteur de ressources, Analyseur de performances, Gérer les services, Nettoyage de disque (dossier "Système")

Les raccourcis dont le programme est introuvable sur le PC concerné n'apparaissent automatiquement pas dans le menu - aucun message d'erreur ne s'affiche donc si un outil manque sur un système.

Certaines entrées (p. ex. Invite de commandes, Éditeur du registre) sont configurées pour démarrer automatiquement avec les droits d'administrateur (dans ce cas, Windows demande une confirmation via le Contrôle de compte d'utilisateur).

## 5. Ajouter ses propres outils et dossiers

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

## 6. Autres paramètres

Le sous-menu "Paramètres" propose également :

- **Activer ToolTime**: Active ou désactive entièrement la section de démarrage rapide des outils (voir section 4). Si désactivée, aucune de ses entrées n'apparaît dans le menu de la zone de notification, quel que soit le contenu du dossier ToolTime.
- **Ouvrir le dossier ToolTime**: Ouvre le dossier ToolTime dans l'Explorateur Windows afin d'ajouter, de renommer ou de supprimer des raccourcis (voir section 5).
- **Recharger les outils**: Relit le dossier ToolTime et reconstruit le menu. Normalement inutile, car les modifications du dossier sont détectées automatiquement.
- **Activer KeepAwake**: Active ou désactive entièrement la section KeepAwake (voir section 2). Si désactivée, ses entrées disparaissent du menu de la zone de notification et le comportement normal d'économie d'énergie de Windows s'applique.
- **Activer AlwaysOnTop**: Active ou désactive entièrement la section AlwaysOnTop (voir section 3). Si désactivée, ses entrées disparaissent du menu de la zone de notification et le raccourci clavier est désactivé.
- **Démarrage automatique**: CCTrayTool démarrera désormais automatiquement à l'ouverture de session Windows.
- **Créer un fichier journal**: Écrit un journal détaillé de toutes les actions dans un fichier journal. Utile pour le dépannage, non nécessaire en fonctionnement normal. Dans le fichier de paramètres, il s'agit de l'entrée "`UseLog`" de la section `[Main]` : 1 = activé ; 0, une entrée vide ou absente ou toute autre valeur = désactivé.
- **Afficher le fichier journal**: Ouvre le fichier journal actuel dans le Bloc-notes.
- **Utiliser de grandes icônes**: Affiche les icônes du menu de la zone de notification en plus grand (32 au lieu de 16 pixels).
- **Modifier le fichier de paramètres**: Ouvre directement le fichier de configuration pour modification (voir section 5).

## 7. Emplacements de stockage

CCTrayTool enregistre ses fichiers dans le profil utilisateur :

- **Configuration :** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Fichier journal :** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Dossier ToolTime :** `%LocalAppData%\CCTrayTool\ToolTime\`

(Le chemin peut être collé dans la barre d'adresse de l'Explorateur Windows pour accéder directement au dossier.)

## 8. Fermer le programme

CCTrayTool se ferme via l'option de menu "Quitter". Cela restaure automatiquement le comportement normal d'économie d'énergie de Windows et enregistre la configuration actuelle.

## 9. À propos / Contact

La version actuellement installée peut être consultée à tout moment via l'option de menu "À propos".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licence : GNU General Public License, version 3 ou ultérieure (GPL-3.0-or-later), avec une condition supplémentaire d'attribution ; voir les fichiers [LICENSE](../LICENSE) et [NOTICE](../NOTICE).
