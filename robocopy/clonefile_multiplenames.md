```bash 
setlocal enabledelayedexpansion
set count=37
for %%F in (*.xlsm) do (
  for /l %%i in (1, 1, %count%) do (
    set num=0%%i
    set num=!num:~-2!
    copy "%%F" "%%~nF_!num!%%~xF"
  )
)
```
