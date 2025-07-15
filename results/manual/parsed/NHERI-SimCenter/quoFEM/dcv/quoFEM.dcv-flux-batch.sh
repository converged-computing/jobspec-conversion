#!/bin/bash
#FLUX: --job-name=quirky-parrot-9519
#FLUX: --priority=16

echo "TACC: job $SLURM_JOB_ID execution at: `date`"
NODE_HOSTNAME=`hostname -s`
echo "TACC: running on node $NODE_HOSTNAME"
DCV_SERVER_UP=`systemctl is-active dcvserver`
if [ $DCV_SERVER_UP != "active" ]; then
  echo "TACC:"
  echo "TACC: ERROR - could not confirm dcvserver active, systemctl returned '$DCV_SERVER_UP'"
  echo "TACC: ERROR - Please submit a consulting ticket at the TACC user portal"
  echo "TACC: ERROR - https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create"
  echo "TACC:"
  echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
  exit 1
fi 
XSTARTUP="/tmp/dcv-startup-$USER"
cat <<- EOF > $XSTARTUP
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
. /etc/X11/xinit/xinitrc-common 
EOF
  echo "exec startxfce4" >> $XSTARTUP 
chmod a+rx $XSTARTUP
if [ -f /tmp/.X11-unix/X0 ]; then
  echo "TACC:"
  echo "TACC: ERROR - X0 socket already exists. DCV script will fail."
  echo "TACC: ERROR - Please submit a consulting ticket at the TACC user portal"
  echo "TACC: ERROR - https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create"
  echo "TACC:"
  echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
  exit 1
fi
DCV_HANDLE="$USER-session"
dcv create-session --init=$XSTARTUP $DCV_HANDLE
if ! `dcv list-sessions | grep -q $USER`; then
  echo "TACC:"
  echo "TACC: ERROR - could not find a DCV session for $USER"
  echo "TACC: ERROR - This could be because all DCV licenses are in use."
  echo "TACC: ERROR - Consider using job.dcv2vnc which launches VNC if DCV is not available."
  echo "TACC: ERROR - If you receive this message repeatedly, "
  echo "TACC: ERROR - please submit a consulting ticket at the TACC user portal:"
  echo "TACC: ERROR - https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create"
  echo "TACC:"
  echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
  exit 1
fi
LOCAL_VNC_PORT=8443  # default DCV port
echo "TACC: local (compute node) DCV port is $LOCAL_VNC_PORT"
LOGIN_VNC_PORT=`echo $NODE_HOSTNAME | perl -ne 'print (($2+1).$3.$1) if /c\d(\d\d)-(\d)(\d\d)/;'`
if `echo ${NODE_HOSTNAME} | grep -q c2`; then
    # on a c200 node, bump the login port 
    LOGIN_VNC_PORT=$(($LOGIN_VNC_PORT + 36000))
fi
echo "TACC: got login node DCV port $LOGIN_VNC_PORT"
for i in `seq 4`; do
    ssh -q -f -g -N -R $LOGIN_VNC_PORT:$NODE_HOSTNAME:$LOCAL_VNC_PORT login$i
done
echo "TACC: Created reverse ports on Frontera logins"
echo "TACC: Your DCV session is now running!"
echo "TACC: To connect to your DCV session, please point a modern web browser to:"
echo "TACC:          https://frontera.tacc.utexas.edu:$LOGIN_VNC_PORT"
TACC_RUNTIME=`squeue -j $SLURM_JOB_ID -h --format '%l'`
if [ x"$TACC_RUNTIME" == "x" ]; then
	TACC_Q_RUNTIME=`sinfo -p $SLURM_QUEUE | grep -m 1 $SLURM_QUEUE | awk '{print $3}'`
	if [ x"$TACC_Q_RUNTIME" != "x" ]; then
		# pnav: this assumes format hh:dd:ss, will convert to seconds below
		#       if days are specified, this won't work
		TACC_RUNTIME=$TACC_Q_RUNTIME
	fi
fi
mkdir -p $HOME/.tap
TAP_LOCKFILE=${HOME}/.tap/${SLURM_JOB_ID}.lock
DISPLAY=:0 xterm -fg white -bg red3 +sb -geometry 55x2+0+0 -T 'END SESSION HERE' -e "echo 'TACC: Press <enter> in this window to end your session' && read && rm ${TAP_LOCKFILE}" &
sleep 1
DISPLAY=:0 source /work2/00477/tg457427/frontera/quoFEM/build/run_quoFEM.sh & 
echo $(date) > ${TAP_LOCKFILE}
while [ -f ${TAP_LOCKFILE} ]; do
    sleep 1
done
echo "TACC: closing DCV session" 
dcv close-session $DCV_HANDLE
sleep 1
find /tmp/.X11-unix -user $USER -exec rm -f '{}' \;
echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
