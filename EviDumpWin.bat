@echo off

echo 888888 Yb    dP 88 8888b.  88   88 8b    d8 88""Yb Yb        dP 88 88b 88 
echo 88__    Yb  dP  88  8I  Yb 88   88 88b  d88 88__dP  Yb  db  dP  88 88Yb88 
echo 88""     YbdP   88  8I  dY Y8   8P 88YbdP88 88"""    YbdPYbdP   88 88 Y88 
echo 888888    YP    88 8888Y"  `YbodP' 88 YY 88 88        YP  YP    88 88  Y8 
echo
echo ---- By: MARH -----------------------------------------------------------
pause

:: Preguntar al usuario la ruta donde desea guardar las evidencias
echo
echo Introduzca la ruta donde desea guardar las evidencias:
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
echo =================================
echo Exportando eventos del sistema...
echo =================================
"%tools_path%\PsLoglist.exe" >> "%evidencia_path%\%folder_name%\Eventos_del_sistema.txt"

:: Exportar procesos en ejecución en memoria
echo ==============================================
echo Exportando procesos en ejecución en memoria...
echo ==============================================
"%tools_path%\PsList.exe" /accepteula >> "%evidencia_path%\%folder_name%\Procesos.txt"

:: Exportar especificación de procesos en ejecución
echo ========================================
echo Exportando especificación de procesos...
echo ========================================
tasklist.exe >> "%evidencia_path%\%folder_name%\Procesos_en_uso.txt"

:: Exportar procesos de usuario usando cprocess (corrigiendo nombre de herramienta)
echo ================================================
echo Exportando información de procesos de usuario...
echo ================================================
"%tools_path%\cprocess.exe" /stext "%evidencia_path%\%folder_name%\Procesos_de_usuarios.txt"

:: Exportar árbol jerárquico de procesos en ejecución
echo ==========================================
echo Exportando árbol jerárquico de procesos...
echo ==========================================
"%tools_path%\pslist.exe" -t /accepteula >> "%evidencia_path%\%folder_name%\Proceso_arbol.txt"

:: Exportar dependencias de procesos
echo =======================================
echo Exportando dependencias de procesos...
echo =======================================
"%tools_path%\listdlls.exe" /accepteula >> "%evidencia_path%\%folder_name%\Procesos_dependencias.txt"

:: Exportar mapa agrupado de puertos y procesos (usando openports.exe)
echo =================================================
echo Exportando mapa agrupado de puertos y procesos...
echo =================================================
"%tools_path%\openports.exe" -path >> "%evidencia_path%\%folder_name%\Mapa_agrupado_puertos_procesos.txt"

:: Exportar información de manejadores de procesos
echo ====================================================
echo Exportando información de manejadores de procesos...
echo ====================================================
"%tools_path%\handle.exe" /accepteula >> "%evidencia_path%\%folder_name%\Procesos_manejadores.txt"

:: Exportar servicios en ejecución
echo ====================================
echo Exportando servicios en ejecución...
echo ====================================
"%tools_path%\PsService.exe" >> "%evidencia_path%\%folder_name%\Servicios_en_ejecucion.txt"

:: Exportar configuración de interfaces de red
echo ================================================
echo Exportando configuración de interfaces de red...
echo ================================================
ipconfig /all >> "%evidencia_path%\%folder_name%\Configuracion_red.txt"

:: Exportar consultas DNS
echo ===========================
echo Exportando consultas DNS...
echo ===========================
ipconfig /displaydns >> "%evidencia_path%\%folder_name%\DNS_consultas.txt"

:: Exportar adaptadores en modo promiscuo
echo ===========================================
echo Exportando adaptadores en modo promiscuo...
echo ===========================================
"%tools_path%\promiscdetect.exe" >> "%evidencia_path%\%folder_name%\Adaptadores_promiscuos.txt"

:: Exportar sesión NetBIOS
echo ============================
echo Exportando sesión NetBIOS...
echo ============================
nbtstat -s >> "%evidencia_path%\%folder_name%\Sesion_netbios.txt"

:: Exportar caché NetBIOS
echo ===========================
echo Exportando caché NetBIOS...
echo ===========================
nbtstat -c >> "%evidencia_path%\%folder_name%\Cache_netbios.txt"

:: Exportar conexiones activas
echo ================================
echo Exportando conexiones activas...
echo ================================
netstat -an >> "%evidencia_path%\%folder_name%\Conexiones_activas.txt"

:: Exportar aplicaciones con puertos abiertos
echo ===============================================
echo Exportando aplicaciones con puertos abiertos...
echo ===============================================
netstat -anob > "%evidencia_path%\%folder_name%\Aplicaciones_Puertos_Abiertos.txt"

:: Exportar tabla de enrutamiento
echo ===================================
echo Exportando tabla de enrutamiento...
echo ===================================
netstat -r >> "%evidencia_path%\%folder_name%\Tabla_rutas.txt"

:: Exportar rutas de red
echo ==========================
echo Exportando rutas de red...
echo ==========================
route PRINT >> "%evidencia_path%\%folder_name%\Rutas_de_red.txt"

:: Exportar protocolos de red
echo ===============================
echo Exportando protocolos de red...
echo ===============================
"%tools_path%\urlprotocolview.exe" /stext "%evidencia_path%\%folder_name%\RedProtocolos.txt"

:: Exportar unidades de red mapeadas
echo ======================================
echo Exportando unidades de red mapeadas...
echo ======================================
net use >> "%evidencia_path%\%folder_name%\Unidades_mapeadas.txt"

:: Exportar carpetas compartidas
echo ==================================
echo Exportando carpetas compartidas...
echo ==================================
net share >> "%evidencia_path%\%folder_name%\Carpetas_compartidas.txt"

:: Exportar ficheros abiertos
echo ===============================
echo Exportando ficheros abiertos...
echo ===============================
"%tools_path%\openedfilesview.exe" /stext "%evidencia_path%\%folder_name%\Ficheros_abiertos.txt"

:: Exportar ficheros remotos abiertos
echo =======================================
echo Exportando ficheros remotos abiertos...
echo =======================================
"%tools_path%\psfile.exe" /accepteula >> "%evidencia_path%\%folder_name%\Ficheros_remotos_abiertos.txt"

:: Exportar usuarios NetBIOS
echo ===============================
echo Exportando usuarios NetBIOS...
echo ===============================
nbtstat -n >> "%evidencia_path%\%folder_name%\Usuarios_netbios.txt"

:: Exportar usuarios locales y remotos
echo ========================================
echo Exportando usuarios locales y remotos...
echo ========================================
net users >> "%evidencia_path%\%folder_name%\Usuarios_locales_remotos.txt"

:: Exportar sesiones remotas
echo ==============================
echo Exportando sesiones remotas...
echo ==============================
net sessions >> "%evidencia_path%\%folder_name%\Usuarios_remotos_sesion.txt"

:: Exportar sesiones activas
echo ==============================
echo Exportando sesiones activas...
echo ==============================
"%tools_path%\LogonSessions.exe" /accepteula >> "%evidencia_path%\%folder_name%\Sesiones_activas.txt"

:: Exportar usuarios que han iniciado sesión localmente
echo =========================================================
echo Exportando usuarios que han iniciado sesión localmente...
echo =========================================================
"%tools_path%\PsLoggedon.exe" /accepteula >> "%evidencia_path%\%folder_name%\Usuarios_inicio_sesion.txt"

:: Exportar SID de usuarios locales
echo =====================================
echo Exportando SID de usuarios locales...
echo =====================================
"%tools_path%\PsGetSid.exe" >> "%evidencia_path%\%folder_name%\Usuarios_sid.txt"

:: Exportar tiempo de actividad del sistema
echo =============================================
echo Exportando tiempo de actividad del sistema...
echo =============================================
"%tools_path%\uptime.exe" >> "%evidencia_path%\%folder_name%\Tiempo_encendido.txt"

:: Exportar contenido del portapapeles
echo ========================================
echo Exportando contenido del portapapeles...
echo ========================================
"%tools_path%\pclip.exe" >> "%evidencia_path%\%folder_name%\Contenido_portapapeles.txt"

:: Exportar información del portapapeles
echo ==========================================
echo Exportando información del portapapeles...
echo ==========================================
"%tools_path%\InsideClipboard.exe" /stext "%evidencia_path%\%folder_name%\Portapapeles_info.txt"

echo ===============================
echo ==   Proceso  completado.    ==
echo ===============================

pause
