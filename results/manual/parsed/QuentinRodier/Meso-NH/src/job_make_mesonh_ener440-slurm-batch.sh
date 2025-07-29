#!/bin/bash
#SBATCH --job-name=MesoNH-compile
#SBATCH --output=MasterI.eo%j
#SBATCH --error=MasterI.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=debug

cd ${SLURM_SUBMIT_DIR}
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIAUTO-O2
time gmake -j 10
time gmake -j 1 installmaster
