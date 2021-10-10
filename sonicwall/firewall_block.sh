#!/bin/bash
# By Govand Sinjari 10 Oct 2014
# Fully working version 21 Feb 2015
# Script will updated Sonicwall block rule
# install expect: apt-get install expect
#  ./block.sh ARGV[8]
# Splunk - Access arguments to scripts ran as an alert action
#Arg    Environment Variable    Value
#0      SPLUNK_ARG_0    Script name
#1      SPLUNK_ARG_1    Number of events returned
#2      SPLUNK_ARG_2    Search terms
#3      SPLUNK_ARG_3    Fully qualified query string
#4      SPLUNK_ARG_4    Name of report
#5      SPLUNK_ARG_5    Trigger reason For example, "The number of events was greater than 1."
#6      SPLUNK_ARG_6    Browser URL to view the report.
#7      SPLUNK_ARG_7    Not used for historical reasons.
#8      SPLUNK_ARG_8    File in which the results for the search are stored. Contains raw results.
# license           : MIT


IP=192.168.0.1
password=pass
login=username
#commands="show status"
IP2=$(gunzip -c $8 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

echo "`date` ARG0='$0' ARG1='$1' ARG2='$2' ARG3='$3' ARG4='$4' ARG5='$5' ARG6='$6' ARG7='$7' ARG8='$8' IP='$IP2'"  >> "/home/u/Downloads/block.out"

# +whatever variables you need to use

# Run the expect script from bash
expect_sh=$(expect -c "
spawn ssh $login@$IP
expect \"password:\"
send \"$password\r\"


############ for linux servers
#expect \"#\"
#send \"cd $dest_dir\r\"
#expect \"#\"
#send \"chmod +x $server_side_script $other_script\r\"
#expect \"#\"
#############


#send \"$commands\r\"

send \"yes\r\"
expect \"#\"

send \"configure\r\"
expect \"#\"

send \"yes\r\"
expect \"#\"

send \"address-object ipv4 bad_$IP2 host $IP2 zone WAN\r\"
#send \"address-object ipv4 bad_$1 host $1 zone WAN\r\"
expect \"#\"

send \"address-group ipv4 blockx\r\"
expect \"#\"

send \"address-object ipv4 bad_$IP2\r\"
expect \"#\"

send \"exit\r\"
expect \"#\"

send \"exit\r\"
expect \"#\"

send \"yes\r\"
expect \"#\"

send \"exit\r\"
")

# Output or do something with the results
echo "$expect_sh"

