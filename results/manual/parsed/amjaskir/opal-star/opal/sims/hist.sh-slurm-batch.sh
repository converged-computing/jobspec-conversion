#!/bin/bash
#SBATCH --job-name=ranked_SACrit_BayesAnneal
#SBATCH --account=carney-frankmj-condo
#SBATCH --output=./output_grid/ranked_SACrit_BayesAnneal_%j.out
#SBATCH --error=./output_grid/ranked_SACrit_BayesAnneal_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --array=50,100,250,500,1000

echo "Starting job $SLURM_ARRAY_TASK_ID"
python3 complexity_hist_revisions.py "80"				1000 		1000        $SLURM_ARRAY_TASK_ID    "SA"    1   0   10  0 "bmod"
python3 complexity_hist_revisions.py "30"				1000 		1000 		$SLURM_ARRAY_TASK_ID    "SA"    1   0   10  0 "bmod"
