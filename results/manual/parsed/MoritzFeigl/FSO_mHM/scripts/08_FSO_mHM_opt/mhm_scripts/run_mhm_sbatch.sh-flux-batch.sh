#!/bin/bash
#FLUX: --job-name=run_mhm
#FLUX: --queue=mem_0128
#FLUX: --urgency=16

cd /home/lv71468/mfeigl/FSO_mHM/2020_fso_mhm/scripts/08_FSO_mHM_opt/mhm_scripts
module load intel/18 intel-mpi/2018 hdf5/1.8.12-MPI pnetcdf/1.10.0 netcdf_C/4.4.1.1 netcdf_Fortran/4.4.4 cmake/3.9.6
bash run_basin_1.sh &
bash run_basin_2.sh &
bash run_basin_3.sh &
bash run_basin_4.sh &
bash run_basin_5.sh &
bash run_basin_6.sh &
bash run_basin_7.sh
