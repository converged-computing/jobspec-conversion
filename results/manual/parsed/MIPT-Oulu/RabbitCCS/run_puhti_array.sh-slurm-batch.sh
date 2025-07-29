#!/bin/bash
#SBATCH --job-name=RabbitThickness
#SBATCH --account=project_2002147
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=16000
#SBATCH --time=06:00:00
#SBATCH --partition=small
#SBATCH --array=1-28

module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.4
module load bioconda
DATA_DIR=../../data
echo "Start the job..."
srun ./exp_csc.sh ${SLURM_ARRAY_TASK_ID} ${DATA_DIR}/data
echo "Done the job!"
