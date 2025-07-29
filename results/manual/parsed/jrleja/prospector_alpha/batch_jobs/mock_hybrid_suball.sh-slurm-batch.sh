#!/bin/bash
#SBATCH --job-name=mock_hybrid
#SBATCH --output=mock_hybrid_%a.out
#SBATCH --error=mock_hybrid_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=7-00:00:00
#SBATCH --partition=conroy-intel,shared,itc_cluster

srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/mock_hybrid_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--outfile="$APPS"/prospector_alpha/results/mock_hybrid/"${SLURM_ARRAY_TASK_ID}"
