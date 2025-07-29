#!/bin/bash
#SBATCH --job-name=train-osmi
#SBATCH --account=bii_dsc_community
#SBATCH --output=train-osmi-%u-%j.out
#SBATCH --error=train-osmi-%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=02:00:00
#SBATCH --constraint=a100_80gb

NAME=cloudmesh-rivanna
PROJECT_DIR="$PROJECT/osmi"
RUN_DIR="$PROJECT_DIR/machine/rivanna"
MODEL_DIR="$PROJECT_DIR/models"
module purge
module load singularity
nvidia-smi
source $PROJECT_DIR/ENV3/bin/activate
cd $MODEL_DIR
singularity exec --nv $RUN_DIR/$NAME.sif python train.py small_lstm
