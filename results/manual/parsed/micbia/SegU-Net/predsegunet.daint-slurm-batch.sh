#!/bin/bash
#SBATCH --job-name=pred_segunet
#SBATCH --account=sk09
#SBATCH --output=logs/segunet.%j.out
#SBATCH --error=logs/segunet.%j.err
#SBATCH --mail-user=michele.bianco@epfl.ch
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu

module load daint-gpu
module load gcc/9.3.0
module load cudatoolkit/10.2.89_3.28-2.1__g52c0314
module load TensorFlow/2.4.0-CrayGNU-21.09
CONFIG_PATH="$SCRATCH/output_segunet/outputs/all24-09T23-36-45_128slice"
source /project/c31/codes/miniconda3/etc/profile.d/conda.sh
conda activate segunet-env
python pred_segUNet.py $CONFIG_PATH/net_Unet_lc.ini
conda deactivate
