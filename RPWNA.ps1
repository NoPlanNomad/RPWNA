Function Check-RunAsAdministrator()
{
  #Get current user context
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  
  #Check user is running the script is member of Administrator Group
  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {
       #Create a new Elevated process to Start PowerShell
       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
 
       # Specify the current script path and name as a parameter
       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
 
       #Set the Process to elevated
       $ElevatedProcess.Verb = "runas"
 
       #Start the new elevated process
       [System.Diagnostics.Process]::Start($ElevatedProcess)
 
       #Exit from the current, unelevated, process
       Exit
 
    }
}


Check-RunAsAdministrator
$targets = Get-PnpDevice -Class net |? Status -eq Error | Select FriendlyName,InstanceId
Write-Host "$targets"

ForEach ($target in $targets) {
    Write-Host "Removing $($target.FiendlyName)" -ForeGroundColor Cyan
    $RemoveKey = "HKLM:\SYSTEM\CurrentControlSet\Enum\$($target.InstanceId)"
    Get-Item $RemoveKey | Select-Object -ExpandProperty Property | %{ Remove-ItemProperty -Path $RemoveKey -Name $_ -Verbose }
}
Write-Host "Done removing items. Restarting Computer: Save all your open files before confirming." -ForegroundColor Red
Restart-Computer -Force -Confirm