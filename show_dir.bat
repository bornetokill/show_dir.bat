@echo off

if exist %1 goto continue
(for /f "delims=" %%i in ('if "%args%" NEQ "" echo HELL') do if "%%i"=="HELL" goto continue) 2>NUL
goto :eof
:continue
if "%~2"=="" echo:missing 2nd arg & goto :eof
set "args=%~2"
set hidden=0
set file=0
set directory=0
set all=0
set visible=0
echo %args%|findstr /vr "^[dDhHfFVv][vVfFdDhH]*$" >NUL&&(echo:format error&goto :eof) || echo: >NUL
echo %args%|find /i "h"|find /i "v" >NUL&&(echo:cannot have v and h at the same time&goto :eof)
echo %args%|find /i "h" >NUL&&set hidden=1
echo %args%|find /i "v" >NUL&&set visible=1
echo %args%|find /i "f" >NUL&&set file=1
echo %args%|find /i "d" >NUL&&set directory=1
if %directory%==1 if %file%==1 (set all=1) else (set all=0)
if %all%==1 if %visible%==1 (goto visible_all)
if %all%==1 if %hidden%==1 (goto hidden_all) else (echo TRIGGERED&goto not_hidden_all)
if %file%==1 if %visible%==1 goto visible_files
if %directory%==1 if %visible%==1 goto visible_directory
if %directory%==1 if %hidden%==1 (goto hidden_directory) else (goto not_hidden_directory)
if %file%==1 if %hidden%==1 (goto hidden_files) else (goto not_hidden_files)
:visible_all
echo visible all
dir /b /a-h %1
goto :eof
:visible_files
echo visible files
dir /b /a-d-h %1
goto :eof
:visible_directory
echo visible directories
dir /b /ad-h %1
goto :eof
:hidden_all
echo hidden all
dir /b /ah %1
goto :eof
:not_hidden_all
echo everything
dir /b /ad %1
dir /b /a-d %1
goto :eof
:hidden_directory
echo hidden dir
dir /b /ahd %1
goto :eof
:not_hidden_directory
dir /b /ad %1
goto :eof
:hidden_files
echo hidden files
dir /b /a-dh %1
goto :eof
:not_hidden_files
echo all files
dir /b /a-d %1
goto :eof