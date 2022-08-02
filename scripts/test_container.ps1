$count = 0
do {
    $count++
    echo "[$env:STAGE_NAME] Starting container [Attempt: $count]"
    
    $testStart = curl http://localhost:8000
    echo $testStart
    
    if ($testStart.statuscode -eq '200') {
        $started = $true
    } else {
        sleep 1s
    }
    
} until ($started -or ($count -eq 3))

if (!$started) {
    exit 1
}
