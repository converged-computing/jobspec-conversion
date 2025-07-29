#!/bin/bash
#SBATCH --job-name=ces_cont
#SBATCH --output=output/slurm/cont_calibration_%j.out
#SBATCH --error=output/slurm/cont_calibration_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=01:00:00

module load julia/1.8.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
iteration_=${1?Error: no iteration given}
julia sstep_calibration.jl --iteration $iteration_
echo "Ensemble ${iteration_} recovery finished."
