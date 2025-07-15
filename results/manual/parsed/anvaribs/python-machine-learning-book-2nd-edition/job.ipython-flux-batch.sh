#!/bin/bash
#FLUX: --job-name=astute-parrot-5715
#FLUX: --priority=16

echo job $JOB_ID execution at: `date`
NODE_HOSTNAME=`hostname -s`
echo "TACC: running on node $NODE_HOSTNAME"
NODE_MEMORY=`free -k | grep ^Mem: | awk '{ print $2; }'`
NODE_MEMORY_LIMIT=`echo "0.95 * $NODE_MEMORY / 1" | bc`
ulimit -v $NODE_MEMORY_LIMIT -m $NODE_MEMORY_LIMIT
echo "TACC: memory limit set to $NODE_MEMORY_LIMIT kilobytes"
IPYTHON_BIN=`which ipython`
echo "TACC: using ipython binary $IPYTHON_BIN"
NB_SERVERDIR=$HOME/.ipython/profile_default
IP_CONFIG=$NB_SERVERDIR/ipython_notebook_config.py
mkdir -p $NB_SERVERDIR
if [ \! -e $IP_CONFIG ] ; then
	echo 
	echo "==========================================================================="
	echo "   You must run 'ipython.password' once before launching an iPython session"
	echo "==========================================================================="
	echo
	exit 1
fi
grep "^[^#;]" $IP_CONFIG | grep -q "c.NotebookApp.password"
NOPASS=$?
if [ $NOPASS != 0 ] ; then
       echo 
       echo "==========================================================================="
       echo "   You must run 'ipython.password' once before launching an iPython session"
       echo "==========================================================================="
       echo
       exit 1
fi
IPYTHON_ARGS="notebook --port 5902 --ip=* --no-browser --logfile=$HOME/.ipython/ipython.$NODE_HOSTNAME.log --config=/home/00832/envision/tacc-tvp/server/scripts/maverick/iPython/ipython.tvp.config.py"
nohup $IPYTHON_BIN $IPYTHON_ARGS &> /dev/null && rm $HOME/.ipython.lock &
IPYTHON_PID=$!
echo "$NODE_HOSTNAME $IPYTHON_PID" > $HOME/.ipython.lock
LOCAL_IPY_PORT=5902
IPY_PORT_PREFIX=2
LOGIN_IPY_PORT="$((49+$IPY_PORT_PREFIX))`echo $NODE_HOSTNAME | perl -ne 'print $1.$2.$3 if /c\d\d(\d)-(\d)\d(\d)/;'`"
echo "TACC: got login node ipython port $LOGIN_IPY_PORT"
for i in `seq 3`; do
    echo ====== ssh -f -g -N -R $LOGIN_IPY_PORT:$NODE_HOSTNAME:$LOCAL_IPY_PORT login$i
    ssh -f -g -N -R $LOGIN_IPY_PORT:$NODE_HOSTNAME:$LOCAL_IPY_PORT login$i
done
echo "TACC: created reverse ports on Maverick logins"
echo "Your ipython notebook server is now running!"
echo "Please point your favorite web browser to https://vis.tacc.utexas.edu:$LOGIN_IPY_PORT"
echo "vis.tacc.utexas.edu" > $HOME/.ipython_address
echo "$LOGIN_IPY_PORT" > $HOME/.ipython_port
echo "success" > $HOME/.ipython_status
echo "$SLURM_JOB_ID" > $HOME/.ipython_job_id
date +%s > $HOME/.ipython_job_start
echo "4" > $HOME/.ipython_job_duration
TACC_RUNTIME=`squeue -l -j $SLURM_JOB_ID | grep $SLURM_QUEUE | awk '{print $7}'` # squeue returns HH:MM:SS
if [ x"$TACC_RUNTIME" == "x" ]; then
	TACC_Q_RUNTIME=`sinfo -p $SLURM_QUEUE | grep -m 1 $SLURM_QUEUE | awk '{print $3}'`
	if [ x"$TACC_Q_RUNTIME" != "x" ]; then
		# pnav: this assumes format hh:dd:ss, will convert to seconds below
		#       if days are specified, this won't work
		TACC_RUNTIME=$TACC_Q_RUNTIME
	fi
fi
if [ x"$TACC_RUNTIME" != "x" ]; then
	# there's a runtime limit, so warn the user when the session will die
	# give 5 minute warning for runtimes > 5 minutes
        H=$((`echo $TACC_RUNTIME | awk -F: '{print $1}'` * 3600))		
        M=$((`echo $TACC_RUNTIME | awk -F: '{print $2}'` * 60))		
        S=`echo $TACC_RUNTIME | awk -F: '{print $3}'`
        TACC_RUNTIME_SEC=$(($H + $M + $S))
	if [ $TACC_RUNTIME_SEC -gt 300 ]; then
        	TACC_RUNTIME_SEC=`expr $TACC_RUNTIME_SEC - 300`
        	sleep $TACC_RUNTIME_SEC && wall "$USER's iPython notebook session on $VNC_DISPLAY will end in 5 minutes.  Please save your work now." | wall &
        fi
fi
while [ -f $HOME/.ipython.lock ]; do
  sleep 30
done
sleep 1
echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
