#!/bin/bash
#SBATCH --job-name=bikenwgrowth
#SBATCH --output=../outs/job.%j.out
#SBATCH --error=../outs/job.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000
#SBATCH --time=2-23:59:00
#SBATCH --partition=red
#SBATCH --array=0-5

module load Anaconda3
. $(conda info --base)/etc/profile.d/conda.sh
conda activate OSMNX
if [ $# > 0 ]; then
    ~/.conda/envs/OSMNX/bin/python analysissupploop.py $1 $SLURM_ARRAY_TASK_ID
fi
