#!/bin/bash
#SBATCH --job-name=FBtest
#SBATCH --account=nstaff_g
#SBATCH --output=FBtest.o%A-%a
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=00:02:00
#SBATCH --constraint=gpu,ntasks-per-node=4

export MPICH_OFI_NIC_POLICY='NUMA'
export MPIACX_NFLAGS='256'

export MPICH_OFI_NIC_POLICY=NUMA
EXE=./main3d.gnu.TPROF.MTMPI.CUDA.ex
INPUTS="inputs_2"
export MPIACX_NFLAGS=256
srun nsys profile --stats=true -t nvtx,cuda ${EXE} ${INPUTS}
