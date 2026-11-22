# CCTrayTool – Manual de usuario

[English](../README.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · **Español** · [Français](README.fr.md) · [Polski](README.pl.md) · [Magyar](README.hu.md) · [Русский](README.ru.md)

CCTrayTool es una pequeña herramienta para Windows que se ejecuta como un icono en la bandeja del sistema (abajo a la derecha, junto al reloj). Combina tres funciones útiles en un solo programa:

1. **KeepAwake** – evita que el PC entre en modo de ahorro de energía o que la pantalla se apague
2. **AlwaysOnTop** – mantiene cualquier ventana en primer plano mediante una combinación de teclas
3. **Inicio rápido de herramientas** – inicia programas de uso frecuente directamente desde el menú de la bandeja del sistema

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

La opción de menú "Guardar estado" hace que CCTrayTool recuerde la última configuración de KeepAwake seleccionada y la restaure automáticamente en el siguiente inicio.

Al cerrar CCTrayTool, el comportamiento normal de ahorro de energía de Windows se restaura automáticamente.

## 3. AlwaysOnTop - mantener una ventana en primer plano

La combinación de teclas MAYÚS + ALT + T (predeterminada) mantiene de forma permanente la ventana actualmente activa en primer plano, incluso al hacer clic en otras ventanas. Pulsarla de nuevo anula esta fijación.

Al cambiar el estado, aparece brevemente un pequeño aviso cerca del puntero del ratón que confirma si la ventana ahora "permanece en primer plano" o ha vuelto a la "normalidad". Este aviso se puede activar o desactivar mediante la opción de menú "Mostrar ToolTip".

En el menú "AlwaysOnTop" están disponibles las siguientes opciones:

- **Hotkey activo**: Activa o desactiva por completo la combinación de teclas
- **Cambiar hotkey**: Abre un cuadro de diálogo en el que se puede definir una combinación de teclas personalizada (combinación de Ctrl, Alt, Mayús, Win más una letra, un número o una tecla de función F1-F12)
- **Mostrar ToolTip**: Activa o desactiva el breve aviso en pantalla al cambiar el estado

Nota: El propio escritorio de Windows ("Program Manager") no se puede configurar como "siempre en primer plano". No todas las combinaciones de teclas están libres; algunas ya están reservadas por el sistema u otros programas. En ese caso aparece un aviso y debe elegirse otra combinación.

## 4. Menú de inicio rápido para programas propios

Encima de KeepAwake, el menú de la bandeja muestra la sección "ToolTime": una lista de programas que se pueden iniciar con un solo clic. Las entradas proceden de una carpeta de su PC (véase la sección 5): cada acceso directo (archivo `.lnk`) de esta carpeta se convierte en una entrada de menú y cada subcarpeta en un submenú.

De forma predeterminada ya hay varias herramientas integradas de Windows configuradas, entre ellas:

- Calculadora, Notepad (carpeta "Office")
- Explorer (directamente en el menú principal)
- Símbolo del sistema, Editor del registro, Configuración de red, Panel de control, Monitor de recursos, Monitor de rendimiento, Administrar servicios, Liberador de espacio en disco (carpeta "Sistema")

Los accesos directos cuyo programa no se encuentra en el PC correspondiente no aparecen automáticamente en el menú, por lo que no se produce ningún mensaje de error si falta una herramienta en un sistema.

Algunas entradas (p. ej., Símbolo del sistema, Editor del registro) están configuradas para iniciarse automáticamente con derechos de administrador (en este caso, Windows solicita confirmación mediante el Control de cuentas de usuario).

## 5. Añadir herramientas y carpetas propias

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

## 6. Configuración adicional

En el submenú "Configuración" también están disponibles:

- **Activar ToolTime**: Activa o desactiva por completo toda la sección de inicio rápido de herramientas (véase la sección 4). Si se desactiva, ninguna de sus entradas aparece en el menú de la bandeja, independientemente de lo que haya en la carpeta ToolTime.
- **Abrir carpeta ToolTime**: Abre la carpeta ToolTime en el Explorador de Windows para añadir, renombrar o eliminar accesos directos (véase la sección 5).
- **Recargar herramientas**: Vuelve a leer la carpeta ToolTime y reconstruye el menú. Normalmente no es necesario, ya que los cambios en la carpeta se detectan automáticamente.
- **Activar KeepAwake**: Activa o desactiva por completo toda la sección KeepAwake (véase la sección 2). Si se desactiva, sus entradas desaparecen del menú de la bandeja y se aplica el comportamiento normal de ahorro de energía de Windows.
- **Activar AlwaysOnTop**: Activa o desactiva por completo toda la sección AlwaysOnTop (véase la sección 3). Si se desactiva, sus entradas desaparecen del menú de la bandeja y la combinación de teclas se desactiva.
- **Iniciar automáticamente**: CCTrayTool se iniciará automáticamente al iniciar sesión en Windows a partir de ahora.
- **Crear archivo de registro**: Escribe un registro detallado de todas las acciones en un archivo de registro. Útil para la resolución de problemas, no es necesario en el funcionamiento normal. En el archivo de configuración es la entrada "`UseLog`" de la sección `[Main]`: 1 = activado; 0, una entrada vacía o inexistente o cualquier otro valor = desactivado.
- **Ver archivo de registro**: Abre el archivo de registro actual en el Bloc de notas.
- **Usar iconos grandes**: Muestra los iconos del menú de la bandeja más grandes (32 en lugar de 16 píxeles).
- **Editar archivo de configuración**: Abre el archivo de configuración directamente para su edición (véase la sección 5).

## 7. Ubicaciones de almacenamiento

CCTrayTool guarda sus archivos en el perfil de usuario:

- **Configuración:** `%LocalAppData%\CCTrayTool\CCTrayTool.ini`
- **Archivo de registro:** `%LocalAppData%\CCTrayTool\CCTrayTool.log`
- **Carpeta ToolTime:** `%LocalAppData%\CCTrayTool\ToolTime\`

(La ruta se puede pegar en la barra de direcciones del Explorador de Windows para ir directamente a la carpeta.)

## 8. Cerrar el programa

CCTrayTool se cierra mediante la opción de menú "Salir". Esto restaura automáticamente el comportamiento normal de ahorro de energía de Windows y guarda la configuración actual.

## 9. Acerca de / Contacto

La versión actualmente instalada se puede consultar en cualquier momento mediante la opción de menú "Acerca de".

CCTrayTool - Markus Debus

[info@markus-debus.de](mailto:info@markus-debus.de)

Licencia: GNU General Public License, versión 3 o posterior (GPL-3.0-or-later), con una condición adicional de atribución; véanse los archivos [LICENSE](../LICENSE) y [NOTICE](../NOTICE).
