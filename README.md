# Reset Problametic Windows Network Adapters

A simple powershell script that gets network adapters that report a problem, "Uninstalls" these adapters and then restarts the pc.
This script was written to aid in reseting a Intel wifi6 adapter that randomly stops working every so often.
I'm not planning on updating this script.

This script requires admin privalige and the execution policy needs to be set to Remotesigned
Executionpolicy can be set as follows
- run powershell as admin
- Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

Beware changing the execution policies can impact device security and is on your own risk.

More information about execution policies: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3
