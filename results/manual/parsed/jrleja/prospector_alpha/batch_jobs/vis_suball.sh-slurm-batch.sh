#!/bin/bash
#SBATCH --job-name=vis
#SBATCH --output=vis_%a.out
#SBATCH --error=vis_%a.err
#SBATCH --mail-user=joel.leja@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=7-00:00:00
#SBATCH --partition=shared

srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/vis_params.py \
--outfile="$APPS"/prospector_alpha/results/vis/vis_"${SLURM_ARRAY_TASK_ID}" \
--filter_key="${SLURM_ARRAY_TASK_ID}"
