# Windows 10: Automatische Updates konfigurieren oder deaktivieren
# https://www.windowspro.de/michael-pietroforte/automatische-updates-konfigurieren-deaktivieren-unter-windows-10
#
$AutoUpdatePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" 

#$UpdateValue = 1 # Nie nach Updates suchen (nicht empfohlen)
$UpdateValue = 2 # Nach Updates suchen, aber Zeitpunkt zum Herunterladen und Installieren manuell festlegen
#$UpdateValue = 3 # Updates herunterladen, aber Installation manuell durchführen
#$UpdateValue = 4 # Updates automatisch installieren (empfohlen)

Set-ItemProperty -Path $AutoUpdatePath -Name AUOptions -Value $UpdateValue
