#!/bin/bash
#SBATCH --job-name=simulate_prior
#SBATCH --output=simulate_prior_%a.out
#SBATCH --error=simulate_prior_%a.err
#SBATCH --mail-user=joel.leja@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=4-00:00:00
#SBATCH --partition=shared,conroy,itc_cluster
#SBATCH --constraint=intel

srun -n 1 --mpi=pmi2 python $APPS/prospector_alpha/code/simulate_sfh_prior.py \
--cluster_idx="${SLURM_ARRAY_TASK_ID}" \
--outfile="$APPS"/prospector_alpha/results/priors/
