$Lstr_jobContinues = "The job to {0} is still running in the background. `n You can check its progress with Test-wmiJob or Test-wmiJob -statusOnly using the following job id:`n{1}"  
$lstr_JobSuccess   = "{0} succeeded" 
$lstr_JobFailure   = "{0} Failed, with the response " 

Function Test-WMIResult
{# .ExternalHelp  Maml-Helper.XML   
    Param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true, position=0)][ValidateNotNullOrEmpty()]
        $result ,
        
        [String]$JobWaitText,
        [String]$SuccessText, 
        [String]$failText , 
        [switch]$wait )
    
    if ($result.ReturnValue -eq [ReturnCode]::JobStarted) {
        if ( -not $jobWaitText ) {$jobWaitText = ([wmi]$result.job).description }
        if ( -not $SuccessText ) {$SuccessText = ($lstr_JobSuccess -f $jobWaitText) }
        if ( -not $FailText    ) {$FailText    = ($lstr_JobFailure -f $jobWaitText) }              
        $job  = Test-WMIJob -job $result.job -wait:$wait -Description $JobWaitText 
        if     ( $Job.JobState -eq [JobState]::Completed)                   {Write-Verbose ($SuccessText )                                  ;[ReturnCode]::OK }
        elseif (($Job.jobState -eq [JobState]::running) -and -not $wait )   {Write-Warning ($Lstr_jobContinues -f $jobWaitText,$result.job) ;[ReturnCode]::JobStarted }
        else                                                                {write-error ($failText + ":`n" + $job.ErrorDescription + "`n+");[ReturnCode]::Failed }
    }
    elseif ($result.returnValue -eq [ReturnCode]::OK)                       {Write-Verbose ($SuccessText )                                  ;[ReturnCode]::OK }
    Else                                                                    {write-error ($failText + [returnCode]$Result.ReturnValue)      ;[ReturnCode]::Failed }
}