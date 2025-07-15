#!/bin/bash
#FLUX: --job-name=txla2_nest_NM_kw_2021_rst1
#FLUX: -n=120
#FLUX: --queue=xlong
#FLUX: -t=1728000
#FLUX: --urgency=16

module purge
module load netCDF-Fortran/4.4.4-intel-2018b
WORK_DIR=/scratch/user/d.kobashi/projects/hindcasts/projects/txla2
cd $WORK_DIR
NPROCS=120
OCEAN_IN=${WORK_DIR}/inputs/ocean_in/nest/ocean_txla2_2021_nest_rst1.in
ROMS_EXEC=coawstM_nest_NM_KanthaC
mpirun -np ${NPROCS} ${WORK_DIR}/${ROMS_EXEC} ${OCEAN_IN}
