function Test-FileLock {
    param (
      [parameter(Mandatory=$true)][string]$Path
    )
  
    $oFile = New-Object System.IO.FileInfo $Path
  
    if ((Test-Path -Path $Path) -eq $false) {
      return $false
    }
  
    try {
      $oStream = $oFile.Open([System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)
  
      if ($oStream) {
        $oStream.Close()
      }
      $false
    } catch {
      # file is locked by a process.
      return $true
    }
  }

function Get-3dMMPlantLabel { 
    Param($mainText, $smallText="")
    process {
        #$template = [System.IO.File]::ReadAllText("C:\Users\ogre7\scratch\20180829\3dStuff\PlantLabelTemplate.scad")
        [System.Environment]::CurrentDirectory = Get-Location
        $template = [System.IO.File]::ReadAllText("PlantLabelTemplate.scad")
        $output = $template.Replace("<Main Text>", $mainText).Replace("<Small Text>", $smallText)
        $outputOne = $output.Replace("/*marker_two*/", "*")
        $outputTwo = $output.Replace("/*marker_one*/", "*")
        $outputOneFileName = "$($mainText)1.scad"
        $outputTwoFileName = "$($mainText)2.scad"
    
        $outputOne | Out-File $outputOneFileName -Encoding ascii
        $outputTwo | Out-File $outputTwoFileName -Encoding ascii
    
        & "C:\Program Files\OpenSCAD\openscad.exe" -o "$($mainText)1.amf" $outputOneFileName
        & "C:\Program Files\OpenSCAD\openscad.exe" -o "$($mainText)2.amf" $outputTwoFileName

        while(!(Test-Path("$($mainText)1.amf"))){
            Start-Sleep -milliseconds 100 
        }

        while(Test-FileLock("$($mainText)1.amf")) {
            Start-Sleep -Milliseconds 100 
        }

        $xmlDocOne = new-object System.Xml.XmlDocument
        $xmlDocOne.Load("$($mainText)1.amf")

        $xmlDocTwo = new-object System.Xml.XmlDocument
        $xmlDocTwo.Load("$($mainText)2.amf") 

        $outputOneCloneCopy = $xmlDocOne.CreateElement("object");
        $outputTwoCloneSource = $xmlDocTwo.SelectSingleNode("amf/object")

        $outputOneCloneCopy.InnerXml = $outputTwoCloneSource.InnerXml
        $outputOneCloneCopy.SetAttribute("id", 1)

        $volumeNode = $outputOneCloneCopy.SelectSingleNode("mesh/volume")
        $attributeNode2 = $volumeNode.SetAttributeNode("materialid", "")
        $attributeNode2.Value = 2 

        $attributeNode1 = $xmlDocOne.SelectSingleNode("amf/object/mesh/volume").SetAttributeNode("materialid", "")
        $attributeNode1.Value = 1
        $xmlDocOne.SelectSingleNode("amf").AppendChild($outputOneCloneCopy) | Out-null 

        $xmlDocOne.Save("$($mainText).amf")
    }
}


#$slicer = "C:\Program Files\Prusa3D\Slic3rPE\slic3r.exe"
#Get-3dMMPlantLabel "Swamp Milkweed" "Sunbury OH"




