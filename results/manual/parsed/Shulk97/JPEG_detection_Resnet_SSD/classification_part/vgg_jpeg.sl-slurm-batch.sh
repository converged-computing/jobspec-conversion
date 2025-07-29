#!/bin/bash
#SBATCH --output=/home/2017018/tconst01/pao/logs/%J.out
#SBATCH --error=/home/2017018/tconst01/pao/logs/%J.err
#SBATCH --mail-user=thomas.constum@insa-rouen.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --gres=gpu:4
#SBATCH --mem=100000
#SBATCH --time=2-00:00:00
#SBATCH --exclusive

export PYTHONUSERBASE='$HOME/ssd/pao_jpeg_bis/classification_part'
export EXPERIMENTS_OUTPUT_DIRECTORY='/dlocal/run/$SLURM_JOB_ID'
export LOG_DIRECTORY='$HOME/pao/logs/'
export DATASET_PATH_TRAIN='/save/2017018/PARTAGE/'
export DATASET_PATH_VAL='/save/2017018/PARTAGE/'
export PROJECT_PATH='$HOME/ssd/pao_jpeg_bis/classification_part'

module load cuda/9.0
module load python3-DL/3.6.1
export PYTHONUSERBASE=$HOME/ssd/pao_jpeg_bis/classification_part
export EXPERIMENTS_OUTPUT_DIRECTORY=/dlocal/run/$SLURM_JOB_ID
export LOG_DIRECTORY=$HOME/pao/logs/
export DATASET_PATH_TRAIN=/save/2017018/PARTAGE/
export DATASET_PATH_VAL=/save/2017018/PARTAGE/
export PROJECT_PATH=$HOME/ssd/pao_jpeg_bis/classification_part
cd $HOME/ssd/pao_jpeg_bis/classification_part
srun python3 training.py -c config/resnetRGB --archi "resnet_rgb" --use_pretrained_weights "True" --horovod "True"
