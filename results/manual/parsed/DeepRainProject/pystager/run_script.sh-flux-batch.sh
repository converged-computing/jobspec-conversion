#!/bin/bash
#FLUX: --job-name=chocolate-hope-5788
#FLUX: --queue=batch
#FLUX: -t=36000
#FLUX: --urgency=16

NTASKS=12
module --force purge
module use $OTHERSTAGES
ml Stages/2022
ml GCC/11.2.0
ml GCCcore/.11.2.0
ml ParaStationMPI/5.5.0-1
ml GDAL/3.3.2
ml SciPy-bundle/2021.10
ml xarray/0.20.1
ml mpi4py/3.1.3
ml h5py/3.5.0
ml netCDF/4.8.1
ml netcdf4-python/1.5.7
ml matplotlib/3.4.3
ml CDO/2.0.2
srun --ntasks=${NTASKS} python3 -m mpi4py.futures main.py 
