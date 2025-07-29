#!/bin/bash
#SBATCH --job-name=serene
#SBATCH --output=logs/serene.%J.out
#SBATCH --error=logs/serene.%J.err
#SBATCH --mail-user=mb756@sussex.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=1-00:00:00

module load python/3.8.6
module load cuda/10.1 
module load tensorflow/2.3.1
CONFIG_PATH="$HOME/SegU-Net/config"
source $HOME/nnevn/bin/activate
python segUNet.py $CONFIG_PATH/net_Unet_lc.ini
deactivate
