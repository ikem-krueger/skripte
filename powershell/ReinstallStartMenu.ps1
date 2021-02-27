Get-AppxPackage Microsoft.Windows.StartMenuExperienceHost | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
Get-AppxPackage Microsoft.Windows.ShellExperienceHost | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
