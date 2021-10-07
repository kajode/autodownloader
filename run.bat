cd C:\Program Files (x86)\WinSCP

echo (system) script is starting .. 

set /p IP=Enter Server IP:
set /p USER=Enter Username:
set /p PW=Enter Password:
set /p CPTH=Change default location? (C:\Users\%USERNAME%\Desktop\) y=yes n=no:

if "%CPTH%"=="y" (set /p PTH=Enter location:) else (set PTH=C:\Users\%USERNAME%\Desktop\)

:loop

echo (system) searching and downloading plots ..
winscp.com /command ^ "open sftp://%IP%/ -username=%USER% -password=%PW%" ^ "get -delete /home/%USER%/*.plot %PTH%" ^ "exit"
echo (system) waiting 10 sec
timeout /t 10

goto loop

pause