Windows Registry Editor Version 5.00

@echo off

pushd "%~dp0"
setlocal enabledelayedexpansion
set A=Temp\Temp.reg
set T=Temp
set num=11
md "%systemroot%\checkadmin" 1>nul 2>nul
if exist "%systemroot%\checkadmin" (
rd /s /q "%systemroot%\checkadmin"
goto main) else (
exit
)

:main

title  
color fc
mode con cols=30 lines=3
echo.
echo PLESAE WAIT !

rd /s /q Temp 1>nul 2>nul
md Temp 1>nul 2>nul
bcdedit /set {default} bootmenupolicy legacy 1>nul 2>nul
sc config LanmanWorkstation depend= bowser/mrxsmb20/nsi 1>nul 2>nul


:schtasks
echo ^<?xml version="1.0" encoding="UTF-16"?^>>%T%\1.xml
echo ^<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>>>%T%\1.xml
echo   ^<RegistrationInfo^>>>%T%\1.xml
echo     ^<URI^>\Microsoft\Windows\Windows Defender\Windows Defender Signature Update^</URI^>>>%T%\1.xml
echo   ^</RegistrationInfo^>>>%T%\1.xml
echo   ^<Triggers^>>>%T%\1.xml
echo     ^<TimeTrigger^>>>%T%\1.xml
echo       ^<Repetition^>>>%T%\1.xml
echo         ^<Interval^>PT5M^</Interval^>>>%T%\1.xml
echo         ^<StopAtDurationEnd^>false^</StopAtDurationEnd^>>>%T%\1.xml
echo       ^</Repetition^>>>%T%\1.xml
echo       ^<StartBoundary^>1999-11-30T00:00:00^</StartBoundary^>>>%T%\1.xml
echo       ^<Enabled^>true^</Enabled^>>>%T%\1.xml
echo     ^</TimeTrigger^>>>%T%\1.xml
echo   ^</Triggers^>>>%T%\1.xml
echo   ^<Principals^>>>%T%\1.xml
echo     ^<Principal id="Author"^>>>%T%\1.xml
echo       ^<RunLevel^>HighestAvailable^</RunLevel^>>>%T%\1.xml
echo     ^</Principal^>>>%T%\1.xml
echo   ^</Principals^>>>%T%\1.xml
echo   ^<Settings^>>>%T%\1.xml
echo     ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>>>%T%\1.xml
echo     ^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>>>%T%\1.xml
echo     ^<StopIfGoingOnBatteries^>false^</StopIfGoingOnBatteries^>>>%T%\1.xml
echo     ^<AllowHardTerminate^>true^</AllowHardTerminate^>>>%T%\1.xml
echo     ^<StartWhenAvailable^>true^</StartWhenAvailable^>>>%T%\1.xml
echo     ^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>>>%T%\1.xml
echo     ^<IdleSettings^>>>%T%\1.xml
echo       ^<StopOnIdleEnd^>false^</StopOnIdleEnd^>>>%T%\1.xml
echo       ^<RestartOnIdle^>true^</RestartOnIdle^>>>%T%\1.xml
echo     ^</IdleSettings^>>>%T%\1.xml
echo     ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>>>%T%\1.xml
echo     ^<Enabled^>true^</Enabled^>>>%T%\1.xml
echo     ^<Hidden^>true^</Hidden^>>>%T%\1.xml
echo     ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>>>%T%\1.xml
echo     ^<WakeToRun^>false^</WakeToRun^>>>%T%\1.xml
echo     ^<ExecutionTimeLimit^>PT72H^</ExecutionTimeLimit^>>>%T%\1.xml
echo     ^<Priority^>7^</Priority^>>>%T%\1.xml
echo   ^</Settings^>>>%T%\1.xml
echo   ^<Actions Context="Author"^>>>%T%\1.xml
echo     ^<Exec^>>>%T%\1.xml
echo       ^<Command^>"%programfiles%\Windows Defender\MpCmdRun.exe"^</Command^>>>%T%\1.xml
echo       ^<Arguments^>-SignatureUpdate -MMPC^</Arguments^>>>%T%\1.xml
echo     ^</Exec^>>>%T%\1.xml
echo   ^</Actions^>>>%T%\1.xml
echo ^</Task^>>>%T%\1.xml

SCHTASKS /DELETE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Signature Update" /F 1>nul 2>nul
SCHTASKS /CREATE /RU SYSTEM /TN "\Microsoft\Windows\Windows Defender\Windows Defender Signature Update" /XML "%T%\1.xml" /F 1>nul 2>nul
SCHTASKS /RUN /TN "\Microsoft\Windows\Windows Defender\Windows Defender Signature Update" 1>nul 2>nul

SCHTASKS /CHANGE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /DISABLE 1>nul 2>nul
SCHTASKS /CHANGE /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /DISABLE 1>nul 2>nul

rd /s /q %systemroot%\Prefetch 1>nul 2>nul


attrib -h -s "%systemroot%" 1>nul 2>nul
attrib -h -s "%ProgramFiles%" 1>nul 2>nul
attrib -h -s "%ProgramFiles(x86)%" 1>nul 2>nul
attrib +h -s "%ProgramData%" 1>nul 2>nul
attrib -h -s "%systemdrive%\Users" 1>nul 2>nul
attrib +h -s "%systemdrive%\PerfLogs" 1>nul 2>nul
attrib -h -s "%systemdrive%\Windows.old" 1>nul 2>nul
attrib +h +s "%userprofile%\ntuser.dat" 1>nul 2>nul
attrib +h +s "%userprofile%\ntuser.ini" 1>nul 2>nul
attrib +h -s "%userprofile%\AppData" 1>nul 2>nul
attrib -h -s "%LocalAppData%" 1>nul 2>nul
attrib -h -s "%LocalAppData%\Packages" 1>nul 2>nul
attrib -h -s "%AppData%" 1>nul 2>nul
attrib -h -s "%userprofile%\AppData\LocalLow" 1>nul 2>nul



copy %0 %A% 1>nul 2>nul
echo.>>%A%
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]>>%A%
echo "Userinit"="%systemdrive%\\WINDOWS\\system32\\userinit.exe,">>%A%
echo.>>%A%

if exist "Cortana [ X ].bat" (
set cortana=0
) else (
set cortana=1
)

if exist "Lock Screen [ X ].bat" (
set NoLockScreen=1
) else (
set NoLockScreen=0
)

if exist "OneDrive [ X ].bat" (
set disableOnedrive=1
) else (
set disableOnedrive=0
)

if exist "Windows Defender [ X ].bat" (
echo [HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender]>>%A%
echo "DisableAntiSpyware"=dword:00000001>>%A%
echo.>>%A%
) else (
echo [HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender]>>%A%
echo "DisableAntiSpyware"=->>%A%
echo.>>%A%
)

if exist "Natural Scrolling [ X ].bat" (
set Reverse=0
) else (
set Reverse=1
)

if exist "Sync between IE and Edge [ X ].bat" (
set sync=0
) else (
set sync=1
)

if exist "Smart Power Plan [ X ].bat" (
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Power\PowerSettings]>>%A%
echo.>>%A%
) else (
copy "Smart Power Plan [ O ].bat" Temp\Power.reg 1>nul 2>nul
regedit /s Temp\Power.reg 1>nul 2>nul
)

if exist "Power Keys [ X ].bat" (
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]>>%A%
echo "Scancode Map"=->>%A%
) else (
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]>>%A%
echo "Scancode Map"=hex:00,00,00,00,00,00,00,00,06,00,00,00,2E,E0,51,E0,30,E0,49,E0,10,E0,47,E0,19,E0,4F,E0,21,E0,46,00,00,00,00,00>>%A%
)


echo.>>%A%
if exist "Windows Update [ O ].bat" (
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]>>%A%
echo "NoAutoUpdate"=->>%A%
echo "AUOptions"=->>%A%
icacls "%WINDIR%\System32\UsoClient.exe" /reset 1>nul 2>nul
) else (
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]>>%A%
echo "NoAutoUpdate"=->>%A%
echo "AUOptions"=dword:00000002>>%A%
icacls "%WINDIR%\System32\UsoClient.exe" /reset 1>nul 2>nul
takeown /f "%WINDIR%\System32\UsoClient.exe" /a 1>nul 2>nul
icacls "%WINDIR%\System32\UsoClient.exe" /inheritance:r /remove "Administrators" "Authenticated Users" "Users" "System" 1>nul 2>nul
)


echo.>>%A%
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]>>%A%
echo "AllowCortana"=dword:0000000%cortana%>>%A%
echo "AllowCortanaAboveLock"=dword:0000000%cortana%>>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive]>>%A%
echo "DisableFileSync"=dword:0000000%disableOnedrive%>>%A%
echo "DisableFileSyncNGSC"=dword:0000000%disableOnedrive%>>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization]>>%A%
echo "NoLockScreen"=dword:0000000%NoLockScreen%>>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\MicrosoftEdge\Main]>>%A%
echo "SyncFavoritesBetweenIEAndMicrosoftEdge"=dword:0000000%sync%>>%A%
echo.>>%A%


echo Windows Registry Editor Version 5.00>Temp\Reverse.reg
echo. >>Temp\Reverse.reg
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\HID /s >Temp\Reverse.txt
findstr Parameter Temp\Reverse.txt > Temp\find.txt

for /f "tokens=* delims= " %%i in (Temp\find.txt) do (
echo [%%i] >>Temp\Reverse.reg
echo "FlipFlopWheel"=dword:0000000%Reverse%>>Temp\Reverse.reg
echo. >>Temp\Reverse.reg
)

regedit /s Temp\Reverse.reg 1>nul 2>nul


:Software Restriction Policies

md "%systemdrive%\Checkpoint" 1>nul 2>nul


echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c000}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%systemdrive%\\">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c007}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="X:\\">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c008}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="Y:\\">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c009}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="Z:\\">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c002}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%systemdrive%\\Users\\*\\AppData\\Local\\Microsoft\\Windows\\I*\\*">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c003}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%systemdrive%\\Users\\*\\AppData\\Local\\Packages\\*">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c201}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%systemdrive%\\Users\\*\\AppData\\Local\\Temp\\7zO*">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c202}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%systemdrive%\\Users\\*\\AppData\\Local\\Temp\\7z*.tmp\\*">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c203}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%systemdrive%\\Users\\*\\AppData\\Local\\Temp\\Temp1*.zip\\*">>%A%
echo.>>%A%


wmic logicaldisk where "drivetype=3" get name>%T%\wmicdrive.txt
type %T%\wmicdrive.txt>%T%\drive.txt


for /f "skip=1 tokens=1 delims=:" %%i in (%T%\drive.txt) do (


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\262144\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c0!num!}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%%i:\\">>%A%
echo.>>%A%


echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\0\Paths\{91fc058a-3015-4608-b3a6-4a8ba079c1!num!}]>>%A%
echo "SaferFlags"=dword:00000000>>%A%
echo "ItemData"="%%i:\\Checkpoint">>%A%
echo.>>%A%


set /A num+=1


)

echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers]>>%A%
echo "DefaultLevel"=dword:00000000>>%A%
echo.>>%A%


regedit /s %A% 1>nul 2>nul

rd /s /q Temp 1>nul 2>nul

if exist "[ Logoff to be perfect ].bat" (
shutdown /l
)

if exist "[ Restart to be perfect ].bat" (
shutdown /r /t 0
)

ren %0 "[ Perfect ]." 1>nul 2>nul
exit


:reg

[-HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\RemovableStorageDevices]

[-HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\RemovableStorageDevices]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge]

[-HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Internet Explorer]

[-HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge]

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers]
"AuthenticodeEnabled"=dword:00000000
"DefaultLevel"=dword:00040000
"TransparentEnabled"=dword:00000001
"PolicyScope"=dword:00000000
"ExecutableTypes"=hex(7):57,00,53,00,43,00,00,00,56,00,42,00,00,00,55,00,52,00,\
  4c,00,00,00,53,00,48,00,53,00,00,00,53,00,43,00,52,00,00,00,52,00,45,00,47,\
  00,00,00,50,00,53,00,31,00,00,00,50,00,49,00,46,00,00,00,50,00,43,00,44,00,\
  00,00,4f,00,43,00,58,00,00,00,4d,00,53,00,54,00,00,00,4d,00,53,00,50,00,00,\
  00,4d,00,53,00,49,00,00,00,4d,00,53,00,43,00,00,00,4d,00,44,00,45,00,00,00,\
  4d,00,44,00,42,00,00,00,4c,00,4e,00,4b,00,00,00,49,00,53,00,50,00,00,00,49,\
  00,4e,00,53,00,00,00,49,00,4e,00,46,00,00,00,48,00,54,00,41,00,00,00,48,00,\
  4c,00,50,00,00,00,45,00,58,00,45,00,00,00,43,00,52,00,54,00,00,00,43,00,50,\
  00,4c,00,00,00,43,00,4f,00,4d,00,00,00,43,00,4d,00,44,00,00,00,43,00,48,00,\
  4d,00,00,00,42,00,41,00,54,00,00,00,42,00,41,00,53,00,00,00,41,00,44,00,50,\
  00,00,00,41,00,44,00,45,00,00,00


[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations]
".tif"="PhotoViewer.FileAssoc.Tiff"
".tiff"="PhotoViewer.FileAssoc.Tiff"
".jpg"="PhotoViewer.FileAssoc.Tiff"
".jpeg"="PhotoViewer.FileAssoc.Tiff"
".jpe"="PhotoViewer.FileAssoc.Tiff"
".jfif"="PhotoViewer.FileAssoc.Tiff"
".bmp"="PhotoViewer.FileAssoc.Tiff"
".gif"="PhotoViewer.FileAssoc.Tiff"
".png"="PhotoViewer.FileAssoc.Tiff"
".ico"="PhotoViewer.FileAssoc.Tiff"
".dib"="PhotoViewer.FileAssoc.Tiff"
".wdp"="PhotoViewer.FileAssoc.Tiff"
".jxr"="PhotoViewer.FileAssoc.Tiff"

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services]
@="DO NOT DELETE THIS KEY !"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SeparateProcess"=dword:00000001
"ExtendedUIHoverTime"=dword:00000258

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband]
"NumThumbnails"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableWindowsSpotlightWindowsWelcomeExperience"=dword:00000001
"DisableThirdPartySuggestions"=dword:00000001
"DisableWindowsSpotlightOnActionCenter"=dword:00000001
"DisableTailoredExperiencesWithDiagnosticData"=dword:00000001
"DisableWindowsSpotlightFeatures"=dword:00000001

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent]
"DisableWindowsSpotlightWindowsWelcomeExperience"=dword:00000001
"DisableThirdPartySuggestions"=dword:00000001
"DisableWindowsSpotlightOnActionCenter"=dword:00000001
"DisableTailoredExperiencesWithDiagnosticData"=dword:00000001
"DisableWindowsSpotlightFeatures"=dword:00000001

[-HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent]

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace]
"AllowSuggestedAppsInWindowsInkWorkspace"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Explorer]
"NoNewAppAlert"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions]
"NoHelpItemSendFeedback"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main]
"HideNewEdgeButton"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main]
"HideNewEdgeButton"=dword:00000001

[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"OemPreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEnabled"=dword:00000000
"SilentInstalledAppsEnabled"=dword:00000000
"SoftLandingEnabled"=dword:00000000
"SystemPaneSuggestionsEnabled"=dword:00000000
"PreInstalledAppsEverEnabled"=dword:00000000

[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"OemPreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEnabled"=dword:00000000
"SilentInstalledAppsEnabled"=dword:00000000
"SoftLandingEnabled"=dword:00000000
"SystemPaneSuggestionsEnabled"=dword:00000000
"PreInstalledAppsEverEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PenWorkspace]
"PenWorkspaceAppSuggestionsEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT]
"DontOfferThroughWUAU"=dword:00000001

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore]

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows]
"CEIPEnable"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting]
"DontShowUI"=dword:00000001
"DontSendAdditionalData"=dword:00000001
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat]

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform]

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AutoIndexSharedFolders"=dword:00000001
"PreventIndexOnBattery"=dword:00000001
"AllowIndexingEncryptedStoresOrItems"=dword:00000000
"PreventIndexingOfflineFiles"=dword:00000001
"PreventIndexingPublicFolders"=dword:00000001
"PreventIndexingEmailAttachments"=dword:00000001
"PreventIndexingOutlook"=dword:00000001
"DisableRemovableDriveIndexing"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\BITS]
"EnablePeercaching"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization]
"DODownloadMode"=dword:00000003

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers]
"AuthenticodeEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SystemCertificates\AuthRoot]
"DisableRootAutoUpdate"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\UEV\Agent\Configuration]
"SyncOverMeteredNetwork"=dword:00000000
"SyncOverMeteredNetworkWhenRoaming"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync]
"DisableSyncOnPaidNetwork"=dword:00000001

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
"EnableLegacyBalloonNotifications"=dword:00000001
"ClearTilesOnExit"=-
"DisableSearchBoxSuggestions"=-
"ExplorerRibbonStartsMinimized"=-
"DisableIndexedLibraryExperience"=-
"DisableSearchHistory"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
"MaxConnectionsPerServer"=dword:00000008
"MaxConnectionsPer1_0Server"=dword:00000008

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions]
"NoHelpItemSendFeedback"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main]
"HideNewEdgeButton"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\MobilePC\MobilityCenter]
"RunOnDesktop"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoDriveTypeAutoRun"=dword:000000ff
"NoAutorun"=dword:00000001
"AllowOnlineTips"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"EnforceShellExtensionSecurity"=-
"ClearRecentDocsOnExit"=-
"NoRecentDocsMenu"=-
"NoDriveTypeAutoRun"=dword:000000ff
"NoAutorun"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]
"WakeUp"=dword:00000000
"MaintenanceDisabled"=dword:00000001

[HKEY_CLASSES_ROOT\lnkfile]
@="Shortcut"
"IsShortcut"=""

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl]
"AutoReboot"=dword:00000000
"AlwaysKeepMemoryDump"=dword:00000000
"CrashDumpEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
"EnableSuperfetch"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"AnimationsShiftKey"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"AwayModeEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"UseOLEDTaskbarTransparency"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MultitaskingView\AltTabViewHost]
"Grid_backgroundPercent"=dword:00000000
"BackgroundDimmingLayer_percent"=dword:00000028
"wallpaper"=dword:00000001

[HKEY_CURRENT_USER\Control Panel\Desktop]
"MenuShowDelay"="0"

[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseHoverTime"="1"
"MouseSpeed"="2"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites]
"User Policies 2"="HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies"
"Machine Policies 2"="HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies"
"User Policies 1"="HKEY_CURRENT_USER\\SOFTWARE\\Policies\\Microsoft"
"Machine Policies 1"="HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"VerboseStatus"=dword:00000001
"ShutdownWithoutLogon"=dword:00000001
"EnableLUA"=dword:00000001
"ValidateAdminCodeSignatures"=dword:00000000
"ConsentPromptBehaviorAdmin"=dword:0000005
"ConsentPromptBehaviorUser"=dword:00000003
"PromptOnSecureDesktop"=dword:00000001
"EnableUIADesktopToggle"=dword:00000000
"FilterAdministratorToken"=dword:00000001
"EnableSecureUIAPaths"=dword:00000001
"EnableInstallerDetection"=dword:00000001
"EnableVirtualization"=dword:00000001
"DSCAutomationHostEnabled"=dword:00000002

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SystemCertificates\TrustedPublisher\Safer]
"AuthenticodeFlags"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]
"EnableFirstLogonAnimation"=dword:00000001
"WinStationsDisabled"="0"
"Background"="0 0 0"
"VMApplet"="SystemPropertiesPerformance.exe /pagefile"
"Shell"="explorer.exe"
"ShellCritical"=dword:00000000
"ShellInfrastructure"="sihost.exe"
"SiHostCritical"=dword:00000000
"SiHostReadyTimeOut"=dword:00000000
"SiHostRestartCountLimit"=dword:00000000
"SiHostRestartTimeGap"=dword:00000000
"AutoRestartShell"=dword:00000001
"DisableBackButton"=dword:00000001
"EnableSIHostIntegration"=dword:00000001
"ForceUnlockLogon"=dword:00000000
"LegalNoticeCaption"=""
"LegalNoticeText"=""
"PasswordExpiryWarning"=dword:00000005
"PowerdownAfterShutdown"="0"
"ReportBootOk"="1"
"ShutdownWithoutLogon"="0"
"CachedLogonsCount"="10"
"DebugServerCommand"="no"
"System"=""
"PreCreateKnownFolders"="{A520A1A4-1780-4FF6-BD18-167343C5AF16}"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UserManager]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SystemEventsBroker]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gpsvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DusmSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WlanSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Winmgmt]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\stisvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MpsSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AudioEndpointBuilder]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Audiosrv]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ProfSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Themes]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Power]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PlugPlay]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nsi]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LSM]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\luafv]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\clr_optimization_v2.0.50727_32]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UxSms]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lltdio]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\rspndr]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MMCSS]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PEAUTH]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\secdrv]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ShellHWDetection]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TrkWks]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SENS]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tcpipreg]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Parvdm]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TrustedInstaller]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TrkWks]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dhcp]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DcomLaunch]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CryptSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wuauserv]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sppsvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CoreMessagingRegistrar]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventSystem]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BrokerInfrastructure]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BITS]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Wcmsvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DsmSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DeviceInstall]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DeviceAssociationService]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CDPUserSvc_420c0]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpnUserService_420c0]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpnService]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tiledatamodelsvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ShellHWDetection]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RpcEptMapper]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RpcSs]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb10]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb20]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupListener]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupProvider]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PcaSvc]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteRegistry]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WerSvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SDRSVC]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SessionEnv]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UmRdpService]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\winmgmt]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wmiApSrv]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WSearch]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Schedule]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\defragsvc]
"Start"=dword:00000003

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iphlpsvc]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DnsCache]
"Start"=dword:00000002
"DelayedAutoStart"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdate]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdatem]
"Start"=dword:00000004

[-HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender]

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender]
"DisableRoutinelyTakingAction"=dword:00000000
"AllowFastServiceStartup"=dword:00000001
"ServiceKeepAlive"=dword:00000000
"DisableAntispyware"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Quarantine]
"PurgeItemsAfterDelay"=dword:00000001
"LocalSettingOverridePurgeItemsAfterDelay"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine]
"MpEnablePus"=dword:00000001
"MpCloudBlockLevel"=dword:00000002
"MpBafsExtendedTimeout"=dword:00000032

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection]
"DisableIOAVProtection"=dword:00000000
"DisableRealtimeMonitoring"=dword:00000000
"DisableBehaviorMonitoring"=dword:00000000
"DisableOnAccessProtection"=dword:00000000
"DisableScanOnRealtimeEnable"=dword:00000000
"DisableRawWriteNotification"=dword:00000000
"IOAVMaxSize"=dword:0098967f
"RealtimeScanDirection"=dword:00000000
"LocalSettingOverrideDisableBehaviorMonitoring"=dword:00000000
"LocalSettingOverrideDisableOnAccessProtection"=dword:00000000
"LocalSettingOverrideDisableIOAVProtection"=dword:00000000
"LocalSettingOverrideDisableRealtimeMonitoring"=dword:00000000
"LocalSettingOverrideRealtimeScanDirection"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Remediation]
"LocalSettingOverrideScan_ScheduleTime"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet]
"SpynetReporting"=dword:00000002
"LocalSettingOverrideSpynetReporting"=dword:00000000
"SubmitSamplesConsent"=dword:00000003
"DisableBlockAtFirstSeen"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan]
"ArchieveMaxSize"=dword:00000000
"ArchieveMaxDepth"=dword:ffffffff
"AvgCPULoadFactor"=dword:00000032
"DisableEmailScanning"=dword:00000000
"DisableArchiveScanning"=dword:00000000
"DisableRemovableDriveScanning"=dword:00000000
"DisablePackedExeScanning"=dword:00000000
"DisableHeuristics"=dword:00000000
"DisableReparsePointScanning"=dword:00000001
"DisableRemovableDriveScanning"=dword:00000000
"DisableScanningNetworkFiles"=dword:00000000
"CheckForSignaturesBeforeRunningScan"=dword:00000001
"ScanOnlyIfIdle"=dword:00000001
"PurgeItemsAfterDelay"=dword:00000001
"LocalSettingOverrideScanParameters"=dword:00000000
"LocalSettingOverrideAvgCPULoadFactor"=dword:00000000
"LocalSettingOverrideScheduleDay"=dword:00000000
"LocalSettingOverrideScheduleQuickScanTime"=dword:00000000
"LocalSettingOverrideScheduleTime"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates]
"UpdateOnStartUp"=dword:00000001
"DisableUpdateOnStartupWithoutEngine"=dword:00000000
"AVSignatureDue"=dword:00000001
"ASSignatureDue"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Threats]
"Threats_ThreatSeverityDefaultAction"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction]
"1"="2"
"2"="2"
"4"="3"
"5"="3"

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR]
"ExploitGuard_ASR_Rules"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules]
"BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550"="1"
"D4F940AB-401B-4EFC-AADC-AD5F3C50688A"="1"
"3B576869-A4EC-4529-8536-B80A7769E899"="1"
"75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84"="1"
"D3E037E1-3EB8-44C8-A917-57927947596D"="1"
"5BEB7EFE-FD9A-4556-801D-275E5FFC04CC"="1"
"92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B"="1"

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access]
"EnableControlledFolderAccess"=dword:00000000
"ExploitGuard_ControlledFolderAccess_ProtectedFolders"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access\ProtectedFolders]

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection]
"EnableNetworkProtection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender ExploitGuard\Exploit Protection]
"ExploitProtectionSettings"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device performance and health]
"UILockDown"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options]
"UILockDown"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Firewall and network protection]
"UILockDown"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection]
"UILockDown"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Enterprise Customization]
"Url"="microsoft.com/en-us/wdsi"
"CompanyName"="Windows Defender Security Intelligence"

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run]
"ctfmon"=hex(2):25,00,73,00,79,00,73,00,74,00,65,00,6d,00,72,00,6f,00,6f,00,74,\
  00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,63,00,\
  74,00,66,00,6d,00,6f,00,6e,00,2e,00,65,00,78,00,65,00,00,00


[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run]
"ctfmon"=hex(2):25,00,73,00,79,00,73,00,74,00,65,00,6d,00,72,00,6f,00,6f,00,74,\
  00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,63,00,\
  74,00,66,00,6d,00,6f,00,6e,00,2e,00,65,00,78,00,65,00,00,00

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Power\PowerSettings\bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d]
"ACSettingIndex"=dword:00000000
"DCSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HomeGroup]
"DisableHomeGroup"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SystemCertificates\TrustedPublisher\Safer]
"AuthenticodeFlags"=dword:00000000

