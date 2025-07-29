#!/bin/bash
#FLUX: --job-name=NS
#FLUX: -n=20
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load julia/1.6.0 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
julia -p 20 NN-Data-Par.jl
