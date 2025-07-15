#!/bin/bash
#FLUX: --job-name=ornery-lamp-7419
#FLUX: -t=60
#FLUX: --priority=16

export DMTCP_QUIET='2'

. /etc/profile.d/modules.sh
module purge
module load rhel7/default-peta4
module load dmtcp/2.6.0-intel-17.0.4
ulimit -s 8192
echo "This is job" $SLURM_ARRAY_TASK_ID
jobDir=Job_$SLURM_ARRAY_TASK_ID
mkdir $jobDir
cd $jobDir
RESTARTSCRIPT="dmtcp_restart_script.sh"
export DMTCP_QUIET=2
runcmd="../example_array 5"
tint=30
echo "Start coordinator"
date
eval "dmtcp_coordinator --daemon --coord-logfile dmtcp_log.txt --exit-after-ckpt --exit-on-last -i "$tint" --port-file cport.txt -p 0"
sleep 2
cport=$(<cport.txt)
echo "$cport"
h=`hostname`
echo $h
if [ -f "$RESTARTSCRIPT" ]
then
    echo "Resume the application"
    CMD="dmtcp_restart -p "$cport" -i "$tint" ckpt*.dmtcp"
    echo $CMD
    eval $CMD
else
    echo "Start the application"
    CMD="dmtcp_launch --rm --infiniband --no-gzip -h localhost -p "$cport" "$runcmd
    echo $CMD
    eval $CMD
fi
echo "Stopped program execution"
date
