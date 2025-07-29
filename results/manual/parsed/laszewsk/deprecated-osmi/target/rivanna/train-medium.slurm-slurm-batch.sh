#!/bin/bash
#SBATCH --job-name=medium-train-osmi
#SBATCH --account=bii_dsc_community
#SBATCH --output=train-medium-osmi-%u-%j.out
#SBATCH --error=train-osmi-medium-%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=01:00:00
#SBATCH --constraint=a100_80gb

export CONTAINER_DIR='$EXEC_DIR/image-apptainer/'

if [ -z "$EXEC_DIR" ]; then
    echo "EXEC_DIR is not set"
    exit 1
fi
export CONTAINER_DIR=$EXEC_DIR/image-apptainer/
module purge
module load apptainer
nvidia-smi
cd $BASE/osmi/models
MODEL=medium_cnn 
time apptainer exec --nv $CONTAINER_DIR/osmi.sif python train.py $MODEL
