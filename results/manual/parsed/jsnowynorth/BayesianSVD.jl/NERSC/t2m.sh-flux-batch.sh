#!/bin/bash
#FLUX: --job-name=PDO
#FLUX: -c=8
#FLUX: --queue=regular
#FLUX: -t=36000
#FLUX: --urgency=16

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
