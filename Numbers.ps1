function new-speech {
    Param
    (
        [Parameter(Mandatory = $true, 
            ValueFromPipeline = $true)]
        [string]$text
    )

    #set up .net object for use
    Add-Type -AssemblyName System.Speech 
    $synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    
    Write-Host $text
    $synth.speak($text)
 
}

new-speech "Hello, what is your name?" 
$name = Read-Host  
new-speech "Nice to meet you $name, let's add some numbers together!"
#to test, delete Start-Sleep later
Start-Sleep -Seconds 2
Write-Host "" 
Write-Host "--------------------------------------------------------" -for cyan 
Write-Host "--------------------LET'S ADD NUMBERS-------------------" -for cyan 
Write-Host "--------------------------------------------------------" -for cyan 
Write-Host "" 
Write-Host " Press Enter to continue."
#Pause script execution and wait for the user to press the Enter key
Read-Host
#Define the variables used in this script to collect player input
$Value1 = "" #Stores the value to calculate with supplied by the user
$Value2 = "" #Stores the value to calculate with supplied by the user
# Ask user for input

New-Speech -text "what numbers do you want to add $name"

#Provide the user with instructions
write-host " What numbers do you want to add. " -for cyan
Write-Host
Write-Host " Press the Enter key to continue."
#Pause script execution and wait for the user to press the Enter key
Read-Host

#Ask the user the first question
while ($Value1 -eq ""){
Write-Host

$Value1 = read-host " Enter the first number " 

}

#Ask the user the second question

while ($Value2 -eq ""){

Write-Host

Write-Host

$Value2 = read-host " Enter the second number " 


Write-Host ""
Write-Host "--------------------------------------------------------" -for cyan 
$answer=[int]$Value1 + [int]$Value2
new-speech " adding those numbers equals:$answer" 
Write-Host "--------------------------------------------------------" -for cyan 
#Pause script execution and wait for the user to press the Enter key

Read-Host
}