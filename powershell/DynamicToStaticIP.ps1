# Save IP-Configuration
$NetIPConfiguration = Get-NetIPConfiguration | Out-String -Stream

# Extract needed variables
$InterfaceIndex = ($NetIPConfiguration | Select-String InterfaceIndex).ToString().Split(":")[1].Trim()
$IPAddress = ($NetIPConfiguration | Select-String IPv4Address).ToString().Split(":")[1].Trim()
$PrefixLength = (Get-NetIPAddress -InterfaceIndex $InterfaceIndex -AddressFamily IPv4  | Out-String -Stream | Select-String PrefixLength).toString().Split(":")[1].Trim()
$DefaultGateway = ($NetIPConfiguration | Select-String IPv4DefaultGateway).ToString().Split(":")[1].Trim()
$ServerAddresses = ($NetIPConfiguration | Select-String DNSServer).ToString().Split(":")[1].Trim()

# Remove the IP
Remove-NetIPAddress -InterfaceIndex $InterfaceIndex -Confirm:$false

# Remove the Default Gateway
Remove-NetRoute -InterfaceIndex $InterfaceIndex -Confirm:$false

# Set IP-Address, Subnetmask and Default Gateway
New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress $IPAddress -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway

# Set DNS-Server
Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses $ServerAddresses

# Enable DHCP-Server
#Set-NetIPInterface -InterfaceIndex $InterfaceIndex -Dhcp Enabled
