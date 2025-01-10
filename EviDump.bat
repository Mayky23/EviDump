@echo off

echo *****           **  ****
echo **                  **  **
echo *****  **    ** **  **   **  **  ** ****  **** *****
echo **       ** **  **  **  **   **  ** ** ***  ** ** **
echo *****     **    **  ****     ****** **      ** *****
echo                                                **
echo                                                **
echo ---- By: MARH ------------------------------------

pause

:: Preguntar al usuario la ruta donde desea guardar las evidencias
echo Por favor, introduzca la ruta donde desea guardar las evidencias:
:input_path
set /p evidencia_path=Ruta: 

:: Validar que la ruta no esté vacía
if "%evidencia_path%"=="" (
    echo La ruta no puede estar vacía. Por favor, introduzca una ruta válida.
    goto input_path
)

:: Verificar si la carpeta existe; si no, crearla
if not exist "%evidencia_path%" (
    mkdir "%evidencia_path%"
    echo Carpeta creada: "%evidencia_path%"
) else (
    echo Usando carpeta existente: "%evidencia_path%"
)

:: Obtener la fecha y hora actual para nombrar la carpeta
set current_date=%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%
set current_time=%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set folder_name=Evidencias_%current_date%_%current_time%

:: Crear subcarpeta para las evidencias
mkdir "%evidencia_path%\%folder_name%"
echo Carpeta creada para evidencias: "%evidencia_path%\%folder_name%"

:: Ruta completa donde se encuentran las herramientas
set tools_path=D:\EviDump\recursos\SysinternalsSuite

:: Exportar eventos del sistema
echo Exportando eventos del sistema...
"%tools_path%\PsLoglist.exe" >> "%evidencia_path%\%folder_name%\Eventos_del_sistema.txt"

:: Exportar procesos en ejecución en memoria
echo Exportando procesos en ejecución en memoria...
"%tools_path%\PsList.exe" /accepteula >> "%evidencia_path%\%folder_name%\Procesos.txt"

:: Exportar especificación de procesos en ejecución
echo Exportando especificación de procesos...
tasklist.exe >> "%evidencia_path%\%folder_name%\Procesos_en_uso.txt"

:: Exportar procesos de usuario usando cprocess (corrigiendo nombre de herramienta)
echo Exportando información de procesos de usuario...
"%tools_path%\cprocess.exe" /stext "%evidencia_path%\%folder_name%\Procesos_de_usuarios.txt"

:: Exportar árbol jerárquico de procesos en ejecución
echo Exportando árbol jerárquico de procesos...
"%tools_path%\pslist.exe" -t /accepteula >> "%evidencia_path%\%folder_name%\Proceso_arbol.txt"

:: Exportar dependencias de procesos
echo Exportando dependencias de procesos...
"%tools_path%\listdlls.exe" /accepteula >> "%evidencia_path%\%folder_name%\Procesos_dependencias.txt"

:: Exportar mapa agrupado de puertos y procesos (usando openports.exe)
echo Exportando mapa agrupado de puertos y procesos...
"%tools_path%\openports.exe" -path >> "%evidencia_path%\%folder_name%\Mapa_agrupado_puertos_procesos.txt"

:: Exportar información de manejadores de procesos
echo Exportando información de manejadores de procesos...
"%tools_path%\handle.exe" /accepteula >> "%evidencia_path%\%folder_name%\Procesos_manejadores.txt"

:: Exportar servicios en ejecución
echo Exportando servicios en ejecución...
"%tools_path%\PsService.exe" >> "%evidencia_path%\%folder_name%\Servicios_en_ejecucion.txt"

:: Exportar configuración de interfaces de red
echo Exportando configuración de interfaces de red...
ipconfig /all >> "%evidencia_path%\%folder_name%\Configuracion_red.txt"

:: Exportar consultas DNS
echo Exportando consultas DNS...
ipconfig /displaydns >> "%evidencia_path%\%folder_name%\DNS_consultas.txt"

:: Exportar adaptadores en modo promiscuo
echo Exportando adaptadores en modo promiscuo...
"%tools_path%\promiscdetect.exe" >> "%evidencia_path%\%folder_name%\Adaptadores_promiscuos.txt"

:: Exportar sesión NetBIOS
echo Exportando sesión NetBIOS...
nbtstat -s >> "%evidencia_path%\%folder_name%\Sesion_netbios.txt"

:: Exportar caché NetBIOS
echo Exportando caché NetBIOS...
nbtstat -c >> "%evidencia_path%\%folder_name%\Cache_netbios.txt"

:: Exportar conexiones activas
echo Exportando conexiones activas...
netstat -an >> "%evidencia_path%\%folder_name%\Conexiones_activas.txt"

:: Exportar aplicaciones con puertos abiertos
echo Exportando aplicaciones con puertos abiertos...
netstat -anob > "%evidencia_path%\%folder_name%\Aplicaciones_Puertos_Abiertos.txt"

:: Exportar tabla de enrutamiento
echo Exportando tabla de enrutamiento...
netstat -r >> "%evidencia_path%\%folder_name%\Tabla_rutas.txt"

:: Exportar rutas de red
echo Exportando rutas de red...
route PRINT >> "%evidencia_path%\%folder_name%\Rutas_de_red.txt"

:: Exportar protocolos de red
echo Exportando protocolos de red...
"%tools_path%\urlprotocolview.exe" /stext "%evidencia_path%\%folder_name%\RedProtocolos.txt"

:: Exportar unidades de red mapeadas
echo Exportando unidades de red mapeadas...
net use >> "%evidencia_path%\%folder_name%\Unidades_mapeadas.txt"

:: Exportar carpetas compartidas
echo Exportando carpetas compartidas...
net share >> "%evidencia_path%\%folder_name%\Carpetas_compartidas.txt"

:: Exportar ficheros abiertos
echo Exportando ficheros abiertos...
"%tools_path%\openedfilesview.exe" /stext "%evidencia_path%\%folder_name%\Ficheros_abiertos.txt"

:: Exportar ficheros remotos abiertos
echo Exportando ficheros remotos abiertos...
"%tools_path%\psfile.exe" /accepteula >> "%evidencia_path%\%folder_name%\Ficheros_remotos_abiertos.txt"

:: Exportar usuarios NetBIOS
echo Exportando usuarios NetBIOS...
nbtstat -n >> "%evidencia_path%\%folder_name%\Usuarios_netbios.txt"

:: Exportar usuarios locales y remotos
echo Exportando usuarios locales y remotos...
net users >> "%evidencia_path%\%folder_name%\Usuarios_locales_remotos.txt"

:: Exportar sesiones remotas
echo Exportando sesiones remotas...
net sessions >> "%evidencia_path%\%folder_name%\Usuarios_remotos_sesion.txt"

:: Exportar sesiones activas
echo Exportando sesiones activas...
"%tools_path%\LogonSessions.exe" /accepteula >> "%evidencia_path%\%folder_name%\Sesiones_activas.txt"

:: Exportar usuarios que han iniciado sesión localmente
echo Exportando usuarios que han iniciado sesión localmente...
"%tools_path%\PsLoggedon.exe" /accepteula >> "%evidencia_path%\%folder_name%\Usuarios_inicio_sesion.txt"

:: Exportar SID de usuarios locales
echo Exportando SID de usuarios locales...
"%tools_path%\PsGetSid.exe" >> "%evidencia_path%\%folder_name%\Usuarios_sid.txt"

:: Exportar tiempo de actividad del sistema
echo Exportando tiempo de actividad del sistema...
"%tools_path%\uptime.exe" >> "%evidencia_path%\%folder_name%\Tiempo_encendido.txt"

:: Exportar contenido del portapapeles
echo Exportando contenido del portapapeles...
"%tools_path%\pclip.exe" >> "%evidencia_path%\%folder_name%\Contenido_portapapeles.txt"

:: Exportar información del portapapeles
echo Exportando información del portapapeles...
"%tools_path%\InsideClipboard.exe" /stext "%evidencia_path%\%folder_name%\Portapapeles_info.txt"

echo *******************************
echo **   Proceso  completado.    **
echo *******************************

pause
