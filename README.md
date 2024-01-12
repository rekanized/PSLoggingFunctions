# PSLoggingFunctions
Powershell Logging Functions

## Installation
Add the LoggingFunctions folder to your Powershell Modules Repository!<br>
Default Path for Windows = "C:\Program Files\WindowsPowerShell\Modules"

## How to use example
This logging functions will create a Logs folder if it does no already exist in your root directory!

Normal logg
```
Write-Log -Type UPDATE -Message "Updating user catalog" -Active $True
```

If you want an additional LineBreak
```
Write-Log -Type UPDATE -Message "Updating user catalog" -Active $True -LineBreak
```

This logg function can be used when running external retrievals, pushes or changes and you will recieve a log if something goes wrong.
```
Invoke-TryCatchLog -InfoLog "Retrieving users from Graph API" -LogToFile $True -ScriptBlock {
    Invoke-RestMethod -Method GET -Uri "GraphAPIEndPoint" -Headers $graphAuthenticationHeader
}
```