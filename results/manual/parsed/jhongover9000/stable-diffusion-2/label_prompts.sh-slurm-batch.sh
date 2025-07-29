#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem-per-cpu=40G
#SBATCH --time=3-00:00:00

FILES=(/scratch/jhh508/stable-diffusion-2/*)
module purge
cd /scratch/jhh508/stable-diffusion-2/prompt-labeling/
pwd
eval "$(conda shell.bash hook)"
conda init bash
conda activate stable-diff
module load gcc
echo loaded
chmod +x promptLabeler.py
python promptLabeler.py promptList_full.txt labelList_full_v2.txt
