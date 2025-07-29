#!/bin/bash
#SBATCH --job-name=fms_ekp
#SBATCH --output=output/slurm/array-%A_%a.out
#SBATCH --error=output/slurm/array-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=01:00:00

module load julia/1.8.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
iteration_=${1?Error: no iteration given}
run_num=${SLURM_ARRAY_TASK_ID}
julia output/output_$run_num/input_file
