#=====================================================
# JSON RESH-ID Edit Script
# Change RESH-ID and Clinic Name in JSON Template
#=====================================================

#--- Setup File Paths ---------------------------------------------------
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Write-Debug "Script directory determined: $scriptDir"

$assetsFilePath = Join-Path $scriptDir "assets"
Write-Debug "Assets folder path: $assetsFilePath"

$originalFilePath = Join-Path $assetsFilePath "SiV-mal-poliklinikk.json"
Write-Debug "Original JSON file path: $originalFilePath"
Start-Sleep -Milliseconds 500

#--- Header Information -------------------------------------------------
Write-Host "==========================================================" -ForegroundColor Magenta
Write-Host "Willkommen, Freund, zu meinem Skript!" -ForegroundColor Green
Write-Host "Lass mich dich auf deiner Reise begleiten und" -ForegroundColor Green
Write-Host "die RESH-ID sowie den Namen der Ambulanz für dich ändern." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Magenta
Start-Sleep -Seconds 1
Write-Host "Lass uns anfangen, oder?" -ForegroundColor DarkGreen
Write-Host ""
Start-Sleep -Seconds 1

#--- User Prompts -------------------------------------------------------
$newReshId = Read-Host "Skriv inn RESH ID'en til poliklinikken"
Write-Debug "User entered new RESH ID: $newReshId"
Start-Sleep -Milliseconds 500

$newClinicName = Read-Host "Skriv inn navnet på poliklinikken (IKKE ta med 'SiV foran')"
Write-Debug "User entered new clinic name: $newClinicName"
Start-Sleep -Milliseconds 500

Write-Host "Danke!" -ForegroundColor Blue
Write-Host ""

#--- Prepare File Name for Output ---------------------------------------
# Replace any combination of spaces and dashes with a single dash, then convert to lowercase.
$sanitizedName = ($newClinicName -replace '[\s-]+', '-').ToLower()
Write-Debug "Sanitized clinic name for file: $sanitizedName"

$outputDirectory = Join-Path $scriptDir "output"
Write-Debug "Output directory set to: $outputDirectory"

$outputFilePath = Join-Path $outputDirectory ("poliklinikk-mal_$sanitizedName.json")
Write-Debug "Output file path set to: $outputFilePath"
Start-Sleep -Milliseconds 500

#--- Define Replacement Strings -----------------------------------------
$reshReplacement = "replaceReshId"
$nameReplacement = "replaceClinicName"
Write-Debug "Replacement strings: RESH='$reshReplacement', Clinic='$nameReplacement'"

#--- Read and Process JSON File -----------------------------------------
Write-Verbose "Reading JSON file from: $originalFilePath"
$fileContent = Get-Content $originalFilePath -Raw
Write-Debug "JSON content loaded (Length: $($fileContent.Length) characters)"

$newFileContent = $fileContent.Replace($reshReplacement, $newReshId).Replace($nameReplacement, $newReshId)
Write-Debug "String replacements complete."

#--- Write Updated Content to Output File -------------------------------
Write-Verbose "Writing updated JSON to: $outputFilePath"
Set-Content -Path $outputFilePath -Value $newFileContent
Write-Debug "Output file written successfully."
Start-Sleep -Seconds 1

#--- Completion Message -------------------------------------------------
Write-Host ""
Write-Host "==========================================" -ForegroundColor Magenta
Write-Host "Naisern! (Som Mats sier)." -ForegroundColor Cyan
Write-Host "Endring gjennomført. Filen er lagret i:" -ForegroundColor Cyan
Write-Host "$outputFilePath" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Magenta
Write-Host ""
Start-Sleep -Seconds 1
Write-Host "♥ Leb wohl, Reisender! ♥" -ForegroundColor Green

# Exit
Start-sleep -Milliseconds 600
Write-Host ""
Write-Host ""
Write-Host "Punch HARDT på hvilken som helst knapp for å lukke skriptet! Minst 5 kg trykk kreves." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
