#!/bin/bash
#FLUX: --job-name=frigid-kitty-2034
#FLUX: --priority=16

export NETCDF='/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/'
export WRFIO_NCD_LARGE_FILE_SUPPORT='1'

export NETCDF=/appl/opt/netcdf4/gcc-7.3.0/intelmpi-18.0.2/4.6.1/
module purge
module load gcc/7.3.0  intelmpi/18.0.2 hdf5-par/1.8.20 netcdf4/4.6.1
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
flex_dir='/homeappl/home/aliagadi/appl_taito/FLEXPART-WRF_v3.3.2'
input_flex=/homeappl/home/aliagadi/wrk/DONOTREMOVE/flexpart_management_data/runs/run_2020-01-03_19-36-06_/2018-05-15/flx_input
cd $flex_dir
exe=flexwrf33_gnu_serial
srun $exe $input_flex
