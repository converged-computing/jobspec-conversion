#!/bin/bash
#SBATCH --job-name=JCU-CL-MATLAB_experiment_runs_low_res
#SBATCH --output=experiment_runs_low_res_out.txt
#SBATCH --error=experiment_runs_low_res_error.txt
#SBATCH --mail-user=corey.lammie@jcu.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=50g

module load matlab/R2019b
module load cuda/11.3.0
module load gnu8/8.4.0
module load mvapich2
matlab -nodisplay -nosplash -r experiment_runs_low_res
