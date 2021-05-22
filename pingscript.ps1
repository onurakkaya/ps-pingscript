$textFile = Get-Content .\intra.txt

$counter = 0 
$resultArray =  New-Object 'object[]' $textFile.Length
foreach ($line in $textFile)
{
    $counter = $counter + 1
    $urlArr = $line.Split("/")
    $url = $null
    if ($urlArr.Length -gt 0)
    {
        $url = $urlArr[0];
    }
    else
    {
        $url = $line
    }

    
    Write-Host Raw Line: $counter $line, Splitted Url: $url, Server Response:  $responseAddress
    $results=  (Test-NetConnection -InformationLevel Detailed -ComputerName $url)
    $responseAddress = $results.RemoteAddress

    if ($responseAddress.ToString().Length -gt 0)
    {
        $resultArray[$counter] = $responseAddress.ToString()
    }
    else
    {
        $resultArray[$counter] = " "
    }

    
}

$resultArray | Out-File .\ping-response.txt