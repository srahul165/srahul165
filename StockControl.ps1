 #Declare Servername, DatabaseName and Credentials
$ServerName = 'localhost'
$DatabaseName = 'stockControl'
$userName = 'powerUser'
$password = 'Pa55w.rd'

#Open Database connection
$connectionString = 'Data Source={0};database={1};User ID={2};Password={3}' -f $ServerName,$DatabaseName,$userName,$password
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $connectionString

#Open SQL Connection
$sqlConnection.Open()
Write-Host "Sql Connection opened successfully!!"

#Validate the DODAAC to be alphanumeric and a maximum 6 characters long
do
 {
    showStockControlMenu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
       '1' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 7th ID DODAAC" 
                    } catch {}
            } until ($?)            
            Write-Host "Value of the entered DODAAC is : " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC)
        } '2' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 17th FAB DODAAC" 
                    } catch {}
            } until ($?)
            Write-Host "Enter a valid 17th FAB DODAAC: " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC) 
        } '3' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 42nd MP DODAAC" 
                    } catch {}
            } until ($?)
            Write-Host "Enter a valid 42nd MP DODAAC: " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC)
        } '4' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 62nd MD DODAAC" 
                    } catch {}
            } until ($?)
            Write-Host "Enter a valid 62nd MD DODAAC: " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC)
        } '5' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 201st EMIB DODAAC" 
                    } catch {}
            } until ($?)
            Write-Host "Enter a valid 201st EMIB DODAAC: " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC)
        } '6' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 555th EN DODAAC" 
                    } catch {}
            } until ($?)
            Write-Host "Enter a valid 555th EN DODAAC: " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC)
        } '7' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 593rd ESC DODAAC" 
                    } catch {}
            } until ($?)
            Write-Host "Enter a valid 593rd ESC DODAAC: " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC)
        } '8' {
            do
            {   
                try {
                    [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid ICorps DODAAC" 
                    } catch {}
            } until ($?)
            Write-Host "Enter a valid ICorps DODAAC: " $DODAAC
            #Calling getDodaacInfo function to get PDF based on the input value
            getDodaacInfo($DODAAC)
        }
    }
    pause
 }
 until ($selection -eq 'Q')

#Function to display the Stock Control Menu
function showStockControlMenu
{
    param (
        [string]$Title = 'Welcome to the Stock Control'
    )
    Clear-Host
    Write-Host "========== $Title =========="
    
    Write-Host "1: Press '1' to view customers under 7th ID"
    Write-Host "2: Press '2' to view customers under 17th FAB"
    Write-Host "3: Press '3' to view customers under 42nd MP"
    Write-Host "4: Press '4' to view customers under 62nd MD"
    Write-Host "5: Press '5' to view customers under 201st EMIB"
    Write-Host "6: Press '6' to view customers under 555th EN"
    Write-Host "7: Press '7' to view customers under 593rd ESC"
    Write-Host "8: Press '8' to view customers under ICorps"
    Write-Host "Q: Press 'Q' to quit."
}

$pdfPath = "H:\My Drive\My M@cBo0K Pr0\EDUCATION\MSSA - Army\Projects\StockControl\201st EMIB\W58YFJ.pdf"
Invoke-Item $pdfPath
Invoke-Item -LiteralPath $dodaacPathToPdf

#Function to display the Stock Control Menu
function getDodaacInfo
{
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    $getPathQuery = “SELECT DodaacPath FROM dbo.StockControlCustData WHERE DodaacId='W68QAH'”
    $sqlCommand.CommandText = $getPathQuery

    $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCommand
    $dataSet = New-Object System.Data.DataSet
    $sqlAdapter.Fill($dataSet) | Out-Null
    $dataSet.Tables
}

$dodaacPathToPdf = getDodaacInfo
Write-Host "Path of the pdf file" $dodaacPathToPdf

Invoke-Item -Path $dodaacPathToPdf

#Close SQL Connection
$sqlConnection.Close()
Write-Host "Sql Connection closed successfully!!"
