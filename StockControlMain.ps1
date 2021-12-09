#Import modules
#import-module sqlserver

#Declare Servername, DatabaseName and Credentials
$ServerName = 'localhost'
$DatabaseName = 'stockControl'
$userName = 'powerUser'
$password = 'Pa55w.rd'

#Open SQL connection
$connectionString = 'Data Source={0};database={1};User ID={2};Password={3}' -f $ServerName,$DatabaseName,$userName,$password
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $connectionString
$sqlConnection.Open()
#Write-Host "Sql Connection opened successfully!!"

#CSS
$HtmlHead = '<style>
    body {
        background-color: white;
        font-family:      "Calibri";
    }

    table {
        border-width:     1px;
        border-style:     solid;
        border-color:     black;
        border-collapse:  collapse;
        width:            100%;
    }

    th {
        border-width:     1px;
        padding:          5px;
        border-style:     solid;
        border-color:     black;
        background-color: #98C6F3;
    }

    td {
        border-width:     1px;
        padding:          5px;
        border-style:     solid;
        border-color:     black;
        background-color: White;
    }

    tr {
        text-align:       left;
    }
</style>'

######################## START OF PROGRAM - ALL CODE AFTER THIS LINE AS SQL CONNECTION HAS BEEN ESTABLISHED #######################

do
 {
    viewAddDelSCMenu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
       '1' {
            showStockControlViewMenu
        } '2' {
            showStockControlAddMenu
        } '3' {
            showStockControlDeleteMenu
        } '4' {
            generateCustomerReportAsHtml
        } '5' {
            generateCustomerReportAsCsv
        }
    }
    #pause
 }
 until ($selection -eq 'Q')


###### Function to display the Initial View Add Delete menu ###### 
function viewAddDelSCMenu
{
    [CmdletBinding()]
    param (
        [string]$Title = 'Welcome to Stock Control'
    )
    Clear-Host
    Write-Host "========== $Title =========="
    
    Write-Host "1: Press '1' to VIEW customers"
    Write-Host "2: Press '2' to ADD customers"
    Write-Host "3: Press '3' to DELETE customers"
    Write-Host "4: Press '4' to GENERATE customer report as HTML"
    Write-Host "5: Press '5' to GENERATE customer report as CSV"
    Write-Host "Q: Press 'Q' to EXIT"
}

###### OPTION 1 - Function to display the Stock Control View Menu ######
function showStockControlViewMenu
{
    [CmdletBinding()]
    param (
        [string]$Title = 'Welcome to the Stock Control'
    )
    Clear-Host
    Write-Host "========== $Title =========="
    
    Write-Host "1: Press '1' to VIEW customers under 7th ID"
    Write-Host "2: Press '2' to VIEW customers under 17th FAB"
    Write-Host "3: Press '3' to VIEW customers under 42nd MP"
    Write-Host "4: Press '4' to VIEW customers under 62nd MD"
    Write-Host "5: Press '5' to VIEW customers under 201st EMIB"
    Write-Host "6: Press '6' to VIEW customers under 555th EN"
    Write-Host "7: Press '7' to VIEW customers under 593rd ESC"
    Write-Host "8: Press '8' to VIEW customers under ICorps"
    Write-Host "Q: Press 'Q' to go back to the main menu"

    do
     {
        $selection = Read-Host "Please make a selection"
        switch ($selection)
        {
           '1' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 7th ID DODAAC to open the pdf"
                        $brigade = '7th'
                        checkIfValidDodaac   
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC)
            } '2' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 17th FAB DODAAC to open the pdf"
                        $brigade = '17th'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC) 
            } '3' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 42nd MP DODAAC to open the pdf" 
                        $brigade = '42nd'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC)
            } '4' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 62nd MD DODAAC to open the pdf"
                        $brigade = '62nd'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC)
            } '5' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 201st EMIB DODAAC to open the pdf"
                        $brigade = '201st'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC)
            } '6' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 555th EN DODAAC to open the pdf"
                        $brigade = '555th'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC)
            } '7' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 593rd ESC DODAAC to open the pdf"
                        $brigade = '593rd'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC)
            } '8' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid ICorps DODAAC to open the pdf"
                        $brigade = 'ICorps'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                viewDodaacPdf($DODAAC)
            }
        }
        #pause
     }
     until ($selection -eq 'Q')
}

###### OPTION 2 - Function to display the Stock Control Add Menu ######
function showStockControlAddMenu
{
    [CmdletBinding()]
    param (
        [string]$Title = 'Welcome to the Stock Control'
    )
    Clear-Host
    Write-Host "========== $Title =========="
    
    Write-Host "1: Press '1' to ADD customers under 7th ID"
    Write-Host "2: Press '2' to ADD customers under 17th FAB"
    Write-Host "3: Press '3' to ADD customers under 42nd MP"
    Write-Host "4: Press '4' to ADD customers under 62nd MD"
    Write-Host "5: Press '5' to ADD customers under 201st EMIB"
    Write-Host "6: Press '6' to ADD customers under 555th EN"
    Write-Host "7: Press '7' to ADD customers under 593rd ESC"
    Write-Host "8: Press '8' to ADD customers under ICorps"
    Write-Host "Q: Press 'Q' to go back to the main menu."

    #Validate the DODAAC to be alphanumeric and a maximum 6 characters long
    do
     {
        $selection = Read-Host "Please make a selection"
        switch ($selection)
        {
           '1' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 7th ID DODAAC"
                        $brigade = '7th'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC)
            } '2' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 17th FAB DODAAC"
                        $brigade = '17th'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC) 
            } '3' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 42nd MP DODAAC" 
                        $brigade = '42nd'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC)
            } '4' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 62nd MD DODAAC"
                        $brigade = '62nd'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC)
            } '5' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 201st EMIB DODAAC"
                        $brigade = '201st'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC)
            } '6' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 555th EN DODAAC"
                        $brigade = '555th'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC)
            } '7' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 593rd ESC DODAAC"
                        $brigade = '593rd'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC)
            } '8' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid ICorps DODAAC"
                        $brigade = 'ICorps'
                        checkIfValidDodaac
                        } catch {}
                } until ($?)
                addDodaacPdf($DODAAC)
            }
        }
        #pause
     }
     until ($selection -eq 'Q')
}

###### OPTION 3 - Function to display the Stock Control Delete Menu ######
function showStockControlDeleteMenu
{
    [CmdletBinding()]
    param (
        [string]$Title = 'Welcome to the Stock Control'
    )
    Clear-Host
    Write-Host "========== $Title =========="
    
    Write-Host "1: Press '1' to DELETE customers under 7th ID"
    Write-Host "2: Press '2' to DELETE customers under 17th FAB"
    Write-Host "3: Press '3' to DELETE customers under 42nd MP"
    Write-Host "4: Press '4' to DELETE customers under 62nd MD"
    Write-Host "5: Press '5' to DELETE customers under 201st EMIB"
    Write-Host "6: Press '6' to DELETE customers under 555th EN"
    Write-Host "7: Press '7' to DELETE customers under 593rd ESC"
    Write-Host "8: Press '8' to DELETE customers under ICorps"
    Write-Host "Q: Press 'Q' to go back to the main menu."

    do
     {
        $selection = Read-Host "Please make a selection"
        switch ($selection)
        {
           '1' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 7th ID DODAAC"
                        $brigade = '7th'
                        checkIfValidDodaac   
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC)
            } '2' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 17th FAB DODAAC"
                        $brigade = '17th'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC) 
            } '3' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 42nd MP DODAAC" 
                        $brigade = '42nd'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC)
            } '4' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 62nd MD DODAAC"
                        $brigade = '62nd'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC)
            } '5' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 201st EMIB DODAAC"
                        $brigade = '201st'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC)
            } '6' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 555th EN DODAAC"
                        $brigade = '555th'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC)
            } '7' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid 593rd ESC DODAAC"
                        $brigade = '593rd'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC)
            } '8' {
                do
                {   
                    try {
                        [ValidatePattern('^[a-zA-Z0-9]{6}$')] $DODAAC = Read-Host "Enter a valid ICorps DODAAC"
                        $brigade = 'ICorps'
                        checkIfValidDodaac 
                        } catch {}
                } until ($?)
                deleteDodaacPdf($DODAAC)
            }
        }
        #pause
     }
     until ($selection -eq 'Q')
}

###### OPTION 4 - Function to generate a consolidated customer report in HTML format ######
function generateCustomerReportAsHtml
{
    [CmdletBinding()]
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    $getPathQuery = “SELECT BrigadeName AS 'Brigade Name', DodaacId AS 'DODAAC Id', DodaacPath AS 'File Path' FROM dbo.StockControlCustData ORDER BY BrigadeName ASC”
    $sqlCommand.CommandText = $getPathQuery

    $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCommand
    $dataSet = New-Object System.Data.DataSet
    $sqlAdapter.Fill($dataSet) | Out-Null
    $dataSet.Tables    

    ##Return all of the rows and pipe it into the ConvertTo-HTML cmdlet, and then pipe that into our output file
    $OutputFile = 'H:\My Drive\My M@cBo0K Pr0\EDUCATION\MSSA - Army\Projects\customerReport.html'
    $dataSet.Tables | Select-Object -Expand Rows | ConvertTo-HTML -Title "STOCK CONTROL - Customer Report" -Head $HtmlHead | Out-File $OutputFile

    [System.Windows.MessageBox]::Show('Customer Report HTML generated successfully!!')
}

###### OPTION 5 - Function to generate a consolidated customer report in CSV format ######
function generateCustomerReportAsCsv
{
    [CmdletBinding()]
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    $getPathQuery = “SELECT BrigadeName AS 'Brigade Name', DodaacId AS 'DODAAC Id', DodaacPath AS 'File Path', IsValid as 'Is it Valid?' FROM dbo.StockControlCustData ORDER BY BrigadeName ASC”
    $sqlCommand.CommandText = $getPathQuery

    $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCommand
    $dataSet = New-Object System.Data.DataSet
    $sqlAdapter.Fill($dataSet) | Out-Null
    $dataSet.Tables
    
    ##Return all of the rows and pipe it into the ConvertTo-HTML cmdlet, and then pipe that into our output file
    $OutputFile = 'H:\My Drive\My M@cBo0K Pr0\EDUCATION\MSSA - Army\Projects\customerReport.csv'
    $dataSet.Tables | Select-Object -Expand Rows | ConvertTo-Csv | Out-File $OutputFile

    [System.Windows.MessageBox]::Show('Customer Report CSV generated successfully!!')
}

###### Function to get path to pdf and open pdf ######
function viewDodaacPdf
{
    [CmdletBinding()]
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    $getPathQuery = “SELECT DodaacPath FROM dbo.StockControlCustData WHERE DodaacId='$DODAAC' and IsValid='Y'”
    $sqlCommand.CommandText = $getPathQuery

    $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCommand
    $dataSet = New-Object System.Data.DataSet
    $sqlAdapter.Fill($dataSet) | Out-Null
    ####### NEED TO FIX NULL ARRAY ISSUE if an unknown DODAAC is entered #######
    if ($dataSet.Tables.rows["DodaacPath"] -eq $null){
        Write-Output "Please enter a different DODAAC. No signature card associated with:"$DODAAC
    }
    else {
        $dodaacPathToPdf = $dataSet.Tables[0].rows[0]["DodaacPath"]  
        Invoke-Item $dodaacPathToPdf
    }    
}

###### Function to get path to pdf and add pdf ######
function addDodaacPdf
{
    [CmdletBinding()]
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    $getPathQuery = “SELECT DodaacPath FROM dbo.StockControlCustData WHERE DodaacId='$DODAAC'”
    $sqlCommand.CommandText = $getPathQuery

    $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCommand
    $dataSet = New-Object System.Data.DataSet
    $sqlAdapter.Fill($dataSet) | Out-Null
    ####### NEED TO FIX NULL ARRAY ISSUE if an unknown DODAAC is entered #######
    if ($dataSet.Tables.rows["DodaacPath"] -eq $null){
        Write-Output "Please enter a different DODAAC. No signature card associated with:"$DODAAC
    }
    else {
        $dodaacPathToPdf = $dataSet.Tables[0].rows[0]["DodaacPath"]  
        Invoke-Item $dodaacPathToPdf
    }    
}

###### Function to get path to pdf and delete pdf ######
function deleteDodaacPdf
{
    [CmdletBinding()]
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    #$sqlCommand.CommandTimeout = 600000
    $sqlCommand.CommandText = “UPDATE dbo.StockControlCustData SET IsValid = 'N' WHERE DodaacId='$DODAAC'”
    $rowsAffected = $sqlCommand.ExecuteNonQuery()
    Write-Output "All signature cards for $DODAAC has been deleted. Please use the ADD option to add new signature cards!"
}

###### Function to check if the entered DODAAC is valid and if it corresponds to the right brigade ######
function checkIfValidDodaac
{
    [CmdletBinding()]
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    $getPathQuery = “SELECT DodaacPath FROM dbo.StockControlCustData sc  WHERE sc.DodaacId IN (SELECT DodaacId FROM  StockControlCustData sc1 WHERE sc1.DodaacId = '$DODAAC' AND sc1.BrigadeName LIKE '$brigade%' AND sc1.IsValid = 'Y')”
    $sqlCommand.CommandText = $getPathQuery

    $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCommand
    $dataSet = New-Object System.Data.DataSet
    $sqlAdapter.Fill($dataSet) | Out-Null
    ####### NEED TO FIX NULL ARRAY ISSUE if an unknown DODAAC is entered #######
    if ($dataSet.Tables.rows["DodaacPath"] -eq $null){
        Write-Output "Please enter a valid DODAAC for $brigade"
    }
    else {
        $output = Write-Output "Please enter a valid DODAAC for $brigade" $dodaacPathToPdf
    }
}

######################## ADD ALL CODE BEFORE THIS LINE AS THE LAST STEP IS CLOSING ANY OPEN SQL CONNECTIONS #######################

#Close SQL Connection
$sqlConnection.Close()
#Write-Host "Sql Connection closed successfully!!"
