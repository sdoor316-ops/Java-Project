@echo off
echo ===================================================
echo   Running GrandStay System Diagnostic Test Suite
echo ===================================================
java -Dfile.encoding=UTF-8 -cp bin com.grandstay.SystemTest
if "%1"=="" pause
