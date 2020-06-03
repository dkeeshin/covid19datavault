CLS
#Connect-AzAccount  -- will use default need to login as datavault@keeshinds.com

# The SubscriptionId in which to create these objects
$SubscriptionId = "subscriptionIDgoeshere"

# Set the resource group name and location for your server
$resourceGroupName = "resourcegroupnamegoeshere"

$location = "locationnamegoeshere"

# Set an admin login and password for your server
$adminSqlLogin = "loginNameGoesHere"

$password = "passwordgoeshere" 

# Set server name - the logical server name has to be unique in the system and ALL LOWER CASE
$serverName = "servernamegoeshere"

# The sample database name
# $databaseName = ""

# The ip address range that you want to allow to access your server
$startIp = "0.0.0.0"
$endIp = "0.0.0.0"

# Set subscription 
Set-AzContext -SubscriptionId $subscriptionId 



# Create a server with a system wide unique server name
$server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -Location $location `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))

# Create a server firewall rule that allows access from the specified IP range
$serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -FirewallRuleName "AllowedIPs" -StartIpAddress $startIp -EndIpAddress $endIp
`
 

# Clean up deployment -- see 65RemoveServer.ps1
