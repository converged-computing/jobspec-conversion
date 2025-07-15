#!/bin/bash
#FLUX: --job-name=swampy-fudge-0065
#FLUX: --urgency=16

export SHELL='/bin/bash'

WORK_DIR=$SCRATCH/SAGE_2022/session1
MSPASS_CONTAINER=$WORK/mspass_tutorial/mspass_latest.sif
DB_PATH='tmp'
export SHELL=/bin/bash
SING_COM="singularity run --home $WORK_DIR $MSPASS_CONTAINER"
module unload xalt
module load tacc-singularity
module list
pwd
date
NODE_HOSTNAME=`hostname -s`
LOGIN_PORT=`echo $NODE_HOSTNAME | perl -ne 'print (($2+1).$3.$1) if /c\d(\d\d)-(\d)(\d\d)/;'`
STATUS_PORT=`echo "$LOGIN_PORT + 1" | bc -l`
echo "got login node port $LOGIN_PORT"
for i in `seq 4`; do
    ssh -q -f -g -N -R $LOGIN_PORT:$NODE_HOSTNAME:8888 login$i
    ssh -q -f -g -N -R $STATUS_PORT:$NODE_HOSTNAME:8787 login$i
done
echo "Created reverse ports on Stampede2 logins"
mkdir -p $WORK_DIR
cd $WORK_DIR
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR \
SINGULARITYENV_MSPASS_SCRATCH_DATA_DIR=$WORK_DIR/wf \
SINGULARITYENV_MSPASS_DB_PATH=$DB_PATH \
SINGULARITYENV_MSPASS_WORK_DIR=$WORK_DIR $SING_COM
