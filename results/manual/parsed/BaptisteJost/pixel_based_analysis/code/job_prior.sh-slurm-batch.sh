#!/bin/bash
#SBATCH --job-name=prior_precision_testjaccosmo
#SBATCH --mail-user=jost@apc.in2p3.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
srun -n 8 -c 16 --cpu_bind=cores python /global/homes/j/jost/these/pixel_based_analysis/code/prior_precison_gridding.py
srun -n 1 -c 64 --cpu_bind=cores python /global/homes/j/jost/these/pixel_based_analysis/code/graph_prior_precision.py
