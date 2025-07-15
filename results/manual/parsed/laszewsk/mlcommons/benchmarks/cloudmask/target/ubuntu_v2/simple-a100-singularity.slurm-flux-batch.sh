#!/bin/bash
#FLUX: --job-name=a100-cloudmask-gpu-greene
#FLUX: --queue=bii-gpu
#FLUX: -t=7200
#FLUX: --priority=16

export USER_SCRATCH='/scratch/$USER'
export PROJECT_DIR='$USER_SCRATCH/mlcommons/benchmarks/cloudmask'
export PYTHON_DIR='$USER_SCRATCH/ENV3'
export PROJECT_DATA='$USER_SCRATCH/data'

export USER_SCRATCH=/scratch/$USER
export PROJECT_DIR=$USER_SCRATCH/mlcommons/benchmarks/cloudmask
export PYTHON_DIR=$USER_SCRATCH/ENV3
export PROJECT_DATA=$USER_SCRATCH/data
echo "# cloudmesh status=running progress=1 pid=$$"
module purge
module load singularity tensorflow/2.8.0
echo "# cloudmesh status=running progress=2 pid=$$"
source $PYTHON_DIR/bin/activate
which python
echo "# cloudmesh status=running progress=3 pid=$$"
nvidia-smi
echo "# cloudmesh status=running progress=4 pid=$$"
cd $PROJECT_DIR/experiments/rivanna
cms gpu watch --gpu=0 --delay=0.5 --dense > outputs/gpu0.log &
echo "# cloudmesh status=running progress=5 pid=$$"
time singularity run --nv $CONTAINERDIR/tensorflow-2.8.0.sif --bind /scratch:/scratch "cd $PROJECT_DIR/experiments/rivanna; python slstr_cloud.py --config simple-config.yaml"
echo "# cloudmesh status=running progress=99 pid=$$"
seff $SLURM_JOB_ID
echo "# cloudmesh status=running progress=100 pid=$$"
