#!/bin/bash


# This is a re-usable functions file
# Other scripts may use the functions in this file by sourcing them

#----------------------------function will check for error code & exit if failure, else proceed further----------------------------#

#usage : check_error <$?> <custom_error_code>
#Example: Check_error < pass $? from the shell command > < Custom Message for errorcode -gt 0 >

check_error()
{
	cmd_error_code=$1
	custom_message=$2
	if  [ ${cmd_error_code} -gt 0 ]; then
	  write_log "Error    | Stage |  ${custom_message}"
	  exit ${cmd_error_code}
	else
	  write_log "Success  | Stage | ${custom_message}"
	fi
}

#----------------------------function will check for error code & warn if failure----------------------------#

#usage : check_warning <$?> <custom_error_code>
#Example: Check_warning < pass $? from the shell command > < Custom Message for errorcode -gt 0 >


check_warning()
{

        cmd_error_code=$1
        pgm_exit_code=$2
        pgm_exit_msg=$3
        if  [ ${cmd_error_code} -gt 0 ]; then
                write_log "WARNING ! ${cmd_error_code} ${pgm_exit_code} ${pgm_exit_msg}"
        else
                echo ""
        fi
}



#----------------------------function will write the message to Console / Log File----------------------------#

#Usage : write_log < Whatever message you need to log >

write_log()
{
        msg=$1
        to_be_logged="$(date '+%Y%m%d %H:%M:%S') | $msg"
        echo ${to_be_logged}
}

#-----------------------------------Executes a Command--------------------------------------------------------#



#Usage : run_cmd < The command to execute > 

run_cmd()
{
       cmd=$1
       if [ -z $2 ]; then 
         fail_on_error="break_code"
       else
         fail_on_error=$2
       fi 
       write_log "Executing Command --> $1"
       $cmd
       error_code=$?
       if [ ! $fail_on_error = "ignore_errors" ]; then
           check_error $error_code "$cmd"
       fi
}
