#!/bin/bash
#SBATCH --job-name=UAV-POS-VERIFY
#SBATCH --output=/dev/null
#SBATCH --mail-user=k.fuger@tuhh.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=02:00:00
#SBATCH --constraint=OS8
#SBATCH --array=0-9999

pyenv shell 3.11.1
python3 main_hpc.py $SLURM_ARRAY_TASK_ID 0
exit
