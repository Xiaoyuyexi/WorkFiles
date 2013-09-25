

Function Get-VMClusterGroup 
{# .ExternalHelp  MAML-VM.XML
    param(
           [parameter(ValueFromPipeLine = $true)]
           $VM="%",           

           [ValidateNotNullOrEmpty()]
           $Server="."   #May need to look for VM(s) on Multiple servers
    )
    Process {    
        if (-not (get-command -Name Move-ClusterVirtualMachineRole -ErrorAction "SilentlyContinue")) { return} #Unlike the other cluster commands, no warning so it can be used as a test for HA VMs anywhere without a stream of messages.  
        if ($VM -is [String]) {$VM=(Get-VM -Name $VM -server $server) }
        if ($VM.count -gt 1 )  {[Void]$PSBoundParameters.Remove("VM") ;  $VM | ForEach-object {Get-vmClusterGroup -VM $_  @PSBoundParameters}}
        if ($vm.__CLASS -eq 'Msvm_ComputerSystem') {
            get-cluster -name $vm.__server | Get-clustergroup | where-object { Get-ClusterResource -input $_ | where-object {$_.resourcetype -like "Virtual Machine"} | Get-ClusterParameter -Name vmID | 
                where-object {$_.value -eq $vm.name}} | Add-Member -passthru -name "VMElementName" -MemberType noteproperty   -value $($vm.elementName) 
        }
    }
}
#get-vm | where { (((get-date).subtract($vm.ConverttoDateTime($vm.TimeOfLastConfigurationChange) ) ).totalminutes  -gt 60) -and (get-vmClusterGroup $_) } | Sync-vmClusterConfig