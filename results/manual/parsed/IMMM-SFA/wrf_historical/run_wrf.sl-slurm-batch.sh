#!/bin/bash
#FLUX: --job-name=wrf_conus
#FLUX: -N=7
#FLUX: --queue=regular
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export FOR_IGNORE_EXCEPTIONS='1'
export PNETCDF='${PARALLEL_NETCDF_DIR}'
export HDF5='${HDF5_DIR}'
export WRFIO_NCD_LARGE_FILE_SUPPORT='1'
export WRF_EM_CORE='1'
export JASPERLIB='/global/common/cori/software/jasper/1.900.1/hsw/intel/lib'
export JASPERINC='/global/common/cori/software/jasper/1.900.1/hsw/intel/include'

date
export OMP_NUM_THREADS=1
export FOR_IGNORE_EXCEPTIONS=1
ulimit -s unlimited
module unload craype-haswell
module load craype-mic-knl
module load impi
module load cray-parallel-netcdf
export PNETCDF=${PARALLEL_NETCDF_DIR}
module load cray-hdf5
export HDF5=${HDF5_DIR}
module load png
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
module load jasper
export JASPERLIB=/global/common/cori/software/jasper/1.900.1/hsw/intel/lib
export JASPERINC=/global/common/cori/software/jasper/1.900.1/hsw/intel/include
srun -n 112 -c 4 --cpu_bind=cores ./wrf.exe
date
