#!/bin/bash
#SBATCH --job-name=mock_timebin_lm
#SBATCH --output=mock_timebin_lm_%a.out
#SBATCH --error=mock_timebin_lm_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=5-00:00:00
#SBATCH --partition=conroy,shared
#SBATCH --constraint=intel

srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/mock_timebin_lm_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--outfile="$APPS"/prospector_alpha/results/mock_timebin_lm/"${SLURM_ARRAY_TASK_ID}"
