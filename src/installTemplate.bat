@echo off
setlocal

REM Paths for OBS
set "programPath=\bin\64bit\"
set "programName=obs64.exe"
set "shortcutName=OBS - Tangia Record.lnk"
set "folderPath=C:\TangiaCapture"


REM Create the video capture directory
if not exist "%folderPath%" (
    mkdir "%folderPath%"
    echo Folder "%folderPath%" created successfully.
) else (
    echo Folder "%folderPath%" already exists.
)
echo Creating shortcut to "%folderPath%"...
powershell "$s=(New-Object -COMObject WScript.Shell).CreateShortcut('%cd%\Tangia Captures.lnk');$s.TargetPath='%folderPath%';$s.Description='Shortcut to C:\TangiaCapture';$s.Save()"
if %errorlevel% neq 0 (
    echo Failed to create shortcut. Please check the program path and try again.
) else (
    echo Shortcut "%shortcutName%" created successfully in the current directory.
)


REM Create a shortcut to the OBS binary
echo Creating shortcut "%shortcutName%" to "%programPath%"...
powershell "$s=(New-Object -COMObject WScript.Shell).CreateShortcut('%cd%\%shortcutName%');$s.TargetPath='%cd%%programPath%%programName%';$s.WorkingDirectory='%cd%%programPath%';$s.IconLocation='%cd%%programPath%%programName%';$s.Description='OBS Tangia Record';$s.WindowStyle=1;$s.Arguments='';$s.Save();$s=($s.TargetPath + ' -Verb RunAs')"
if %errorlevel% neq 0 (
    echo Failed to create shortcut. Please check the program path and try again.
) else (
    echo Shortcut "%shortcutName%" created successfully in the current directory.
)


REM Unpackage the configuration
set "zipFile=template.zip"
if not exist "%zipFile%" (
    echo File "%zipFile%" not found. Please ensure it is in the current directory.
    exit /b
)
echo Extracting OBS Configuration patch "%zipFile%" to the current directory...
powershell -command "Expand-Archive -Path '%zipFile%' -DestinationPath '.' -Force"
if %errorlevel% neq 0 (
    echo Failed to extract "%zipFile%". Please check the file and try again.
) else (
    echo Extracted "%zipFile%" successfully.
)


endlocal
pause