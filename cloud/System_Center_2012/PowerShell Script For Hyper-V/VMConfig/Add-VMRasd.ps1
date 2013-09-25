$lstr_CreateHW                       = "Create {0}" 
$lstr_CreateHWSuccess                = "Added {0} to {1}."
$lstr_CreateHWFailure                = "Failed to add {0} to {1}, return code"


Function Add-VMRASD 
{# .ExternalHelp  MAML-VMConfig.XML
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [parameter(Mandatory = $true)]
        [System.Management.ManagementObject]$VM ,
        [parameter(Mandatory = $true)]
        [System.Management.ManagementObject]$RASD ,
        $PSC, 
        [switch]$force
    )
        if ($psc -eq $null) { $psc = $pscmdlet }
        $VSMgtSvc = Get-WmiObject -ComputerName $rasd.__Server -Namespace $HyperVNamespace -Class "MSVM_VirtualSystemManagementService"
        if ($force -or $psc.shouldProcess(($lStr_VirtualMachineName -f $vm.elementName ), ($lstr_CreateHW -f $Rasd.ElementName))) {
            $result = $VSMgtSvc.AddVirtualSystemResources($VM.__Path, @($Rasd.GetText([System.Management.TextFormat]::WmiDtd20)) )
            if ( ($result | Test-wmiResult -wait -JobWaitText ($lstr_CreateHW -f $Rasd.ElementName)`
                                           -SuccessText ($lstr_CreateHWSuccess -f $Rasd.ElementName, $VM.elementname) `
                                           -failText ($lstr_CreateHWFailure -f $Rasd.ElementName, $vm.elementname) ) -eq [returnCode]::ok) {
                                      IF ((Get-Module FailoverClusters) -and (Get-vmclusterGroup $VM)) {Sync-VMClusterConfig $vm | out-null }
                                      [wmi]$Result.NewResources[0] | Add-Member -passthru -name "VMElementName" -MemberType noteproperty -value $($vm.elementName) 
            }
    }
}