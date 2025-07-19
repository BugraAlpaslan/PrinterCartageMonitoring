@echo off
echo ===============================================
echo HP PRINTER MONITOR - AUTOMATED SETUP
echo ===============================================
echo.
echo This will create a Windows scheduled task to
echo monitor HP printers twice daily (08:00 and 14:00).
echo.
echo REQUIREMENTS:
echo - Administrator privileges required
echo - PowerShell execution policy will be set
echo - Files must be in C:\PrinterMonitor\
echo.
pause

echo Checking administrator privileges...
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo.
    echo ERROR: Administrator privileges required!
    echo.
    echo SOLUTION:
    echo 1. Right-click this BAT file
    echo 2. Select "Run as administrator"
    echo 3. Run again
    echo.
    pause
    exit /b 1
)

echo Administrator privileges confirmed.
echo.

echo Checking required files...
if not exist "C:\PrinterMonitor\complete_printer_monitor.ps1" (
    echo ERROR: complete_printer_monitor.ps1 not found!
    echo Please ensure all files are in C:\PrinterMonitor\
    pause
    exit /b 1
)

if not exist "setup_scheduler.ps1" (
    echo ERROR: setup_scheduler.ps1 not found!
    echo Please ensure all files are in C:\PrinterMonitor\
    pause
    exit /b 1
)

echo All files found.
echo.
echo Running PowerShell setup script...
powershell -ExecutionPolicy Bypass -File "setup_scheduler.ps1"

echo.
echo ===============================================
echo SETUP COMPLETED
echo ===============================================
echo.
echo VERIFICATION:
echo 1. Press Win + R
echo 2. Type: taskschd.msc
echo 3. Navigate to Task Scheduler Library
echo 4. Find "HPPrinterMonitor" task
echo.
echo The task will run automatically at:
echo - 08:00 (Morning check)
echo - 14:00 (Afternoon check)
echo.
echo Configuration files:
echo - Main script: C:\PrinterMonitor\complete_printer_monitor.ps1
echo - Edit printer IPs and email settings in main script
echo.
pause