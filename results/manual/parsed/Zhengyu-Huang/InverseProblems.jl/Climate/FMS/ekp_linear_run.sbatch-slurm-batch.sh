#!/bin/bash
#FLUX: --job-name=fms_ekp
#FLUX: -t=3600
#FLUX: --urgency=16

module load julia/1.8.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
iteration_=${1?Error: no iteration given}
run_num=${SLURM_ARRAY_TASK_ID}
julia output/output_$run_num/input_file
