Function FileCOnverter{
[CmdletBinding()]
param(
    [parameter(mandatory=$true)]
    [string] $folder_path,
    [parameter(mandatory=$false)]
    [string] $out_folder,
    [parameter(mandatory=$true)]
    [string] $out_format
)
cd $folder_path

if ($out_folder -ne $null){
if ((Test-Path $out_folder)-eq $false){
mkdir $out_folder
}
}


Get-ChildItem $folder_path | ForEach-Object {
    $file_name = $_.Name
    $file_name_no_ext = ($file_name.split("."))
    echo $file_name_no_ext
    if (Test-Path -Path $file_name -PathType Leaf){
        if ((($file_name.split("."))[1]) -ne $out_format)  {
            if ($out_folder -eq $null){
            $out_name=($file_name_no_ext[0] + '.'+ $out_format)
            }
            else{
            $out_name= $out_folder+ '\' +($file_name_no_ext[0] + '.'+ $out_format)
            }

            echo $out_name
            ffmpeg -i $file_name $out_name
        }
    }
}
}