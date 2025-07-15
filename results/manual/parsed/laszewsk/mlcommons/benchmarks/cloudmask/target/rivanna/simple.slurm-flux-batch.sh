#!/bin/bash
#FLUX: --job-name=simple-cloudmask-gpu-rivanna
#FLUX: --queue=bii-gpu
#FLUX: -t=21600
#FLUX: --priority=16

export USER_SCRATCH='/scratch/$USER'
export PROJECT_DIR='$USER_SCRATCH/mlcommons/benchmarks/cloudmask'
export PYTHON_DIR='$USER_SCRACTH/ENV3'
export PROJECT_DATA='/project/bii_dsc_community/thf2bn/data/cloudmask'
export CONTAINERDIR='.'
export CODE_DIR='$PROJECT_DIR/target/rivanna'

PROGRESS () {
    echo "# ###########################################"
    echo "# cloudmesh status="$1" progress=$2 pid=$$"
    echo "# ###########################################"
}
PROGRESS "running" 1
echo "# ==================================="
echo "# SLURM info"
echo "# ==================================="
echo jobno $SLURM_JOB_ID
echo $USER
PROGRESS "running" 2
echo "# ==================================="
echo "# Set up file system"
echo "# ==================================="
export USER_SCRATCH=/scratch/$USER
export PROJECT_DIR=$USER_SCRATCH/mlcommons/benchmarks/cloudmask
export PYTHON_DIR=$USER_SCRACTH/ENV3
export PROJECT_DATA=/project/bii_dsc_community/thf2bn/data/cloudmask
export CONTAINERDIR=.
export CODE_DIR=$PROJECT_DIR/target/rivanna
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
module load singularity
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
singularity exec --nv ./cloudmask.sif bash -c "cd ${CODE_DIR} ; python -c \"import os; os.system('ls')\""
PROGRESS "running" 10
echo "# ==================================="
echo "# start gpu log"
echo "# ==================================="
cms gpu watch --gpu=0 --delay=0.5 --dense > outputs/simple-$USER-$SLURM_JOB_ID-gpu0.log &
PROGRESS "running" 21
echo "# ==================================="
echo "# start cloudmask"
echo "# ==================================="
singularity exec --nv ./cloudmask.sif bash -c "cd ${CODE_DIR} ; python cloudmask_v2.py --config=config-new.yaml"
PROGRESS "running" 99
seff $SLURM_JOB_ID
PROGRESS "done" 100
echo "Execution Complete"
exit 0
