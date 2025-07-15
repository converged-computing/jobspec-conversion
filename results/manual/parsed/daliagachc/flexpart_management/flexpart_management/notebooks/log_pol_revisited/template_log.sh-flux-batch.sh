#!/bin/bash
#FLUX: --job-name=hello-snack-4871
#FLUX: --urgency=16

export NETCDF='/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/'
export WRFIO_NCD_LARGE_FILE_SUPPORT='1'

export NETCDF=/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/
module purge
module load gcc/7.3.0  intelmpi/18.0.2 hdf5-par/1.8.20 netcdf4/4.6.1
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
py_script='/homeappl/home/aliagadi/saltena_2018/flexpart_management/flexpart_management/notebooks/log_pol_revisited/log_pol_revisited_log_pol_taito.py'
PY_PATH=$1
echo ${PY_PATH}
srun python3 -u ${py_script} ${PY_PATH}
