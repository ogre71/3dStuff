function Get-3dMMPlantLabel { 
    Param($mainText, $smallText="")
    process {
        #$template = [System.IO.File]::ReadAllText("C:\Users\ogre7\scratch\20180829\3dStuff\PlantLabelTemplate.scad")
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
    
    }
}


#$slicer = "C:\Program Files\Prusa3D\Slic3rPE\slic3r.exe"
Get-3dMMPlantLabel "Swamp Milkweed" "Sunbury OH"




