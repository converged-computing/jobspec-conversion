#!/bin/bash
#SBATCH --job-name=WarpX
#SBATCH --account=<proj>
#SBATCH --output=WarpX.o%j
#SBATCH --error=WarpX.e%j
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=regular
#SBATCH: --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=4

export MPICH_OFI_NIC_POLICY='GPU'
export SRUN_CPUS_PER_TASK='16'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

EXE=./warpx
INPUTS=inputs
export MPICH_OFI_NIC_POLICY=GPU
export SRUN_CPUS_PER_TASK=16
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
GPU_AWARE_MPI="amrex.use_gpu_aware_mpi=1"
srun --cpu-bind=cores bash -c "
    export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}" \
  > output.txt
