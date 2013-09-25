

Function Get-VMProcessor
{# .ExternalHelp  MAML-VMConfig.XML
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeLine = $true)]
        $VM="%", 
        
        [ValidateNotNullOrEmpty()]
        $Server = "."         #May need to look for VM(s) on Multiple servers
    )
    process {
        if ($VM -is [String])  {$VM = Get-VM -Name $VM -Server $Server }
        if ($VM.count -gt 1 )   {$VM | foreach-Object { Get-VMProcessor -VM $_ -Server $Server} }    
        if ($vm.__CLASS -eq 'Msvm_ComputerSystem')   {
            Get-WmiObject -ComputerName $vm.__server -namespace $HyperVNamespace -Query "associators of {$($vm.__Path)} where resultclass=MSVM_Processor" |
                Add-Member -passthru -name "VMElementName" -MemberType noteproperty -value $($vm.elementName)  } 
    }
}

