#!/bin/bash
#SBATCH --output=/home/yy785/projects/adaptation/downstream/OpenPCDet/pcdet/datasets/ithaca365/outputs/slurm/%x_%j_o.txt
#SBATCH --error=/home/yy785/projects/adaptation/downstream/OpenPCDet/pcdet/datasets/ithaca365/outputs/slurm/%x_%j_e.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:0
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00
#SBATCH --partition=default_partition

set -e
. /home/yy785/anaconda3/etc/profile.d/conda.sh
conda activate adaptation
set -x
cd /home/yy785/projects/adaptation/downstream/OpenPCDet/pcdet/datasets/ithaca365
${@}
