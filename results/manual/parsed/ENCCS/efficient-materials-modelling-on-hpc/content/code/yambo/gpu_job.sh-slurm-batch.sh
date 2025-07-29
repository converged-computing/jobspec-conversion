#!/bin/bash
#SBATCH --job-name=mos2-test
#SBATCH --account=d2021-135-users
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gres=gpu:4
#SBATCH --mem=230000MB
#SBATCH --time=00:30:00
#SBATCH --partition=gpu
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=4,ntasks-per-socket=2

export OMP_NUM_THREADS='8'

module purge
module use /ceph/hpc/data/d2021-135-users/modules
module load YAMBO/5.1.1-OMPI-4.0.5-NVHPC-21.2-CUDA-11.2.1
export OMP_NUM_THREADS=8
srun --mpi=pmix -n ${SLURM_NTASKS} yambo -F gw.in -J GW_dbs -C GW_reports
