#!/bin/bash
#FLUX: --job-name=fat-gato-1714
#FLUX: -c=4
#FLUX: --urgency=16

ws=${TRAIN_HOME}
SCRATCH=$ws
FOLDER="${SLURM_JOB_NAME##*@}"
REMAINING="${SLURM_JOB_NAME%@*}"
BASENAME="${REMAINING%%@*}"
BENCH="${REMAINING%@*}"
CONFIG="${REMAINING##*@}"
REMAINING=${BENCH}
IN_DUMMY="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
MD="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
REMAINING=${CONFIG}
LR="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
LD="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
LS="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
ID="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
TS="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
EP="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
BS="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
WD="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
MO="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
DB="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
ST="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
QI="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
QS="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
QF="${REMAINING%%_*}"
REMAINING="${REMAINING#*_}"
cd $SCRATCH
mkdir -p $FOLDER; cd $FOLDER
mkdir -p tmps; cd tmps
mkdir -p $SLURM_JOB_NAME; cd $SLURM_JOB_NAME
tmpPath=$SCRATCH/$FOLDER/tmps/$SLURM_JOB_NAME
cp $ws/schedules/${SLURM_JOB_NAME}.csv $tmpPath/schedule.csv
SING_IMG='path_to/custom.simg'
IN='/datasets/IMAGENET-UNCROPPED'
echo "This machine is Jarvis (for now): $(hostname)"
singularity exec --nv -B /home -B /scratch -B /datasets ${SING_IMG} sh -c "sleep 10; nvidia-smi; cd $tmpPath; mkdir -p dumps; echo running at:$(pwd); bash $ws/run_tune.sh $LR $LD $LS $ID $TS $EP $BS $WD $MO $DB $ST $QI $QS $QF $MD $IN"
