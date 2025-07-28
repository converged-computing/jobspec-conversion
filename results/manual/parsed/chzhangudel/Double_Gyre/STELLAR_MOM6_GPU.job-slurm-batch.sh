#!/bin/bash
#FLUX: --job-name=MOM6
#FLUX: -t=3600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/lib64:/home/cz3321/torch_gpu/lib'

rm -rf *.nc
module purge
module load anaconda3/2021.5 intel/2021.1.2 openmpi/intel-2021.1/4.1.0 hdf5/intel-2021.1/1.10.6 netcdf/intel-19.1/hdf5-1.10.6/4.7.4 cudatoolkit/11.3 
source activate ~/torch_gpu
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64:/home/cz3321/torch_gpu/lib
srun -n 16 ../../../build/intel/ocean_only/repro/MOM6
