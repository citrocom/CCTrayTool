# CCTrayTool – Manual de usuario

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · **Español** · [Français](README.fr.md) · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool es una pequeña herramienta para Windows que se ejecuta como un icono en la bandeja del sistema (abajo a la derecha, junto al reloj). Combina cuatro funciones útiles en un solo programa:

1. **KeepAwake** – evita que el PC entre en modo de ahorro de energía o que la pantalla se apague
2. **AlwaysOnTop** – mantiene cualquier ventana en primer plano mediante una combinación de teclas
3. **Inicio rápido de herramientas** – inicia programas de uso frecuente directamente desde el menú de la bandeja del sistema
4. **CloseGuard** – bloquea el botón de cerrar (X) de ventanas seleccionadas, con una combinación de teclas o mediante reglas

Todas las funciones se manejan mediante un menú de clic derecho sobre el icono de la bandeja. No es necesaria ninguna instalación, el programa se puede iniciar directamente.

CCTrayTool admite los idiomas inglés, alemán, italiano, español, francés, polaco, húngaro y ruso. El idioma se establece automáticamente según el idioma del sistema del equipo.

Requisito del sistema: se necesita Windows 10 o posterior de 64 bits. El programa no funciona en Windows de 32 bits.

## 1. Inicio y primer icono

Tras el inicio, aparece un icono en el área de la bandeja de la barra de tareas de Windows. El color del icono muestra de inmediato el estado actual de KeepAwake:

- Blanco = KeepAwake desactivado (comportamiento normal de Windows)
- Rojo = KeepAwake activo para monitores
- Azul = KeepAwake activo para el sistema
- Verde = KeepAwake activo para monitores y sistema

Un clic con el botón derecho del ratón sobre el icono abre el menú con todas las funciones. Si el icono no es visible, conviene revisar el área de "iconos ocultos" (pequeña flecha en la barra de tareas).

Nota: CCTrayTool solo puede iniciarse una vez a la vez. Un segundo inicio no tiene ningún efecto si el programa ya se está ejecutando.

## 2. KeepAwake - impedir el ahorro de energía

En la sección de menú "KeepAwake" se puede seleccionar qué es lo que el PC NO debe hacer mientras CCTrayTool está en ejecución:

- **Monitores y sistema**: Ni la pantalla se apaga ni el PC entra en modo de espera/ ahorro de energía. Ideal para presentaciones o procesos de larga duración en los que la pantalla debe permanecer visible.
- **Monitores**: Solo la pantalla permanece encendida (sin apagado, sin protector de pantalla). El propio PC puede entrar en modo de espera igualmente tras su propio tiempo de espera.
- **Sistema**: El PC no entra en modo de espera/ahorro de energía, pero la pantalla puede apagarse según la configuración de Windows. Útil, por ejemplo, para descargas largas o cálculos en segundo plano.
- **Desactivado**: CCTrayTool no interviene; se aplica el comportamiento normal de ahorro de energía de Windows.

La opción de menú "Guardar estado" del submenú "Configuración" de la sección KeepAwake hace que CCTrayTool recuerde la última configuración de KeepAwake seleccionada y la restaure automáticamente en el siguiente inicio.

Al cerrar CCTrayTool, el comportamiento normal de ahorro de energía de Windows se restaura automáticamente.

## 3. AlwaysOnTop - mantener una ventana en primer plano

La combinación de teclas MAYÚS + ALT + T (predeterminada) mantiene de forma permanente la ventana actualmente activa en primer plano, incluso al hacer clic en otras ventanas. Pulsarla de nuevo anula esta fijación.

Al cambiar el estado, aparece brevemente un pequeño aviso cerca del puntero del ratón que confirma si la ventana ahora "permanece en primer plano" o ha vuelto a la "normalidad". Este aviso se puede activar o desactivar mediante la opción de menú "Mostrar ToolTip".

En el menú "AlwaysOnTop" están disponibles las siguientes opciones:

- **Hotkey activo**: Activa o desactiva por completo la combinación de teclas
- **Configuración**: Submenú (icono de engranaje) con las siguientes entradas:
  - **Cambiar hotkey**: Abre un cuadro de diálogo en el que se puede definir una combinación de teclas personalizada (combinación de Ctrl, Alt, Mayús, Win más una letra, un número o una tecla de función F1-F12)
  - **Mostrar ToolTip**: Activa o desactiva el breve aviso en pantalla al cambiar el estado

Nota: El propio escritorio de Windows ("Program Manager") no se puede configurar como "siempre en primer plano". No todas las combinaciones de teclas están libres; algunas ya están reservadas por el sistema u otros programas. En ese caso aparece un aviso y debe elegirse otra combinación.

## 4. CloseGuard - bloquear el botón de cerrar

CloseGuard protege las ventanas contra un cierre accidental. En las ventanas que usted elija, bloquea el botón de cerrar (la "X" de la esquina superior derecha de la ventana): el botón aparece desactivado y hacer clic en él no hace nada. Es útil para programas que tienen que seguir ejecutándose o para ventanas que se cierran por error una y otra vez.

Una ventana se puede bloquear de dos maneras:

- **A mano, con una combinación de teclas**: Haga clic en la ventana y pulse CTRL + ALT + X (predeterminada). El botón de cerrar de esta ventana queda bloqueado. Si vuelve a pulsar la combinación, se desbloquea. Una ventana desbloqueada de este modo sigue libre, aunque coincida con una regla, hasta que se cierre. Un breve aviso confirma cada cambio. El bloqueo dura hasta que la ventana se cierra o se desbloquea.
- **Automáticamente, con reglas**: Haga clic en la ventana y pulse CTRL + ALT + MAYÚS + X (predeterminada). CCTrayTool guarda en el archivo de reglas una regla formada por el título y la clase de la ventana y bloquea la ventana. A partir de ese momento, cada ventana que coincida con la regla se bloquea automáticamente en cuanto aparece, también después de reiniciar el programa o CCTrayTool.

En el menú de la bandeja, la sección "CloseGuard" ofrece estas entradas:

- **Bloquear/desbloquear el botón de cerrar de la ventana activa**: Hace lo mismo que la primera combinación de teclas. Mientras el menú de la bandeja está abierto, el foco lo tiene el propio menú; por eso CloseGuard usa la ventana que estaba activa justo antes.
- **Crear regla para la ventana activa**: Hace lo mismo que la segunda combinación de teclas.
- **Mostrar ventanas bloqueadas**: Muestra qué ventanas están bloqueadas en este momento (por regla o a mano, con la clase de la ventana entre corchetes) y cuántas reglas hay.

Debajo, el submenú "Configuración" (icono de engranaje) contiene:

- **Comprobar automáticamente las ventanas nuevas**: Activado: CloseGuard vigila de forma continua y bloquea cada ventana nueva que coincida con una regla. Desactivado: las ventanas nuevas no se bloquean automáticamente.
- **Comprobar las ventanas abiertas al iniciar**: Activado: las ventanas que ya están abiertas cuando se inicia CCTrayTool se comparan de inmediato con las reglas. Desactivado: estas ventanas no se tocan; solo se comprueban las que se abran más tarde.
- **Minimizar la ventana al hacer clic en la X bloqueada**: Activado: un clic en el botón de cerrar atenuado minimiza la ventana en lugar de no hacer nada. Como con un botón real, la ventana solo se minimiza si el botón del ratón se suelta también sobre la X; pulsar el botón y desplazarse fuera cancela el clic. Desactivado (predeterminado): un clic no hace nada.
- **Cambiar hotkey: bloquear/desbloquear** / **Cambiar hotkey: crear regla**: Abre el mismo cuadro de diálogo que en AlwaysOnTop para definir otra combinación de teclas. Se rechaza una combinación que ya use otra función de CCTrayTool.
- **Editar reglas...**: Abre el archivo de reglas en el Bloc de notas (véase más abajo). Tras guardar y cerrar el Bloc de notas, las reglas modificadas se aplican de inmediato: las ventanas bloqueadas por una regla que ya no coincide se desbloquean y las reglas nuevas se aplican enseguida a las ventanas abiertas.

CloseGuard en su conjunto se activa y desactiva con "Activar CloseGuard" en el menú "Configuración" de la sección "CCTrayTool" (véase la sección 7). Tras una instalación nueva, CloseGuard está desactivado. La primera vez que se activa, un aviso que solo aparece una vez explica qué ventanas no se pueden bloquear.

Reglas (archivo propio `CloseGuardRules.ini`, sección `[Rules]`):

Las reglas no están en el archivo de configuración, sino en un archivo propio: `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`. Se crea automáticamente. Es un archivo Unicode, por lo que también funcionan los títulos de ventana con diéresis, tildes u otros caracteres especiales. El Bloc de notas conserva este formato; si el archivo se edita con otro programa, guárdelo también como Unicode (UTF-16); de lo contrario, los caracteres especiales podrían perderse. Las reglas se vuelven a leer al cerrar el Bloc de notas tras "Editar reglas..." y en cada inicio de CCTrayTool.

Cada línea es una regla con la forma `número=título|clase`. El título es un texto que debe aparecer en algún lugar del título de la ventana. La clase es el nombre técnico del tipo de ventana y debe coincidir exactamente. Las mayúsculas y minúsculas no importan. Una de las dos partes puede estar vacía (el "|" debe permanecer); si ambas están rellenas, deben coincidir las dos. Ejemplos:

- `1=Calculator|`: cada ventana con "Calculator" en el título
- `2=|Notepad`: cada ventana de la clase "Notepad"
- `3=Untitled|Notepad`: ventanas de la clase "Notepad" con "Untitled" en el título

La combinación de teclas "crear regla" usa el título actual completo de la ventana. Si el título cambia (por ejemplo, con el nombre de un documento abierto), acórtelo después con "Editar reglas..." a la parte que no cambia, o deje el título vacío y conserve solo la clase. La clase de una ventana bloqueada se muestra con "Mostrar ventanas bloqueadas". Una regla con título y clase vacíos se ignora; se usan como máximo 200 reglas.

Ajustes en el archivo de configuración (sección `[CloseGuard]`):

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

- `Enabled`: 1 = CloseGuard activado, 0 = desactivado (igual que la opción de menú "Activar CloseGuard"). Predeterminado: 0.
- `HotkeyToggle`: Combinación de teclas para bloquear/desbloquear. `^` = Ctrl, `!` = Alt, `+` = Mayús, `#` = Win, seguido de la tecla. Es más fácil cambiarla con la opción de menú "Cambiar hotkey".
- `HotkeyAddRule`: Combinación de teclas para "crear regla".
- `ApplyOnStartup`: 1 = las ventanas abiertas al iniciar el programa se comparan con las reglas, 0 = no se tocan.
- `AutoApply`: 1 = las ventanas nuevas se comprueban automáticamente, 0 = no.
- `PollInterval`: Con qué frecuencia se comprueban las ventanas, en milisegundos: de 250 a 5000 (predeterminado: 500). Los demás valores se corrigen automáticamente.
- `MinimizeOnClick`: 1 = un clic en el botón de cerrar bloqueado minimiza la ventana, 0 = no hace nada (predeterminado). Equivale a la opción de menú.
- `ClickPollInterval`: Con qué frecuencia se comprueba para ello el botón del ratón, en milisegundos: de 10 a 100 (predeterminado: 30). Un valor menor detecta con más seguridad los clics muy breves; uno mayor necesita menos tiempo de cálculo. Los demás valores se corrigen automáticamente. Para este ajuste no hay opción de menú.
- `ClickGeometryFallback`: 1 = si una ventana con barra de título propia (por ejemplo, Outlook) no comunica su X a Windows, la X se reconoce por su posición (predeterminado). 0 = solo se reconoce una X que la propia ventana comunica.
- `ClickGeometryExtendLeft`: Hasta dónde llega hacia la izquierda el área en la que la X se reconoce por su posición, en porcentaje del ancho de la X: de 0 a 100 (predeterminado: 0). Algunos programas dibujan su X más a la izquierda de lo que indica Windows. Un valor demasiado grande llega hasta el botón de maximizar contiguo.
- `ClickGeometryExtendDown`: Hasta dónde llega hacia abajo esa área, en porcentaje de la altura de la X: de 0 a 100 (predeterminado: 87). Algunos programas dibujan su X más abajo de lo que indica Windows. Misma finalidad y mismos límites que `ClickGeometryExtendLeft`.
- `ClickDebugOverlay`: 1 = muestra en pantalla, como rectángulos de colores y transparentes, las áreas que se usan para reconocer la X: rojo = el área en la que un clic cuenta como clic en la X, azul = el área del botón de cerrar que indica Windows (o, si Windows no indica ninguna, el área de la X que se encontró preguntando a la ventana), verde = el escudo sobre la X (véase `ClickShieldClasses`). Solo para la búsqueda de errores. 0 = desactivado (predeterminado).
- `ClickShieldClasses`: Clases de ventana (separadas por comas) de programas que se cierran solos cuando se suelta el botón del ratón, por ejemplo Edge y Chrome (`Chrome_WidgetWin_1`) y Firefox (`MozillaWindowClass`); ambas son el valor predeterminado. La X de esa ventana se cubre con una ventana casi invisible que recoge el clic, de modo que la ventana ya no se puede cerrar con la X. Vacío = ninguna.

Las dos combinaciones de teclas de CloseGuard y la de AlwaysOnTop deben ser distintas entre sí. De lo contrario, se usan las predeterminadas.

Conviene saber:

- El bloqueo protege de un clic accidental en la X. Según el programa, una ventana aún puede cerrarse por otras vías: con ALT + F4, con "Cerrar ventana" en la barra de tareas, con una orden Salir del menú del propio programa o con el Administrador de tareas.
- Solo se pueden bloquear ventanas con una barra de título normal y menú del sistema. Los programas que dibujan su propia barra de título (muchas aplicaciones modernas, algunos navegadores, aplicaciones de Microsoft Store) pueden conservar una X que funciona aunque CloseGuard indique que la ventana está bloqueada. Si una ventana no tiene menú del sistema, aparece un aviso.
- La primera vez que se activa CloseGuard, un aviso que solo aparece una vez lo recuerda. Que ya se mostró queda anotado en el archivo de configuración ("NoticeShown=1" en la sección `[CloseGuard]`); si se borra la entrada, el aviso vuelve a aparecer.
- Minimizar con un clic: CCTrayTool comprueba el botón del ratón de forma breve y regular (predeterminado: cada 30 ms), y solo mientras haya al menos una ventana bloqueada visible. No utiliza ningún gancho (hook) del ratón, por lo que no puede ralentizar el ratón ni el sistema. En el improbable caso de que un clic muy breve coincida con un momento en que CCTrayTool está ocupado, simplemente no se detecta: la ventana queda como está y su X sigue bloqueada.
- Minimizar con un clic responde al botón principal del ratón (el derecho, si los botones están intercambiados en Windows) y solo a la X de las ventanas bloqueadas. La entrada táctil y con lápiz no se detecta. Si un programa ignora la orden de minimizar, CCTrayTool minimiza la ventana directamente.
- Algunos programas dibujan su propia barra de título (por ejemplo, Outlook). No le indican a Windows dónde está su X, por lo que, para detectar el clic, CCTrayTool calcula la posición de la X en la esquina superior derecha de la ventana (clave INI `ClickGeometryFallback`). En el archivo de registro aparece entonces "recognized by its position".
- Edge, Chrome y otros programas basados en Chromium, así como Firefox, dibujan su propia X y cierran la ventana por sí mismos cuando se suelta el botón del ratón, por lo que el menú de sistema bloqueado no los detiene. Sobre la X de esas ventanas (clave INI `ClickShieldClasses`, valor predeterminado `Chrome_WidgetWin_1,MozillaWindowClass`) CCTrayTool coloca una ventana casi invisible, un escudo. El clic cae en el escudo y el programa nunca lo ve: no ocurre nada, o la ventana se minimiza si minimizar al hacer clic está activado. El escudo sigue a la ventana y desaparece mientras la ventana está minimizada, desbloqueada, a pantalla completa o cubierta por otra ventana sobre su X. Con `ClickDebugOverlay=1` se muestra en verde. Mientras una ventana de esa clase esté visible, el botón del ratón se comprueba cada 10 ms, incluso si minimizar al hacer clic está desactivado. Firefox dibuja su propia barra de título y Windows no comunica la posición de su X; CCTrayTool encuentra entonces la X preguntando a la ventana (archivo de registro: "found by asking the window"). El método alternativo por posición (`ClickGeometryFallback`) solo se usa para ventanas que no comunican su X a Windows, como Outlook y Word; CCTrayTool consulta cada ventana una vez y escribe el resultado en el archivo de registro ("probe of the X").
- Las ventanas de programas que se ejecutan como administrador no se pueden bloquear mientras CCTrayTool no se ejecute también como administrador (una regla de seguridad de Windows). Aparece un aviso.
- El escritorio, la barra de tareas y las ventanas del propio CCTrayTool nunca se bloquean.
- Al desbloquear una ventana, su menú del sistema se restablece al estándar de Windows. Las entradas que el propio programa haya añadido a este menú pueden faltar hasta que se reinicie el programa.
- Un bloqueo dura solo mientras CCTrayTool se está ejecutando: al cerrar el programa o al desactivar CloseGuard, todas las ventanas recuperan su botón de cerrar. Si CCTrayTool se termina a la fuerza (por ejemplo con el Administrador de tareas), las ventanas bloqueadas siguen bloqueadas. En ese caso, pulse en una de ellas la combinación para bloquear/desbloquear (CCTrayTool debe estar de nuevo en ejecución) o cierre la ventana y vuelva a abrirla.

## 5. Menú de inicio rápido para programas propios

Encima de KeepAwake, el menú de la bandeja muestra la sección "ToolTime": una lista de programas que se pueden iniciar con un solo clic. Las entradas proceden de una carpeta de su PC (véase la sección 6): cada acceso directo (archivo `.lnk`) de esta carpeta se convierte en una entrada de menú y cada subcarpeta en un submenú.

De forma predeterminada ya hay varias herramientas integradas de Windows configuradas, entre ellas:

- Calculadora, Notepad (carpeta "Office")
- Explorer (directamente en el menú principal)
- Símbolo del sistema, Editor del registro, Configuración de red, Panel de control, Monitor de recursos, Monitor de rendimiento, Administrar servicios, Liberador de espacio en disco (carpeta "Sistema")

Los accesos directos cuyo programa no se encuentra en el PC correspondiente no aparecen automáticamente en el menú, por lo que no se produce ningún mensaje de error si falta una herramienta en un sistema.

Algunas entradas (p. ej., Símbolo del sistema, Editor del registro) están configuradas para iniciarse automáticamente con derechos de administrador (en este caso, Windows solicita confirmación mediante el Control de cuentas de usuario).

## 6. Añadir herramientas y carpetas propias

Las herramientas del menú de inicio rápido son simplemente accesos directos en una carpeta. Para añadir una herramienta, seleccione en el menú "Configuración" la opción "Abrir carpeta ToolTime" y coloque un acceso directo (archivo `.lnk`) en la carpeta que se abre. CCTrayTool detecta el cambio por sí mismo y actualiza el menú poco después. (Si no ocurre, use "Recargar herramientas" en el menú "Configuración".)

Una forma rápida de crear un acceso directo: arrastre un programa a la carpeta con el botón derecho del ratón y elija "Crear accesos directos aquí".

Carpeta predeterminada: `%LocalAppData%\CCTrayTool\ToolTime` (Se puede definir otra carpeta en el archivo de configuración, véase más abajo.)

Cuando CCTrayTool crea la carpeta ToolTime, coloca también en ella un breve archivo informativo ("`ToolTime_Info.txt`", en el idioma del sistema). Explica brevemente los límites y cómo ordenar las entradas con un número al principio. El menú ignora el archivo; se puede eliminar en cualquier momento.

Cómo la carpeta se convierte en un menú:

- **Acceso directo (`.lnk`)**: se convierte en una entrada de menú. El nombre es el nombre del archivo; el icono es el del acceso directo (o, si no tiene, el del programa al que apunta).
- **Subcarpeta**: se convierte en un submenú. Su icono se puede cambiar como de costumbre en el Explorador de Windows (Propiedades > Personalizar > Cambiar icono).
- **Orden**: Primero las carpetas y luego los accesos directos, cada grupo ordenado alfabéticamente. Para un orden propio, empiece el nombre con dos o tres dígitos y un guion bajo, p. ej. "`01_Notepad.lnk`". El número solo sirve para ordenar y no se muestra.
- **Administrador**: Active "Ejecutar como administrador" en las propiedades del acceso directo (Acceso directo > Opciones avanzadas). Windows solicita confirmación al iniciar la entrada.
- **No se muestran**: Archivos ocultos, archivos que no son accesos directos, accesos directos cuyo programa no existe y carpetas vacías.

Límites: para que el menú siga siendo manejable:

Un menú de la bandeja no se puede desplazar con la rueda del ratón, solo con dos pequeños botones de flecha, y un menú largo empujaría KeepAwake, AlwaysOnTop y la configuración fuera de la vista. Por ello:

- Se muestran como máximo 15 entradas (carpetas y accesos directos juntos) por menú. Este límite se puede cambiar en el archivo de configuración a un valor entre 10 y 20 (véase más abajo).
- Como máximo 3 niveles de menú: el menú ToolTime más dos niveles de submenús. Las carpetas más profundas se ignoran.
- Como máximo 400 entradas en total.

Consejo: agrupe muchas herramientas en subcarpetas en lugar de una lista larga.

Si se supera un límite, no se pierde nada sin avisar:

- Las entradas sobrantes no se muestran. En su lugar, el menú contiene una línea atenuada como "... 3 más no mostradas (límite 15)".
- Aparece una notificación y la sección ToolTime muestra la entrada "(!) ToolTime: se encontraron problemas - haga clic para ver los detalles". Al hacer clic se indica exactamente qué se ignoró y por qué. La misma información se escribe en el archivo de registro (si "Crear archivo de registro" está activado).
- Las carpetas anidadas a demasiada profundidad y los accesos directos que no se pueden leer se notifican del mismo modo.

Ajustes en el archivo de configuración (sección `[ToolTime]`):

```ini
[ToolTime]
Enabled=1
MaxEntries=15
Folder=
```

- `Enabled`: 1 = mostrar ToolTime, 0 = ocultarlo (igual que la opción de menú "Activar ToolTime")
- `MaxEntries`: Número máximo de entradas por menú, de 10 a 20 (predeterminado: 15). Los demás valores se corrigen automáticamente.
- `Folder`: Opcional: ruta de otra carpeta ToolTime. Se permiten variables de entorno como `%USERPROFILE%`. Vacío = carpeta predeterminada. Si la carpeta no existe, se crea.

Para editar el archivo, seleccione en el menú "Configuración" la opción "Editar archivo de configuración". Tras guardar y cerrar el Bloc de notas, CCTrayTool vuelve a leer el archivo, aplica todos los cambios de inmediato (sin reiniciar) y reconstruye el menú.

Restaurar las herramientas predeterminadas: cierre CCTrayTool, elimine la carpeta ToolTime y vuelva a iniciar el programa; las herramientas predeterminadas y el archivo informativo se crean de nuevo.

## 7. Configuración adicional

En el submenú "Configuración" también están disponibles:

- **Activar ToolTime**: Activa o desactiva por completo toda la sección de inicio rápido de herramientas (véase la sección 5). Si se desactiva, ninguna de sus entradas aparece en el menú de la bandeja, independientemente de lo que haya en la carpeta ToolTime.
- **Abrir carpeta ToolTime**: Abre la carpeta ToolTime en el Explorador de Windows para añadir, renombrar o eliminar accesos directos (véase la sección 6).
- **Recargar herramientas**: Vuelve a leer la carpeta ToolTime y reconstruye el menú. Normalmente no es necesario, ya que los cambios en la carpeta se detectan automáticamente.
- **Activar KeepAwake**: Activa o desactiva por completo toda la sección KeepAwake (véase la sección 2). Si se desactiva, sus entradas desaparecen del menú de la bandeja y se aplica el comportamiento normal de ahorro de energía de Windows.
- **Activar AlwaysOnTop**: Activa o desactiva por completo toda la sección AlwaysOnTop (véase la sección 3). Si se desactiva, sus entradas desaparecen del menú de la bandeja y la combinación de teclas se desactiva.
- **Activar CloseGuard**: Activa o desactiva por completo toda la sección CloseGuard (véase la sección 4). Si se desactiva, sus entradas desaparecen del menú de la bandeja, las combinaciones de teclas se desactivan y todas las ventanas bloqueadas recuperan su botón de cerrar.
- **\<Función\> como submenú**: Disponible para ToolTime, KeepAwake, AlwaysOnTop y CloseGuard, siempre justo debajo de la entrada que activa y desactiva la función. Muestra la sección en el menú de la bandeja como un submenú con el nombre de la función en lugar de una lista de entradas, con lo que el menú se acorta. La función sigue trabajando igual. Al cambiar el ajuste, el menú de la bandeja se cierra; basta con abrirlo de nuevo. Mientras la función esté desactivada, la entrada aparece en gris. En el archivo de configuración es la entrada "AsSubmenu" en la sección de la función (`[ToolTime]`, `[KeepAwake]`, `[AlwaysOnTop]`, `[CloseGuard]`): 1 = submenú, 0 = normal (predeterminado).
- **Iniciar automáticamente**: CCTrayTool se iniciará automáticamente al iniciar sesión en Windows a partir de ahora.
- **Crear archivo de registro**: Escribe un registro detallado de todas las acciones en un archivo de registro. Útil para la resolución de problemas, no es necesario en el funcionamiento normal. En el archivo de configuración es la entrada "`UseLog`" de la sección `[Main]`: 1 = activado; 0, una entrada vacía o inexistente o cualquier otro valor = desactivado.
- **Ver archivo de registro**: Abre el archivo de registro actual en el Bloc de notas.
- **Usar iconos grandes**: Muestra los iconos del menú de la bandeja más grandes (32 en lugar de 16 píxeles).
- **Editar archivo de configuración**: Abre el archivo de configuración directamente para su edición (véase la sección 6).

## 8. Ubicaciones de almacenamiento

CCTrayTool guarda sus archivos en el perfil de usuario:

- **Configuración:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Archivo de registro:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Carpeta ToolTime:** `%LocalAppData%\CCTrayTool\ToolTime\`
- **Reglas de CloseGuard:** `%LocalAppData%\CCTrayTool\CloseGuardRules.ini`

(La ruta se puede pegar en la barra de direcciones del Explorador de Windows para ir directamente a la carpeta.)

## 9. Cerrar el programa

CCTrayTool se cierra mediante la opción de menú "Salir". Esto restaura automáticamente el comportamiento normal de ahorro de energía de Windows y guarda la configuración actual.

Todas las ventanas cuyo botón de cerrar está bloqueado por CloseGuard recuperan así su botón de cerrar.

## 10. Acerca de / Contacto

La versión actualmente instalada se puede consultar en cualquier momento mediante la opción de menú "Acerca de".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licencia: GNU General Public License, versión 3 o posterior (GPL-3.0-or-later), con una condición adicional de atribución; véanse los archivos [LICENSE](../LICENSE) y [NOTICE](../NOTICE).
