#!/bin/bash
#SBATCH --job-name=ekp_init
#SBATCH --output=slurm_ekp_init
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=01:00:00

module load julia/1.8.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
julia preprocess.jl
julia init_calibration.jl
echo 'Ensemble initialized for calibration.'
