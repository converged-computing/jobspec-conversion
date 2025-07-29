#!/bin/bash
#SBATCH --job-name=3dresnet
#SBATCH --output=console_output/3dresnet_training_%j.txt
#SBATCH --mail-user=kenan.khauto@outlook.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00

export PYTHONPATH='/scratch/vihps/vihps14/env/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/scratch/vihps/vihps14/env/lib/python3.9/site-packages:$PYTHONPATH
source ~/miniconda3/etc/profile.d/conda.sh
conda activate /scratch/vihps/vihps14/env/
cd ~/project/online-gesture-recognition-project/
srun python ./run/run_3dresnet.py
