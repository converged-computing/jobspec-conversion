#!/bin/bash
#SBATCH --job-name=5km_abl
#SBATCH --account=hfm
#SBATCH --output=abl.out
#SBATCH --mail-user=ashesh.sharma@nrel.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=70
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --qos=high

export SPACK_MANAGER='/home/asharma/exawind_spack_latest/spack-manager'

export SPACK_MANAGER=/home/asharma/exawind_spack_latest/spack-manager
source ${SPACK_MANAGER}/configs/eagle/env.sh
module load mpt
source ${SPACK_MANAGER}/start.sh && quick-activate ${SPACK_MANAGER}/environments/latest
spack load exawind
amr_exec="$(spack location -i amr-wind)/bin/amr_wind"
mpirun -np 2520 ${amr_exec} abl.inp
