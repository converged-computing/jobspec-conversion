#!/bin/bash

#SBATCH --job-name=cloudmask-gpu-rivanna
#SBATCH --nodes=1
#SBATCH --gres=gpu:v100:1
#SBATCH --time=06:00:00
#SBATCH --mem=64G
#SBATCH -o outputs/%u-%j.out
#SBATCH -e outputs/%u-%j.err
#SBATCH --partition=bii-gpu
#SBATCH --account=bii_dsc_community

export USER_SCRATCH=/scratch/$USER
export PROJECT_DIR=$USER_SCRATCH/mlcommons/benchmarks/cloudmask
# export PYTHON_DIR=$USER_SCRATCH/ENV3
export PYTHON_DIR=$HOME/ENV3
export PROJECT_DATA=/project/bii_dsc_community/thf2bn/data/cloudmask
export CONTAINERDIR=.

export CODE_DIR=$PROJECT_DIR/target/rivanna

module purge
module load singularity

# module load  gcc/9.2.0  cuda/11.0.228  openmpi/3.1.6 python/3.8.8
# module load singularity tensorflow/2.8.0



source $PYTHON_DIR/bin/activate

echo "# ==================================="
echo "# check environment"
echo "# ==================================="

which python

nvidia-smi

echo "# ==================================="
echo "# go to codedir"
echo "# ==================================="

cd $CODE_DIR


echo "# ==================================="
echo "# check filesystem"
echo "# ==================================="
pwd
ls
singularity exec --nv ./cloudmask.sif bash -c "cd ${CODE_DIR} ; python -c \"import os; os.system('ls')\""


echo "# ==================================="
echo "# start gpu log and cloudmask"
echo "# ==================================="
#
# START THE
#
cms gpu watch --gpu=0 --delay=0.5 --dense > outputs/gpu0.log &
singularity exec --nv ./cloudmask.sif bash -c "cd ${CODE_DIR} ; python cloudmask_v2.py --config=jp-config-new.yaml"

seff $SLURM_JOB_ID
