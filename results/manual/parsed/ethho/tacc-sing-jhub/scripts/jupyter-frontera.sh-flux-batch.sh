#!/bin/bash
#FLUX: --job-name=tvp_jupyter_sing
#FLUX: --urgency=16

echo "TACC: unloading xalt"
module unload xalt
module load cuda/10.1
module load cudnn nccl tacc-singularity
module list
OPTIND=1
SIF=
DOTENV=
URL=
while getopts "i:e:u:d:" opt; do
    case "$opt" in
    i)  SIF=$OPTARG
        ;;
    e)  DOTENV=$OPTARG
        ;;
    u)  URL=$OPTARG
        ;;
    d)  WD=$OPTARG
        ;;
    esac
done
shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift
echo job $SLURM_JOB_ID execution at: `date`
NODE_HOSTNAME=`hostname -s`
echo "TACC: running on node $NODE_HOSTNAME"
if [ ! -z ${DOTENV} ] ; then
    if [ -f ${DOTENV} ]; then
        echo "using DOTENV=${DOTENV}"
        export $(grep -v '^#' ${DOTENV} | xargs | envsubst)
    else
        echo "could not find env file at DOTENV=${DOTENV}"
        exit 1
    fi
fi
[ -d $WD ] || WD=$PWD
SING_OPTS="--nv --home ${WD} --bind /work2"
echo "TACC: using SINGULARITY_CACHEDIR=${SINGULARITY_CACHEDIR}"
if [ ! -f ${SIF} ]; then
    echo "TACC: pulling Singularity image to ${SIF}"
    singularity pull ${SIF} ${URL}
fi
[ ! -f ${SIF} ] && [ -z $URL ] && echo "Could not find image at ${SIF}, and no DockerHub URL passed" && exit 1
echo "TACC: using singularity version $(singularity version)"
IPYTHON_BIN="singularity exec ${SING_OPTS} ${SIF} $@"
echo "TACC: using IPYTHON_BIN ${IPYTHON_BIN}"
NB_SERVERDIR=$HOME/.jupyter
IP_CONFIG=$NB_SERVERDIR/jupyter_notebook_config.py
mkdir -p $NB_SERVERDIR
rm -f $NB_SERVERDIR/.jupyter_address $NB_SERVERDIR/.jupyter_port $NB_SERVERDIR/.jupyter_status $NB_SERVERDIR/.jupyter_job_id $NB_SERVERDIR/.jupyter_job_start $NB_SERVERDIR/.jupyter_job_duration
JUPYTER_LOGFILE=$NB_SERVERDIR/$NODE_HOSTNAME.log
JUP_CONFIG_PY="/home1/00832/envision/tacc-tvp/server/scripts/frontera/jupyter.tvp.config.py"
IPYTHON_ARGS="--config=${JUP_CONFIG_PY}"
echo "TACC: using jupyter command: $IPYTHON_BIN $IPYTHON_ARGS"
nohup $IPYTHON_BIN $IPYTHON_ARGS &> $JUPYTER_LOGFILE && rm $NB_SERVERDIR/.jupyter_lock &
IPYTHON_PID=$!
echo "$NODE_HOSTNAME $IPYTHON_PID" > $NB_SERVERDIR/.jupyter_lock
echo "TACC: sleeping for 60 seconds..."
sleep 60
JUPYTER_TOKEN=`grep -m 1 'token=' $JUPYTER_LOGFILE | cut -d'?' -f 2`
LOCAL_IPY_PORT=5902
IPY_PORT_PREFIX=2
LOGIN_IPY_PORT=`echo $NODE_HOSTNAME | perl -ne 'print (($2+1).$3.$1) if /c\d(\d\d)-(\d)(\d\d)/;'`
echo "TACC: got login node jupyter port $LOGIN_IPY_PORT"
for i in `seq 4`; do
    ssh -q -f -g -N -R $LOGIN_IPY_PORT:$NODE_HOSTNAME:$LOCAL_IPY_PORT login$i
done
echo "TACC: created reverse ports on Frontera logins"
echo "Your jupyter notebook server is now running!"
echo "Please point your favorite web browser to https://vis.tacc.utexas.edu:$LOGIN_IPY_PORT/?$JUPYTER_TOKEN"
TACC_RUNTIME=`squeue -l -j $SLURM_JOB_ID | grep $SLURM_QUEUE | awk '{print $7}'` # squeue returns HH:MM:SS
if [ x"$TACC_RUNTIME" == "x" ]; then
	TACC_Q_RUNTIME=`sinfo -p $SLURM_QUEUE | grep -m 1 $SLURM_QUEUE | awk '{print $3}'`
	if [ x"$TACC_Q_RUNTIME" != "x" ]; then
		# pnav: this assumes format hh:dd:ss, will convert to seconds below
		#       if days are specified, this won't work
		TACC_RUNTIME=$TACC_Q_RUNTIME
	fi
fi
if [ "x$TACC_RUNTIME" != "x" ]; then
  # there's a runtime limit, so warn the user when the session will die
  # give 5 minute warning for runtimes > 5 minutes
        H=`echo $TACC_RUNTIME | awk -F: '{print $1}'`
        M=`echo $TACC_RUNTIME | awk -F: '{print $2}'`
        S=`echo $TACC_RUNTIME | awk -F: '{print $3}'`
        if [ "x$S" != "x" ]; then
            # full HH:MM:SS present
            H=$(($H * 3600))
            M=$(($M * 60))
            TACC_RUNTIME_SEC=$(($H + $M + $S))
        elif [ "x$M" != "x" ]; then
            # only HH:MM present, treat as MM:SS
            H=$(($H * 60))
            TACC_RUNTIME_SEC=$(($H + $M))
        else
            TACC_RUNTIME_SEC=$S
        fi
  if [ $TACC_RUNTIME_SEC -gt 300 ]; then
        sleep $(($TACC_RUNTIME_SEC - 300)) && echo "$USER's VNC session on $VNC_DISPLAY will end in 5 minutes.  Please save your work now." | wall &
    fi
fi
echo "vis.tacc.utexas.edu" > $NB_SERVERDIR/.jupyter_address
echo "$LOGIN_IPY_PORT/?$JUPYTER_TOKEN" > $NB_SERVERDIR/.jupyter_port
echo "$SLURM_JOB_ID" > $NB_SERVERDIR/.jupyter_job_id
date +%s > $NB_SERVERDIR/.jupyter_job_start
echo "$TACC_RUNTIME_SEC" > $NB_SERVERDIR/.jupyter_job_duration
sleep 5
echo "success" > $NB_SERVERDIR/.jupyter_status
while [ -f $NB_SERVERDIR/.jupyter_lock ]; do
  sleep 30
done
sleep 1
echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
