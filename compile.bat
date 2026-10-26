@echo off
echo ===================================================
echo   Compiling GrandStay - Hotel Reservation System
echo ===================================================
if not exist "bin" mkdir bin
javac -encoding UTF-8 -d bin -sourcepath src src\com\grandstay\Main.java src\com\grandstay\model\*.java src\com\grandstay\service\*.java src\com\grandstay\util\*.java src\com\grandstay\ui\*.java src\com\grandstay\ui\components\*.java src\com\grandstay\ui\panels\*.java src\com\grandstay\SystemTest.java
if %ERRORLEVEL% equ 0 (
    echo [SUCCESS] Compilation completed successfully!
) else (
    echo [ERROR] Compilation failed!
)
if "%1"=="" pause
