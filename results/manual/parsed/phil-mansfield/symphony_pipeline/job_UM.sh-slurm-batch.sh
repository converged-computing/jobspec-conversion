#!/bin/bash
#SBATCH --job-name=Group_UM
#SBATCH --output=logs/Group/log.tag.Group_um_%A_%a.oe
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --array=0-48

python3 print_UM.py configs/Group/config.txt ${SLURM_ARRAY_TASK_ID} &&
   python3 write_um_file.py configs/Group/config.txt ${SLURM_ARRAY_TASK_ID} &&
   echo "done"
