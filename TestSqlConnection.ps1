#Function to test a SQL Server connection
#ServerName - localhost #DatabaseName - stockControl #User - powerUser #Password - Pa55w.rd
function Test-SqlConnection {
    param(
        [Parameter(Mandatory)]
        [string]$ServerName,

        [Parameter(Mandatory)]
        [string]$DatabaseName,

        [Parameter(Mandatory)]
        [pscredential]$Credential        
    )

    $ErrorActionPreference = 'Stop'

    try {
        $userName = $Credential.UserName
        $password = $Credential.GetNetworkCredential().Password
        $connectionString = 'Data Source={0};database={1};User ID={2};Password={3}' -f $ServerName,$DatabaseName,$userName,$password
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnectionString
        $sqlConnection.Open()
        ## This will run if the Open() method does not throw an exception
        $true
    } catch {
        $false
    } finally {
        ## Close the connection when we're done
        $sqlConnection.Close()
    }
}


#Invole Test-sqlconnection function to verify connection
Test-SqlConnection -ServerName 'localhost' -DatabaseName 'stockControl' -Credential (Get-Credential)

#Function to connect to the SQL Server
function connectToSql
{
    $sqlConn = New-Object System.Data.SqlClient.SqlConnection
    $sqlConn.ConnectionString = “Server=localhost\stockControl;Integrated Security=true;Initial Catalog=master”
    $sqlConn.Open()
}

