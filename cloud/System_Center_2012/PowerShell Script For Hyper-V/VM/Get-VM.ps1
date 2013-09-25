

Function Get-VM 
{# .ExternalHelp  MAML-VM.XML
    param(
        [parameter(ValueFromPipeLine = $true)] [ValidateNotNullOrEmpty()][Alias("VMName")]
        $Name = "%", 
        
        [ValidateNotNullOrEmpty()]
        $Server = ".",  #May need to look for VM(s) on Multiple servers
        [Switch]$Suspended, 
        [switch]$Running, 
        [switch]$Stopped
    ) 
    Process { 
        if ($Name.count -gt 1  ) {[Void]$PSBoundParameters.Remove("Name") ;  $Name | ForEach-object {Get-VM -Name $_ @PSBoundParameters}}
        if ($name -is [String]) {
            # In case people are used to the * as a wildcard...
            $Name = $Name.Replace("*","%")
            # Note: in V1 the test was for caption like "Virtual%" which did not work in languages other than English.
            # Thanks to Ronald Beekelaar -  we now test for a processID , the host has a null process ID, stopped VMs have an ID of 0. 
            $WQL = "SELECT * FROM MSVM_ComputerSystem WHERE ElementName LIKE '$Name' AND ProcessID >= 0"
            if ($Running -or $Stopped -or $Suspended) { 
                $state = "" 
                if ($Running)   {$State += " or enabledState = " + [int][VMState]::Running   }
                if ($Stopped)   {$State += " or enabledState = " + [int][VMState]::Stopped   }
                if ($Suspended) {$State += " or enabledState = " + [int][VMState]::Suspended }
                $state = $state.substring(4)  
                $WQL += " AND ($state)" 
            } 
            Get-WmiObject -computername $Server -NameSpace $HyperVNamespace -Query $WQL | Add-Member -MemberType ALIASPROPERTY -Name "VMElementName" -Value "ElementName" -PassThru 
        }
        elseif ($name.__class)  {
            Switch ($name.__class) {
               "Msvm_ComputerSystem"                {$Name}
               "Msvm_VirtualSystemSettingData"      {get-wmiobject  -computername $Name.__SERVER -namespace $HyperVNamespace  -Query "associators of {$($name.__path)} where resultclass=Msvm_ComputerSystem"}   
               Default                              {get-wmiobject  -computername $Name.__SERVER -namespace $HyperVNamespace  -Query "associators of {$($Name.__path)} where resultclass=Msvm_VirtualSystemSettingData" | 
                                                          ForEach-Object {$_.getRelated("Msvm_ComputerSystem")} | Select-object -unique  }
            }
        }
    }
}
