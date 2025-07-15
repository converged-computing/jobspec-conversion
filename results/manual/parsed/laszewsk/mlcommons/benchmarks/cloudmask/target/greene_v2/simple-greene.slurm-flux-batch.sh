#!/bin/bash
#FLUX: --job-name=simple-cloudmask-gpu-greene
#FLUX: -t=7200
#FLUX: --priority=16

export USER_SCRATCH='/scratch/$USER/github-fork'
export PROJECT_DIR='$USER_SCRATCH/mlcommons/benchmarks/cloudmask'
export PYTHON_DIR='$USER_SCRACTH/ENV3'
export PROJECT_DATA='/scratch/$USER/data'
export CONTAINERDIR='.'
export CODE_DIR='$PROJECT_DIR/target/greene_v2'

PROGRESS () {
    echo "# ###########################################"
    echo "# cloudmesh status="$1" progress=$2 pid=$$"
    echo "# ###########################################"
}
PROGRESS "running" 1
echo "# ==================================="
echo "# SLURM info"
echo "# ==================================="
echo jobid $SLURM_JOB_ID
echo user $USER
PROGRESS "running" 2
echo "# ==================================="
echo "# Set up file system"
echo "# ==================================="
export USER_SCRATCH=/scratch/$USER/github-fork
export PROJECT_DIR=$USER_SCRATCH/mlcommons/benchmarks/cloudmask
export PYTHON_DIR=$USER_SCRACTH/ENV3
export PROJECT_DATA=/scratch/$USER/data
export CONTAINERDIR=.
export CODE_DIR=$PROJECT_DIR/target/greene_v2
PROGRESS "running" 3
if [ -n $SLURM_JOB_ID ] ; then
THEPATH=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
else
THEPATH=$(realpath $0)
fi
LOCATION=$(dirname $THEPATH)
echo "LOCATION:", $LOCATION
echo "THEPATH:", $THEPATH
echo
echo "USER_SCRATCH: $USER_SCRATCH"
echo "PROJECT_DIR:  $PROJECT_DIR"
echo "PYTHON_DIR:   $PYTHON_DIR"
echo "PROJECT_DATA: $PROJECT_DATA"
echo "CONTAINERDIR: $CONTAINERDIR"
PROGRESS "running" 4
echo "# cloudmesh status=running progress=2 pid=$$"
module purge
module load cudnn/8.6.0.163-cuda11
PROGRESS "running" 4
source $PYTHON_DIR/bin/activate
which python
nvidia-smi
PROGRESS "running" 8
echo "# ==================================="
echo "# go to codedir"
echo "# ==================================="
cd $CODE_DIR
PROGRESS "running" 9
echo "# ==================================="
echo "# check filesystem"
echo "# ==================================="
pwd
ls
PROGRESS "running" 10
echo "# ==================================="
echo "# start gpu log"
echo "# ==================================="
cms gpu watch --gpu=0 --delay=0.5 --dense > outputs/simple-$USER-$SLURM_JOB_ID-gpu0.log &
PROGRESS "running" 21
echo "# ==================================="
echo "# start cloudmask"
echo "# ==================================="
python cloudmask_v2.py --config=simple-config-greene.yaml
PROGRESS "running" 99
seff $SLURM_JOB_ID
PROGRESS "done" 100
echo "Execution Complete"
exit 0
