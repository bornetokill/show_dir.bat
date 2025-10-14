Note:- Scripts may be limited in functionality due to folder access issue. Check for permissions before running in case
`icacls "path"` returns errorlevel 5 for access denied. `DIR` does not accurately address this issue and its errorlevel is misleading (1).
```
SYNTAX
"show_dir.bat"   "[path]" options

    options
        v show visible only
        h show hidden only
        d show directories
        f show files
        p page long lists
    options must be combined like Eg. dv
    in any order
Example 1 :- "show_dir.bat" C:\ dh
Example 2 :- "show_dir.bat" "C:\folder 1" fdv
```

```
SYNTAX
"file_counter.bat"   "[path]" options

    options
        v count visible only
        h count hidden only
        d count directories
        f count files
    options must be combined like Eg. dv
    in any order
Example 1 :- "file_counter.bat" C:\ dh
Example 2 :- "file_counter.bat" "C:\folder 1" fdv
```
<b>SAMPLE OUTPUT:</b><br><SUP>
C:\Users\Anil Bapna\Desktop>file_counter.bat .\ dh<br>
:INCLUDES=HIDDEN DIRECTORIES ONLY<br>
1<br>
<br>
C:\Users\Anil Bapna\Desktop>file_counter.bat .\ vd<br>
:INCLUDES=VISIBLE DIRECTORIES<br>
7<br>
<br>
C:\Users\Anil Bapna\Desktop>file_counter.bat .\ fv<br>
:INCLUDES=VISIBLE FILES<br>
20<br>
<br>
