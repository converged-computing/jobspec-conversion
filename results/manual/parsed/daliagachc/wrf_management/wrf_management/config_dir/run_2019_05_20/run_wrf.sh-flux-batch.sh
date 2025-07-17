#!/bin/bash
#FLUX: --job-name=WRF_forecast
#FLUX: -n=48
#FLUX: --queue=parallel
#FLUX: -t=259200
#FLUX: --urgency=16

export NETCDF='/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/'
export WRFIO_NCD_LARGE_FILE_SUPPORT='1'

export NETCDF=/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/
module purge
module load gcc/7.3.0  intelmpi/18.0.2 hdf5-par/1.8.20 netcdf4/4.6.1
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
exe_wrf=wrf.exe
srun ${exe_wrf}
