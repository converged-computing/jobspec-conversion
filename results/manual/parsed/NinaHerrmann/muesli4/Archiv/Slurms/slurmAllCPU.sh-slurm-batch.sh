#!/bin/bash
#SBATCH --job-name=Muesli2-CPU
#SBATCH --output=/scratch/tmp/kuchen/outputAllCPU.txt
#SBATCH --error=/scratch/tmp/kuchen/errorAllCPU.txt
#SBATCH --mail-user=kuchen@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=4
#SBATCH --time=04:00:00
#SBATCH --partition=normal
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='4'
export I_MPI_FABRICS='shm:ofa'

cd /home/k/kuchen/Muesli2
module load intelcuda/2019a
module load CMake/3.15.3
export OMP_NUM_THREADS=4
export I_MPI_FABRICS=shm:ofa
for file in /home/k/kuchen/Muesli2/build/bin/*cpu
do
  mpirun $file &
done
wait
