

Function Get-VMSettingData
{# .ExternalHelp  MAML-VMConfig.XML
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeLine = $true)]
        $VM="%", 
        
        [ValidateNotNullOrEmpty()]        
        $Server = "."
    )
    process {
        if ($VM -is [String])  { $vm = Get-VM -Name $VM -Server $Server }
        if ($VM.count -gt 1 )   { $VM | ForEach-object { Get-VMSettingData -VM $_ -Server $Server} }
        if ($vm.__Class -eq "Msvm_VirtualSystemSettingData") { $VM }
        if ($vm.__Class -eq "Msvm_ComputerSystem")           {
            Get-WmiObject -ComputerName $vm.__server -namespace $HyperVNamespace -Query "associators of {$($vm.__Path)} where resultclass=MSVM_VirtualSystemSettingData" |
                 where-object {$_.instanceID -eq "Microsoft:$($vm.name)"} | Add-Member -passthru -name "VMElementName" -MemberType noteproperty   -value $($vm.elementName)                                                                
        }
    }
}
