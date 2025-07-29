#!/bin/bash
#SBATCH --job-name=matlab
#SBATCH --output=/n/janson_lab/lab/sma/CompDA_paper/results/simulation/binary_Y/debug/matlab_%A_%a.out
#SBATCH --error=/n/janson_lab/lab/sma/CompDA_paper/results/simulation/binary_Y/debug/matlab_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:15:00

module load matlab/R2021a-fasrc01
matlab -nodisplay -nosplash -r "i_job=$SLURM_ARRAY_TASK_ID;binary_y_matlab;quit;"
