#!/bin/bash
#SBATCH --job-name=ipsc-ext_reorg_roi_g2_0_38_ytvis_swinL
#SBATCH --account=def-nilanjan
#SBATCH --output=%x_%j.out
#SBATCH --mail-user=asingh1@ualberta.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16000M
#SBATCH --time=00:48:00

module load cuda cudnn gcc python/3.8
source ~/venv/vnext/bin/activate
nvidia-smi
python3 projects/IDOL/train_net.py --config-file projects/IDOL/configs/idol-ipsc-ext_reorg_roi_g2_0_38_ytvis_swinL.yaml --num-gpus 2 
