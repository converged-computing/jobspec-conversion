#!/bin/bash
#SBATCH --account=vminin_lab
#SBATCH --output=precision_experiment-%A-%a.out
#SBATCH --mail-user=bayerd@uci.edu
#SBATCH --mail-type=begin,end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=04:00:00
#SBATCH --partition=standard
#SBATCH --array=1-24

module purge
module load julia/1.8.5
cd //pub/bayerd/semi_parametric_COVID_19_OC_model/
julia --project --threads 1 scripts/precision_experiment.jl $SLURM_ARRAY_TASK_ID
