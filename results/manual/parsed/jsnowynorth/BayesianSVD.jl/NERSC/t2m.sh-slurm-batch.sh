#!/bin/bash
#SBATCH --job-name=PDO
#SBATCH --account=m1517
#SBATCH --mail-user=jsnorth@lbl.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=10:00:00
#SBATCH --constraint=cpu

export OMP_NUM_THREADS='4'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=4
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
echo "### Starting at: $(date) ###"
ml load julia
module load cray-hdf5
module load cray-netcdf
srun -n 1 -c 8 --cpu_bind=cores julia t2mV2.jl # first run for 1000 and burn 1000 - initializes model
echo "### Ending at: $(date) ###"
