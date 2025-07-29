#!/bin/bash
#SBATCH --job-name=Muesli2
#SBATCH --output=/scratch/tmp/kuchen/outputLena.txt
#SBATCH --error=/scratch/tmp/kuchen/errorLena.txt
#SBATCH --mail-user=kuchen@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='4'
export I_MPI_DEBUG='3'
export I_MPI_FABRICS='shm:ofa'

cd /home/k/kuchen/Muesli2
module load intelcuda/2019a
module load CMake/3.15.3
export OMP_NUM_THREADS=4
export I_MPI_DEBUG=3
export I_MPI_FABRICS=shm:ofa
mpirun /home/k/kuchen/Muesli2/build/bin/canny_cpu
