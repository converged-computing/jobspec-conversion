#!/bin/bash
#SBATCH --job-name=WarpX
#SBATCH --account=<proj>
#SBATCH --output=WarpX.o%j
#SBATCH --error=WarpX.e%j
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=gpu

export MPICH_OFI_NIC_POLICY='GPU'
export SRUN_CPUS_PER_TASK='32'

EXE=./warpx
INPUTS=inputs_small
export MPICH_OFI_NIC_POLICY=GPU
export SRUN_CPUS_PER_TASK=32
GPU_AWARE_MPI=""
srun --cpu-bind=cores bash -c "
    export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}" \
  > output.txt
