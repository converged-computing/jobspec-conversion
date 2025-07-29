#!/bin/bash
#SBATCH --job-name=parallel
#SBATCH --output=output-%a.txt
#SBATCH --error=errors-%a.txt
#SBATCH --mail-user=daniel.weiss@yale.edu
#SBATCH --mail-type=START,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=01:00:00
#SBATCH --array=0-5

NUM_LIST=($(seq 0 1 5))
echo "rng seed = " ${NUM_LIST[${SLURM_ARRAY_TASK_ID}]}
module load miniconda
conda activate qram_fidelity
python expensive_job.py --N=1000 --r=${NUM_LIST[${SLURM_ARRAY_TASK_ID}]}
