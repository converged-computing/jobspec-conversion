#!/bin/bash
#FLUX: --job-name=jigsaw_bot
#FLUX: --queue=gpu-shared
#FLUX: --urgency=16

DATASET="BOT"
module purge
module load gpu
module load slurm		
module load singularitypro/3.9
module load anaconda3
ENV_NAME="con_jigsaw_env"
if { conda env list | grep $ENV_NAME; } >/dev/null 2>&1; then
    echo "Conda environment for jigsaw already exists"
    echo "Activating conda environment for jigsaw"
else
    echo "Creating conda environment for jigsaw"
    conda create --name $ENV_NAME --file conda_requisites.txt
fi
conda init --all
source ~/.bash_profile
source ~/.bashrc 
conda activate $ENV_NAME
if [ ! -d "data" ]; then
    echo "data folder does not exist, please create the folder and place necessary dataset files."
    echo "Available at: https://github.com/jmoraga-mines/jigsawhsi#requisites"
    echo "Exiting..."
    exit 1;
fi
srun python jigsaw.py $DATASET > $DATASET.results.txt 2>&1
