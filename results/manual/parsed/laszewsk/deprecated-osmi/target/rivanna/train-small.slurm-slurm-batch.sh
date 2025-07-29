#!/bin/bash
#SBATCH --job-name=small-train-osmi
#SBATCH --account=bii_dsc_community
#SBATCH --output=small-train-osmi-%u-%j.out
#SBATCH --error=small-train-osmi-%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=00:30:00
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
MODEL=small_lstm 
time apptainer exec --nv $CONTAINER_DIR/osmi.sif python train.py $MODEL
