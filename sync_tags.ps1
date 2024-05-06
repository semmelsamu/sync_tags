

# Benutzer zur Eingabe des ersten Pfades auffordern
$pfadA = "djlib"

# Benutzer zur Eingabe des zweiten Pfades auffordern
$pfadB = "Kaufarchiv"

# Laden der TagLib-Sharp Assembly
Add-Type -Path "TagLibSharp.dll"

# Durchlaufen aller Dateien in Ordner A
Get-ChildItem -Path $pfadA -File | ForEach-Object {
    $dateiA = $_
    $basisNameA = [System.IO.Path]::GetFileNameWithoutExtension($dateiA.Name)

    # Suchen einer entsprechenden Datei in Ordner B
    $dateiB = Get-ChildItem -Path $pfadB -File | Where-Object {
        [System.IO.Path]::GetFileNameWithoutExtension($_.Name) -eq $basisNameA
    }

    if ($dateiB) {
		
		$sourceFilePath = $dateiA.FullName
		$destinationFilePath = $dateiB.FullName
		
		Write-Host "Synchronisiere Tags:"
		Write-Host "$sourceFilePath"
		Write-Host "$destinationFilePath"
		Write-Host ""
		
		# Tags von der Quelldatei lesen
		$sourceFile = [TagLib.File]::Create($sourceFilePath)
		
        $destinationFile = [TagLib.File]::Create($destinationFilePath)

		### Tags von Quelle zu Ziel kopieren		
		# $destinationFile.Tag.Album = $sourceFile.Tag.Album
		# $destinationFile.Tag.AlbumArtists = $sourceFile.Tag.AlbumArtists
		# $destinationFile.Tag.Composers = $sourceFile.Tag.Composers
		$destinationFile.Tag.Genres = $sourceFile.Tag.Genres
		# $destinationFile.Tag.Title = $sourceFile.Tag.Title
		# $destinationFile.Tag.Year = $sourceFile.Tag.Year
        $destinationFile.Tag.Pictures = $sourceFile.Tag.Pictures

		# Änderungen an der Zieldatei speichern
		$destinationFile.Save()
    }
	else {
		
		Write-Host "Kein passendes Gegenstück gefunden:"
		Write-Host "$sourceFilePath"
		Write-Host ""
		
	}
}
