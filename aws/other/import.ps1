$outputFile = "import.tf"

# TODO use map with full name
# all
$resources="alb", "asg", "cwa", "dbpg", "dbsg", "dbsn", "ec2", "ecc", "ecsn", "efs", "eip", "elb", "iamg", "iamgm", "iamgp", "iamip", "iamp", "iampa", "iamr", "iamrp", "iamu", "iamup", "igw", "kmsa", "kmsk", "lc", "nacl", "nat", "nif", "r53r", "r53z", "rds", "rs", "rt", "rta", "s3", "sg", "sn", "snss", "snst", "sqs", "vgw", "vpc"
## empty
#$resources="dbpg", "dbsg", "dbsn", "efs", "elb", "iamgp", "iamrp", "iamup", "kmsa", "kmsk", "rds", "rs"
## error
#$resources="r53z"

Write-Host "# Start"
$resources | ForEach-Object {
    Write-Host "Processing "$_
    "//region {$_}" >> $outputFile
    # TODO write error msg, if there was an error
    # TODO write info msg, if empty
    terraforming $_ >> $outputFile
    "//endregion" >> $outputFile
}

Write-Host "# End"
