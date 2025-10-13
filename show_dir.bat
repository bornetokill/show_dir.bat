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
Set _prompt=
echo %args%|findstr /vr "^[dDhHfFVvpP][vVfFdDhHpP]*$" >NUL&&(echo:format error&goto :eof) || echo: >NUL
echo %args%|find /i "h"|find /i "v" >NUL&&(echo:cannot have v and h at the same time&goto :eof)
echo %args%|find /i "p" >NUL&&set _prompt=/p
echo %args%|find /i "h" >NUL&&set hidden=1
echo %args%|find /i "v" >NUL&&set visible=1
echo %args%|find /i "f" >NUL&&set file=1
echo %args%|find /i "d" >NUL&&set directory=1
if %directory%==1 if %file%==1 (set all=1) else (set all=0)
if %all%==1 if %visible%==1 (goto visible_all)
if %all%==1 if %hidden%==1 (goto hidden_all) else (goto not_hidden_all)
if %file%==1 if %visible%==1 goto visible_files
if %directory%==1 if %visible%==1 goto visible_directory
if %directory%==1 if %hidden%==1 (goto hidden_directory) else (goto not_hidden_directory)
if %file%==1 if %hidden%==1 (goto hidden_files) else (goto not_hidden_files)
:visible_all
echo::INCLUDES=VISIBLE FILES, VISIBLE DIRECTORIES
dir /b /a-h %1 %_prompt%
goto :eof
:visible_files
echo::INCLUDES=VISIBLE FILES
dir /b /a-d-h %1 %_prompt%
goto :eof
:visible_directory
echo::INCLUDES=VISIBLE DIRECTORIES
dir /b /ad-h %1 %_prompt%
goto :eof
:hidden_all
echo::INCLUDES=HIDDEN FILES, HIDDEN DIRECTORIES
dir /b /ah %1 %_prompt%
goto :eof
:not_hidden_all
echo::INCLUDES=ALL FILES, ALL DIRECTORIES;
dir /b /ad %1 %_prompt%
echo:Press any key to continue . . .&Pause >NUL
dir /b /a-d %1 %_prompt%
goto :eof
:hidden_directory
echo::INCLUDES=HIDDEN DIRECTORIES ONLY
dir /b /ahd %1 %_prompt%
goto :eof
:not_hidden_directory
echo::INCLUDES=ALL DIRECTORIES
dir /b /ad %1 %_prompt%
goto :eof
:hidden_files
echo::INCLUDES=HIDDEN FILES ONLY
dir /b /a-dh %1 %_prompt%
goto :eof
:not_hidden_files
echo::INCLUDES=ALL FILES
dir /b /a-d %1 %_prompt%
goto :eof