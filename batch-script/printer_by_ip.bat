@echo off
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

::checks IP of host
echo Network IP: %NetworkIP%

if %NetworkIP% == 172.16.5.204 GOTO MARK1

if %NetworkIP% == 172.16.5.208 GOTO MARK2

if %NetworkIP% == 172.16.5.237 GOTO MARK3


:MARK1
start "" "PATH TO YOUR PRINTER"
GOTO END

:MARK2
start "" "PATH TO YOUR PRINTER"
GOTO END


:MARK3
start "" "PATH TO YOUR PRINTER"
GOTO END

:END




