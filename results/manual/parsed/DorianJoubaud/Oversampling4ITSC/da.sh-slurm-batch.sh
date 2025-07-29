#!/bin/bash
#SBATCH --job-name=DA
#SBATCH --mail-user=dorian.joubaud@uni.lu
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=1-23:59:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-4

echo "== Starting run at $(date)"
echo "== Job ID: ${SLURM_JOBID}, Task ID: ${SLURM_ARRAY_TASK_ID}"
echo "== Node list: ${SLURM_NODELIST}"
echo "== Submit dir. : ${SLURM_SUBMIT_DIR}"
VALUES=(ROS Jitter TW SMOTE ADASYN)
conda activate da
python main_100.py $1 ROCKET ${VALUES[$SLURM_ARRAY_TASK_ID]} 01 2  10 
