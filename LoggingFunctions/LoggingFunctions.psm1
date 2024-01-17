function Write-Log {
    param(
        [string]$Message,
        [string]$Path = ".\Logs\log$(get-date -format "yyyyMMdd").txt",
        [ValidateSet("INFO","WARNING","ERROR","DELETE","UPDATE","CREATE","ADD")]
        [string]$Type = "INFO",
        [Parameter(mandatory)]
        [ValidateSet("True","False")]
        [string]$Active,
        [switch]$LineBreak
    )
    if ($Active -eq $true) {
        $DateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
        $LogMessage = "$($DateTime) - USER: $env:USERNAME - $Type - $Message"
        if (Test-Path -Path ".\Logs"){
            if ($LineBreak){
                Add-Content -Path $Path -Value " "
                return ""
            }
            Add-Content -Path $Path -Value $LogMessage
        }
        else {
            Write-Host "Creating new 'Logs' folder within ." -ForegroundColor Yellow
            New-Item -Path . -Name Logs -ItemType Directory -Confirm:$false | Out-Null
            Add-Content -Path $Path -Value $LogMessage
        }
    }
}

function Invoke-TryCatchLog { #Error, Warning and Logging function (Send any command through the scriptblock and it will bounce correct information to you and your logfile!
    param(
        [parameter(mandatory)]
        $InfoLog,
        [parameter(mandatory)]
        $ScriptBlock,
        [parameter(mandatory)]
        [ValidateSet("True","False")]
        $LogToFile,
        [ValidateSet("INFO","WARNING","ERROR","DELETE","UPDATE","CREATE","ADD")]
        $LogType = "INFO"
    )
    try {
        Write-Log -Type $LogType -Message "$InfoLog" -Active $LogToFile
        $Return = Invoke-Command $ScriptBlock
    }
    catch {
        Write-Log -Type WARNING -Message "You ran into an error when trying to: $InfoLog" -Active $LogToFile
        Write-Log -Type ERROR -Message "$($_.Exception.Message) - $($_)" -Active $LogToFile
        Write-Host "You ran into an error when trying to: $InfoLog"
        Write-Host "$($_.Exception.Message) - $($_)" -ForegroundColor Red 
        return $null
    }
    return $Return
}

Export-ModuleMember -Function * -Alias *
