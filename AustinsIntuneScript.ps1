    # Tell Powershell to stop and wait for user confirmation if an error occurrs.
$ErrorActionPreference = "Inquire"


    # First we print out the MAC-address, so that it can be entered in Talon.
    # `select description, macaddress` says which information we want to keep.
    # `where macaddress -ne $null` filters out any device without a MAC-address.
Write-Host "So you can enter them in Talon, here's the computer's MAC addresses:"
Write-Host "(Hint: you probabably want the 'Ethernet' one)"
Get-WmiObject win32_networkadapterconfiguration | select description, macaddress | where macaddress -ne $null
Write-Host
Write-Host


    # Normally Powershell won't let you run remote scripts for security purposes.
    # This command tells powershell to allow this behavior.
    # `-Scope Process` limits this change to the current process (for safety).
    # `-Force` skips the "Press Y to proceed" Prompt so Mike has less to type.
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
Write-Host "Adjusting permission levels... " -NoNewLine
Write-Host "Completed!"
Write-Host "Beginning script execution. Cross 'yer fingers."
Write-Host


    # These commands install 2 things:
    # - something to let us access a script repository named `NuGet` (chocolatey stuff)
    # - and a script named `Get-WindowsAutopiloInfo` from that repository
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Write-Host "Established access to NuGet script repository."
Install-Script -Name Get-WindowsAutopilotInfo -Force
Write-Host "Finished installing 'Get-WindowsAutopiloInfo' script!"
Write-Host


    # Now we run the script.
    # `-GroupTag NTS` tells the script to apply our tag while setting it up.
    # `-Online` tells this to run while the computer is still on.
Write-Host "========================================================="
Write-Host "=== Beginning autopilot configuration for group 'NTS' ==="
Write-Host "========================================================="
Get-WindowsAutopilotInfo -GroupTag NTS -Online
Write-Host "========================================================="
Write-Host "===                     COMPLETED                     ==="
Write-Host "========================================================="
Write-Host


     # Finally, we open the system reset menu, so Mike doesn't need to open it by hand.
Write-Host "Launching System Restore Task."
systemreset
Write-Host "Good luck. And goodbye!"
PAUSE
