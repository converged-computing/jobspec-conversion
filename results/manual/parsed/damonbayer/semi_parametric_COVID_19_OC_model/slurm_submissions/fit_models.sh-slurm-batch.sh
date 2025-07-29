#!/bin/bash
#SBATCH --account=vminin_lab
#SBATCH --output=fit_models-%A-%a.out
#SBATCH --mail-user=bayerd@uci.edu
#SBATCH --mail-type=begin,end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=16:00:00
#SBATCH --partition=standard
#SBATCH --array=309,310,311,312,317,318,319,320

module purge
module load julia/1.8.5
cd //pub/bayerd/semi_parametric_COVID_19_OC_model/
julia --project --threads 1 scripts/fit_model.jl $SLURM_ARRAY_TASK_ID
