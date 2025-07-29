#!/bin/bash
#SBATCH --job-name=vasptest
#SBATCH --account=dmr970008
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --mail-user=computation.management@gmail.com
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

export I_MPI_FABRICS='shm'
export OMP_NUM_THREADS='1'

module purge
module load intel
module load intel-mkl
module list
export I_MPI_FABRICS=shm
export OMP_NUM_THREADS=1
conda activate diffusion
python myhops_2023.py 600;
