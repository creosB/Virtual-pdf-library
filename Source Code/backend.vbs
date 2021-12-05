Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c backend.bat"
oShell.Run strArgs, 0, false