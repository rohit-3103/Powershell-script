#read the input file 
#For Windows 10, you’ll only need to install the Remote Server Administration Tools (RSAT). When you install RSAT, all tools including the AD PowerShell module will be enabled by default.

$results =@()

Function usr_create($usrname,$Dname,$FirstName,$LastName,$upn,$pwd,$OUPath,$DCName)
{
    $new_user = New-ADUser -Name $usrname -DisplayName $Dname -GivenName $FirstName -Surname $LastName -SamAccountName $usrname -UserPrincipalName $upn -AccountPassword $pwd -Enabled:$true -ChangePasswordAtLogon $true -Path $OUPath -server $DCName
    return $new_user
}

Import-module activedirectory
#$inputFolder = Read-Host "Input folder path with User-AD-Create.csv"
#$input_file = import-csv "$inputFolder"
$input_file = import-csv "D:\Test\Script-work\AD-User-Create\User-AD-Create.csv"

foreach ($usr in $input_file)
{
    #from below command we get get Domain as 'lntcorp.lntuniverse.com' and Hostname as 'POCITMSLNTCDC02.LntCorp.LntUniverse.com'
    $AD_DC = Get-addomaincontroller -domain $usr.Domain -ForceDiscover -discover -nextclosestsite
    $AD_DC
    ECHO "====="
    if($usr.OU_DistinguishedName)
    {
        $ou = $usr.OU_DistinguishedName
    }
    else
    {
        #$ou = $AD_DC.Domain + "/Users"
        $dom = $AD_DC.Domain
        $CN = $dom.replace(".",",DC=")
        $ou = "'CN=Users,DC="+$CN+"'"
    }
    

    #$OU1 = Get-ADOrganizationalUnit -Server $AD_DC.Domain -Filter * |Where-Object  DistinguishedName -like '$ou'
    

    #$OU = "CN=Users,DC=LntCorp,DC=LntUniverse,DC=com"

    $ou
    ECHO "12345"
    $FName,$LName = $usr.DisplayName -split (" ",2)
    $Fname
    ECHO "456123"
    $LName
    ECHO "789456"

    $usrUPN = $usr.UserName +"@"+$AD_DC.Domain
    $usrUPN
    ECHO "UPN"
    $passwd =  ConvertTo-SecureString -String "#@Whkds&6we59)" -AsPlainText -Force

    
    $user_created = Usr_create -usrname $usr.UserName -Dname $usr.DisplayName -FirstName $FName -LastName $LName -upn $UsrUPN -pwd $passwd -OUPath $ou -DCName $usr.Domain
    $results += $user_created
    
}


$results

