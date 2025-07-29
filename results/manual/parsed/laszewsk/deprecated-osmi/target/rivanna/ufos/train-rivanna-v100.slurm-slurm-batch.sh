#!/bin/bash
#SBATCH --job-name=train-osmi-rivanna-v100
#SBATCH --account=bii_dsc_community
#SBATCH --output=train-osmi-rivanna-v100-%u-%j.out
#SBATCH --error=train-osmi-rivanna-v100-%u-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32GB
#SBATCH --time=02:00:00

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
