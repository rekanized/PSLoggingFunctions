Simple and Easy Powershell Logging Functions

# Installation
```powershell 
Install-Module -Name PSLoggingFunctions
```

# Offline Installation
Just run the OfflineInstallation.ps1<br>
PS: You need to download all the files into the same directory and then run the script, they will then be copied to the Users PSModuleDirectory.

# Example of log
2024-01-17 09:32:04.096 - USER: myuser - GET - Retrieving data<br>
2024-01-17 09:32:04.306 - USER: myuser - WARNING - You ran into an error when trying to: Retrieving data<br>
2024-01-17 09:32:04.317 - USER: myuser - ERROR - The remote server returned an error: (403) Forbidden.

# How to use example
These logging functions will create a Logs folder if it does no already exist in your root directory!

## Normal log
```powershell
Write-Log -Type UPDATE -Message "Updating user catalog" -Active $True
```

## If you only want to add a LineBreak
```powershell
Write-Log -LineBreak -Active $True
```

## This log function is a wrapper for a Try Catch
Whatever you put within the ScriptBlock will run and if it gives you an error.<br>You will then receive the error message both in the Log file and in the CLI.
```powershell
Invoke-TryCatchLog -InfoLog "Retrieving users from Graph API" -LogToFile $True -ScriptBlock {
    Invoke-RestMethod -Method GET -Uri "GraphAPIEndPoint" -Headers $graphAuthenticationHeader
}
```
