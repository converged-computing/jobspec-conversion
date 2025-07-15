#!/bin/bash
#FLUX: --job-name=confused-leader-4844
#FLUX: --urgency=16

export DISPLAY=':${VNC_DISPLAY}'

TAP_FUNCTIONS="/share/doc/slurm/tap_functions"
if [ -f ${TAP_FUNCTIONS} ]; then
    . ${TAP_FUNCTIONS}
else
    echo "TACC:"
    echo "TACC: ERROR - could not find TAP functions file: ${TAP_FUNCTIONS}"
    echo "TACC: ERROR - Please submit a consulting ticket at the TACC user portal"
    echo "TACC: ERROR - https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create"
    echo "TACC:"
    echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
    exit 1
fi
echo "TACC: job ${SLURM_JOB_ID} execution at: $(date)"
NODE_HOSTNAME=$(hostname -s)
echo "TACC: running on node ${NODE_HOSTNAME}"
VNCSERVER_BIN=$(which vncserver 2> /dev/null)
echo "TACC: using default VNC server ${VNCSERVER_BIN}"
if [ -z ${VNCSERVER_BIN} ]; then
    echo "TACC:" 
    echo "TACC: ERROR - could not find the vncserver"
    echo "TACC: ERROR - please submit a ticket at the TACC User Portal."
    echo "TACC: ERROR - https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create"
    echo "TACC:"
    echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
    exit 1
fi
if [ ! -f ${HOME}/.vnc/passwd ] ; then
    echo "TACC:" 
    echo "TACC: ERROR - You must run 'vncpasswd' once before launching a vnc session"
    echo "TACC:"
    echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
    exit 1
fi
CONDA=$(which conda 2> /dev/null)
if [ ! -z "${CONDA}" ]; then
    CONDA_ENV=$(conda info | grep active | cut -d ":" -f 2)
    if [[ ! "${CONDA_ENV}" =~ "None" ]]; then 
        echo "TACC:"
        echo "TACC: ERROR - active conda installation detected, which will break VNC"
        echo "TACC: ERROR - deactivate conda with 'conda deactivate'"
        echo "TACC: ERROR - then resubmit this job script"
        echo "TACC: ERROR - Questions? Please submit a consulting ticket"
        echo "TACC: ERROR - https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create"
        echo "TACC:"
        echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
        exit 1
    fi
fi
VNC_ARGS="-localhost $@"
VNC_DISPLAY=`${VNCSERVER_BIN} ${VNC_ARGS} 2>&1 | grep desktop | awk -F: '{print $3}'`
echo "TACC: got VNC display :${VNC_DISPLAY}"
if [ -z "${VNC_DISPLAY}" ]; then
    echo "TACC:"
    echo "TACC: ERROR - Error launching vncserver: ${VNCSERVER}"
    echo "TACC: Please submit a ticket to the TACC User Portal"
    echo "TACC: https://portal.tacc.utexas.edu/"
    echo "TACC:"
    echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
    exit 1
fi
LOCAL_VNC_PORT=$(( 5900 + ${VNC_DISPLAY}))
echo "TACC: local (compute node) VNC port is $LOCAL_VNC_PORT"
LOGIN_PORT=$(tap_get_port)
echo "TACC: got login node VNC port $LOGIN_PORT"
TUNNEL_CMD="ssh -q -g -f -N -o StrictHostKeyChecking=no -L localhost:${LOGIN_PORT}:localhost:${LOCAL_VNC_PORT} ${NODE_HOSTNAME}"
for i in $(seq 3); do
    ssh -q -o StrictHostKeyChecking=no login$i "${TUNNEL_CMD}" &
done
echo "TACC: created reverse ports on Lonestar6 logins"
echo "TACC: Your VNC server is now running!"
echo "TACC: To connect via VNC client, create a local ssh tunnel to Lonestar6 using:"
echo "TACC:     ssh -f -N -L ${LOGIN_PORT}:localhost:${LOGIN_PORT} ${USER}@ls6.tacc.utexas.edu"
echo "TACC: Then connect your vncviewer to localhost:${LOGIN_PORT}"
export DISPLAY=":${VNC_DISPLAY}"
vglclient >& /dev/null &
VGL_PID=$!
mkdir -p ${HOME}/.tap # this should exist at this point, but just in case...
TAP_LOCKFILE=${HOME}/.tap/${SLURM_JOB_ID}.lock
DISPLAY=:1 xterm -fg white -bg red3 +sb -geometry 55x2+0+0 -T 'END SESSION HERE' -e "echo 'TACC: Press <enter> in this window to end your session' && read && rm ${TAP_LOCKFILE}" &
sleep 1
DISPLAY=:1 xterm -ls -geometry 80x24+100+50 &
echo $(date) > ${TAP_LOCKFILE}
while [ -f ${TAP_LOCKFILE} ]; do
    sleep 1
done
echo "TACC: Killing VGL client"
kill $VGL_PID
echo "TACC: Killing VNC server" 
vncserver -kill $DISPLAY
echo "TACC: release port returned $(tap_release_port ${LOGIN_PORT} 2> /dev/null)"
sleep 1
echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
