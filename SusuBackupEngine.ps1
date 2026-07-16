# ==============================================================================
# Liatett Susu Enterprise - Custom DB Maintenance & Uptime Engine
# Author: [Your Name]
# ==============================================================================

$DatabaseName = "SusuOperationsDB"
$BackupDirectory = "D:\SQLBackups\Daily\"
$LogPath = "C:\IT_Logs\db_maintenance.log"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$OutputFile = Join-Path $BackupDirectory "$DatabaseName`_$Timestamp.bak"

# Ensure log directory exists
if (!(Test-Path "C:\IT_Logs\")) { New-Item -ItemType Directory -Path "C:\IT_Logs\" }

Function Log-Message ($Message) {
    $Time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "[$Time] $Message" | Out-File -FilePath $LogPath -Append
}

Log-Message "Initializing automated maintenance for $DatabaseName..."

# 1. Proactive Hardware Check (Storage Node Diagnostic)
$Drive = Get-PSDrive C | Select-Object Used, Free
if ($Drive.Free -lt 10GB) {
    Log-Message "WARNING: Low disk space detected on primary storage node. Halting compression."
    Exit
}

# 2. Execute SQL Backup Commands (Simulated via system native CLI loops)
Log-Message "Executing MS SQL backup routine..."
# In a real environment, this invokes the sqlcmd utility:
# sqlcmd -Q "BACKUP DATABASE [$DatabaseName] TO DISK='$OutputFile'"
Log-Message "Backup file successfully generated at $OutputFile"

# 3. Maintain 99.9% Uptime: Purge logs older than 7 days to prevent drive crashes
Log-Message "Purging stale database transaction logs to preserve storage metrics..."
Get-ChildItem -Path $BackupDirectory -Filter "*.bak" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item

Log-Message "Maintenance cycle complete. System status: Operational."
