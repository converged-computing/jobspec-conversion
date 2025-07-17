#!/bin/bash
#FLUX: --job-name=psycho-cat-4710
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

echo "started the RunBench at $(date)"
module load python/3.6
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install torch torchvision --no-index
pip install matplotlib tensorboardX --no-index
pip install pandas numpy --no-index
pip install progress
pip install --extra-index-url https://developer.download.nvidia.com/compute/redist/cuda/10.0 nvidia-dali
pip install $ws/utils/torch_qe/setup.py
ws=${TRAIN_HOME}
SCRATCH=$ws 
FOLDER="${SLURM_JOB_NAME##*@}"
REMAINING="${SLURM_JOB_NAME%@*}"
BASENAME="${REMAINING%%@*}"
BENCH="${REMAINING%@*}"
CONFIG="${REMAINING##*@}"
                                                                                                                                                                                                                                                                                                                             #----- BENCH ------------------
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
IMAGENET='/path_to/IMAGENET-UNCROPPED' 
echo started copying to $SLURM_TMPDIR at: $(date) 
mkdir $SLURM_TMPDIR/IMAGENET-UNCROPPED
mkdir $SLURM_TMPDIR/IMAGENET-UNCROPPED/train
mkdir $SLURM_TMPDIR/IMAGENET-UNCROPPED/val
avail=$(df --output=avail $SLURM_TMPDIR | tail -1)
need=$(echo '130 * 1024 * 1024' | bc)
if [[ $avail > $need ]]
then
    echo 'Enough space on localscratch!'
    ls  -1 $IMAGENET/val   | xargs -n1 -P16 -I% rsync --info=progress2 --chown=your-user:your-group -r $IMAGENET/val/%   $SLURM_TMPDIR/IMAGENET-UNCROPPED/val
    echo Number of copied val files: $(ls -R  $SLURM_TMPDIR/IMAGENET-UNCROPPED/ | wc -l)
    echo finished copying val at: $(date)
    ls  -1 $IMAGENET/train | xargs -n1 -P16 -I% rsync --info=progress2 --chown=your-user:your-group -r $IMAGENET/train/% $SLURM_TMPDIR/IMAGENET-UNCROPPED/train
    copied=$(ls -R  $SLURM_TMPDIR/IMAGENET-UNCROPPED/ | wc -l)
    echo Number of copied files total : $copied
    echo finished copying at: $(date)
    if [[ $copied > 1330000 ]]
    then
        echo properly copied!
        IN=$SLURM_TMPDIR/IMAGENET-UNCROPPED # run on local node => faster speed
        echo "This machine is cedar: $(hostname)"
        nvidia-smi; cd $tmpPath; echo running at:$(pwd); bash $ws/run_tune.sh $LR $LD $LS $ID $TS $EP $BS $WD $MO $DB $ST $QI $QS $QF $MD $IN
    else
        echo not enough space or dead rsync or bad copy!
    fi
else
    echo 'not enough space on localscratch'
    echo trying to find a prev copy!
    PREV_COPY=$(bash $ws/check_node.sh )
    if [[ '' !=  $PREV_COPY ]]
    then 
        echo found prev copy here: $PREV_COPY; 
        IN=$PREV_COPY
        nvidia-smi; cd $tmpPath; echo running at:$(pwd); bash $ws/run_tune.sh $LR $LD $LS $ID $TS $EP $BS $WD $MO $DB $ST $QI $QS $QF $MD $IN
    else
        echo no copy no space! Wth!; 
    fi
fi
