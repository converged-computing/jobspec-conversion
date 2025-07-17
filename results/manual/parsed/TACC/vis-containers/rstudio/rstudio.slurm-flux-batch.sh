#!/bin/bash
#FLUX: --job-name=tap_rstudio
#FLUX: --queue=v100
#FLUX: -t=14400
#FLUX: --urgency=16

export SINGULARITYENV_PASSWORD='$RSTUDIO_PASSWORD '

echo "TACC: job $SLURM_JOB_ID execution started at: `date`"
module load tacc-singularity
RSTUDIO_DIR="/scratch/projects/rstudio"
RSTUDIO_IMG="${RSTUDIO_DIR}/rstudio_1.4.1717.sif"
TAP_FUNCTIONS="/scratch/projects/share/doc/slurm/tap_functions"
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
USERNAME=$(whoami)
NODE_HOSTNAME=`hostname -s`
NODE_HOSTNAME_DOMAIN=`hostname -d`
module unload xalt
RSTUDIO_SERVERDIR=$HOME/.rstudio
mkdir -p $RSTUDIO_SERVERDIR
rm -f $RSTUDIO_SERVERDIR/.rstudio_address \
      $RSTUDIO_SERVERDIR/.rstudio_port \
      $RSTUDIO_SERVERDIR/.rstudio_status \
      $RSTUDIO_SERVERDIR/.rstudio_job_id \
      $RSTUDIO_SERVERDIR/.rstudio_job_start \
      $RSTUDIO_SERVERDIR/.rstudio_job_duration
BIND_ROOT=$HOME/.rstudio/var
mkdir -p $BIND_ROOT/run/rstudio-server 
mkdir -p $BIND_ROOT/lock/rstudio-server
mkdir -p $BIND_ROOT/log/rstudio-server 
mkdir -p $BIND_ROOT/lib/rstudio-server 
echo "TACC: using Rstudio image $RSTUDIO_IMG"
echo "TACC: running on node $NODE_HOSTNAME"
echo "TACC: cleaning temp dir at $HOME/.rstudio"
LOCAL_PORT=8787
RSTUDIO_PASSWORD=`uuidgen`
export SINGULARITYENV_PASSWORD=$RSTUDIO_PASSWORD 
echo "TACC: starting Rstudio server in singularity:"
echo ""
echo "singularity exec -B $BIND_ROOT/run/rstudio-server:/var/run/rstudio-server \ "
echo "                 -B $BIND_ROOT/run/rstudio-server:/var/lock/rstudio-server \ "
echo "                 -B $BIND_ROOT/run/rstudio-server:/var/log/rstudio-server \ "
echo "                 -B $BIND_ROOT/run/rstudio-server:/var/lib/rstudio-server \ "
echo "                 $RSTUDIO_IMG rserver \ "
echo "                 --www-address=0.0.0.0 \ "
echo "                 --www-port=${LOCAL_PORT} \ "
echo "                 --auth-none=0 \ "
echo "                 --auth-pam-helper-path=/usr/local/bin/pam-helper >> $RSTUDIO_SERVERDIR/rstudio.log 2>&1 & "
echo ""
nohup singularity exec -B $BIND_ROOT/run/rstudio-server:/var/run/rstudio-server \
                       -B $BIND_ROOT/lock/rstudio-server:/var/lock/rstudio-server \
                       -B $BIND_ROOT/log/rstudio-server:/var/log/rstudio-server \
                       -B $BIND_ROOT/lib/rstudio-server:/var/lib/rstudio-server \
                       $RSTUDIO_IMG rserver \
                       --www-address=0.0.0.0 \
                       --www-port=${LOCAL_PORT} \
                       --auth-none=0 \
                       --auth-pam-helper-path=/usr/local/bin/pam-helper >> $RSTUDIO_SERVERDIR/rstudio.log 2>&1 && rm -f $RSTUDIO_SERVERDIR/.rstudio_lock &
RSTUDIO_PID=$!
echo "$NODE_HOSTNAME $RSTUDIO_PID" > $RSTUDIO_SERVERDIR/.rstudio_lock
sleep 20
LOGIN_PORT=$(tap_get_port)
for i in `seq 2`; do
    ssh -q -f -g -N -R $LOGIN_PORT:$NODE_HOSTNAME:$LOCAL_PORT login$i
done
echo "TACC: Rstudio launched at $(date)"
echo "TACC: got login node rstudio port $LOGIN_PORT"
echo "TACC: created reverse ports on Longhorn logins"
echo "TACC: Your Rstudio server is now running!"
echo ""
echo "Your instance is now running at http://$NODE_HOSTNAME_DOMAIN:$LOGIN_PORT"
echo "After navigating to that address in your local web browser, authenticate using"
echo "your TACC username the password '$RSTUDIO_PASSWORD'"
echo ""
while [ -f $RSTUDIO_SERVERDIR/.rstudio_lock ]; do
  sleep 10
done
sleep 1
echo "TACC: release port returned: $(tap_release_port ${LOGIN_PORT})"
echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
