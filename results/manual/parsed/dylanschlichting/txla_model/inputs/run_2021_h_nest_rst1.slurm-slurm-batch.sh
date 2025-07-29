#!/bin/bash
#SBATCH --job-name=txla2_nest_NM_kw_2021_rst1
#SBATCH --output=/scratch/user/d.kobashi/projects/hindcasts/projects/txla2/roms_logs/txla2_nest_NM_kw_2021_rst1.%j
#SBATCH --nodes=1
#SBATCH --ntasks=120
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=20-00:00:00
#SBATCH --partition=xlong
#SBATCH --constraint=ntasks-per-node=20

module purge
module load netCDF-Fortran/4.4.4-intel-2018b
WORK_DIR=/scratch/user/d.kobashi/projects/hindcasts/projects/txla2
cd $WORK_DIR
NPROCS=120
OCEAN_IN=${WORK_DIR}/inputs/ocean_in/nest/ocean_txla2_2021_nest_rst1.in
ROMS_EXEC=coawstM_nest_NM_KanthaC
mpirun -np ${NPROCS} ${WORK_DIR}/${ROMS_EXEC} ${OCEAN_IN}
