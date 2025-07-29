#!/bin/bash
#SBATCH --job-name=20x20_scaling
#SBATCH --account=CFD162
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=lcheung@sandia.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=400
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --exclusive

export rocm_version='5.4.3'
export MPICH_GPU_SUPPORT_ENABLED='1'
export LD_LIBRARY_PATH='/opt/rocm-${rocm_version}/llvm/lib/:$LD_LIBRARY_PATH'
export FI_MR_CACHE_MONITOR='memhooks'
export FI_CXI_RX_MATCH_MODE='software'
export CONFFILE='MedWS_LowTI_Offshore_Stable_Layout_20x20.inp'
export TASKSPERNODE='8'
export NTASKS='$((TASKSPERNODE*SLURM_JOB_NUM_NODES))'

export rocm_version=5.4.3
export MPICH_GPU_SUPPORT_ENABLED=1
module purge
module load amd/${rocm_version}
module load craype-accel-amd-gfx90a
module load PrgEnv-amd
module load cray-mpich
source /lustre/orion/cfd162/proj-shared/lcheung/spackbuilds/spack-manager.jrood/loadexawind.sh
export LD_LIBRARY_PATH=/opt/rocm-${rocm_version}/llvm/lib/:$LD_LIBRARY_PATH
export FI_MR_CACHE_MONITOR=memhooks
export FI_CXI_RX_MATCH_MODE=software
export CONFFILE=MedWS_LowTI_Offshore_Stable_Layout_20x20.inp
export TASKSPERNODE=8
export NTASKS=$((TASKSPERNODE*SLURM_JOB_NUM_NODES))
srun -N $SLURM_JOB_NUM_NODES -n $NTASKS --ntasks-per-node=$TASKSPERNODE --gpu-bind=closest amr_wind $CONFFILE
