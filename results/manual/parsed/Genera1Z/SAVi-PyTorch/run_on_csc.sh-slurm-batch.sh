#!/bin/bash
#SBATCH --job-name=savi
#SBATCH --account=project_2008396
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1,nvme:25
#SBATCH --mem=64G
#SBATCH --time=1-12:00:00

module load pytorch tensorflow vim
pip install -r requirements.txt
cp -r /scratch/project_2008396/Datasets/movi_a/* $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
