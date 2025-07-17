#!/bin/bash
#FLUX: --job-name=swampy-parsnip-9826
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity
echo "started the RunBench at $(date)"
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
cp $ws/schedules/${SLURM_JOB_NAME}.csv $tmpPath/schedule.csv # custom learning rate schedule (if any)
SING_IMG='/home/path_to_custom.simg' # singularity image path
IMAGENET_PATH=your-imagenet-path
echo started data transfer to $SLURM_TMPDIR at: $(date)
tar xzf $IMAGENET_PATH/IMAGENET-UNCROPPED.tar.gz -C $SLURM_TMPDIR 
echo Number of copied files total : $(ls -R  $SLURM_TMPDIR/IMAGENET-UNCROPPED/ | wc -l)
echo finished copying at: $(date)
IN=$SLURM_TMPDIR/IMAGENET-UNCROPPED # run on local node => faster speed
echo "This machine is Beluga: $(hostname)"
singularity exec --nv -B /home -B /scratch ${SING_IMG} sh -c "sleep 10; nvidia-smi; cd $tmpPath; mkdir -p dumps; echo running at:$(pwd); bash $ws/run_tune.sh $LR $LD $LS $ID $TS $EP $BS $WD $MO $DB $ST $QI $QS $QF $MD $IN"
