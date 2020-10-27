#!/bin/bash

# Terminate Flag : An alternative method for terminating the repeatable loop
# Can be used to terminate the script when the "Repeatable" function is keeping
# The script active
TERMFLAG=/tmp/terminate.flag

# Used to kill any exectuable that is keeping this script going (if PID can be obtained)
PIDP=""

# RUNCMD Flag : If not empty/null, run this instead of Repeatable root
# RUNCMD

# If Proxy settings are needed
#PROXY=proxy.noc.stonybrook.edu:8080

#http_proxy=http://${PROXY}
#https_proxy=https://${PROXY}

#export http_proxy
#export https_proxy

# Clean Child Processes and Other Minutia
function CleanUp()
{
	kill %Repeatable

	# Cleanup code goes here

	if [ ! "${PIDP}" = "" ]; then
		kill -s TERM ${PIDP}
	fi
}

# Function that carries out repeatable tasks in the container to keep it running
function Repeatable()
{
	while [ ! -f "${TERMFLAG}" ]; do
		timestamp=$(date "+%Y%m%d_%H%M%S")

		# Do something

		sleep 5m
	done

	if [ -f "${TERMFLAG}" ]; then
		rm "${TERMFLAG}"
		CleanUp
	fi
}

trap CleanUp HUP INT QUIT TERM

# Two Modes
# Background "Repeatable" and exec a non terminating script, function, application or daemon run non-detached
# OR
# Simply do not background Repeatable
#
# Both examples are given below

#
# Background Repeatable with interactive daemon
#

#Repeatable &

# Execute something that won't terminate
#/usr/sbin/apachectl -D FOREGROUND

#
# Leave Repeatable Running
#

[ "${RUNCMD}" = "" ] && Repeatable
[ ! "${RUNCMD}" == "" ] && ${RUNCMD}
