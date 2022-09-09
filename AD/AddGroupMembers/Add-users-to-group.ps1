$input_file = import-csv "file path with Group-member.csv inputfile"

foreach ($row in $input_file)
{
    Add-ADGroupMember -identity $row.group -Members $row.user
}

