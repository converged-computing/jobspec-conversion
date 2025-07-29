#!/bin/bash
#SBATCH --job-name=flat
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32000
#SBATCH --time=02:00:00
#SBATCH --array=1-5

echo starting_jobscript
module add CUDA/10.1.243-GCC-8.3.0
echo activating environment
source /data/p288722/python_venv/scd_images/bin/activate
nvidia-smi
echo running job 1
python /home/p288722/git_code/scd_images/run_flow.py -fold ${SLURM_ARRAY_TASK_ID} -num_patches 200 -patch_aggregation "majority_vote" -use_contributing_patches 0 -patches_type "homo"
echo jobs completed
