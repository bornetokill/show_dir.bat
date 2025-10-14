@echo off

if "%~1" NEQ "" goto :continue
echo:missing 1st arg 
goto :eof
:continue
set "args=%~1"
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
if "%~2"=="" set "file_path=.\"&goto validate
echo %2|find /i "*"&&(set "file_path=%~2"&goto validate)
echo %2|find /i "?"&&(set "file_path=%~2"&goto validate)
if exist %2 set "file_path=%~2"&goto validate
if not exist %2 call :seterror 9009&echo:invalid path&goto :eof
goto :eof
:validate
if %directory%==1 if %file%==1 (set all=1) else (set all=0)
if %all%==1 if %visible%==1 (goto visible_all)
if %all%==1 if %hidden%==1 (goto hidden_all) else (goto not_hidden_all)
if %file%==1 if %visible%==1 goto visible_files
if %directory%==1 if %visible%==1 goto visible_directory
if %directory%==1 if %hidden%==1 (goto hidden_directory) else (goto not_hidden_directory)
if %file%==1 if %hidden%==1 (goto hidden_files) else (goto not_hidden_files)
:visible_all
echo::INCLUDES=VISIBLE FILES, VISIBLE DIRECTORIES
dir /b /a-h "%file_path%" %_prompt% 2>NUL
goto :eof
:visible_files
echo::INCLUDES=VISIBLE FILES
dir /b /a-d-h "%file_path%" %_prompt% 2>NUL
goto :eof
:visible_directory
echo::INCLUDES=VISIBLE DIRECTORIES
dir /b /ad-h "%file_path%" %_prompt% 2>NUL
goto :eof
:hidden_all
echo::INCLUDES=HIDDEN FILES, HIDDEN DIRECTORIES
dir /b /ah "%file_path%" %_prompt% 2>NUL
goto :eof
:not_hidden_all
echo::INCLUDES=ALL FILES, ALL DIRECTORIES;
dir /b /ad "%file_path%" %_prompt% 2>NUL
set temp_error=%errorlevel%
if "%_prompt%"=="/p" echo|set/p=Press any key to continue . . .&Pause >NUL&echo:
dir /b /a-d "%file_path%" %_prompt% 2>NUL
if %errorlevel%==1 if %temp_error%==0 call :seterror 0
goto :eof
:hidden_directory
echo::INCLUDES=HIDDEN DIRECTORIES ONLY
dir /b /ahd "%file_path%" %_prompt% 2>NUL
goto :eof
:not_hidden_directory
echo::INCLUDES=ALL DIRECTORIES
dir /b /ad "%file_path%" %_prompt% 2>NUL
goto :eof
:hidden_files
echo::INCLUDES=HIDDEN FILES ONLY
dir /b /a-dh "%file_path%" %_prompt% 2>NUL
goto :eof
:not_hidden_files
echo::INCLUDES=ALL FILES
dir /b /a-d "%file_path%" %_prompt% 2>NUL
goto :eof
:seterror
exit /b %~1