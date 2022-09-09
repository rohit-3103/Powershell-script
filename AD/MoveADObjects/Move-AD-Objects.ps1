

# Import AD Module
import-module ActiveDirectory


# Import the CSV file and assign it to variable 
$input_file = import-csv "file path with Group-member.csv inputfile"

foreach ($row in $input_file)
{
    $Target_OU_DN = $row.DN_of_TargetOU

    if($row.User)
    {
        $User_DN  = (Get-ADUser -Identity $row.User).distinguishedName

        MOve-ADObject -Identity $User_DN  -TargetPath $Target_OU_DN
    }

    if($row.contact)
    {
        $contact_DN = (Get-contact -Identity $row.contact).distinguishedname

        MOve-ADObject -Identity $contact_DN  -TargetPath $Target_OU_DN
    }

    if($row.group)
    {
        $group_DN = (Get-ADGroup -identity $row.group).distinguishedname

        MOve-ADObject -Identity $group_DN  -TargetPath $Target_OU_DN
    }
}