#!/bin/bash
#SBATCH --job-name=Github5
#SBATCH --account=m1641
#SBATCH --output=Github5.o
#SBATCH --error=Github5.e
#SBATCH --mail-user=wade.cappa@wsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=regular
#SBATCH --constraint=cpu,ntasks-per-node=1

export OMP_NUM_THREADS='64'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module use /global/common/software/m3169/perlmutter/modulefiles
export OMP_NUM_THREADS=64
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load gcc/11.2.0
module load cmake/3.24.3
module load cray-mpich
module load cray-libsci
srun -n 5 ./build/release/tools/mpi-greedimm -i /global/cfs/cdirs/m1641/network-data/Binaries/github_binary.txt -w -k 50 -p -d IC -e 0.13 -o Github5.json --run-streaming=true --epsilon-2=0.077 --reload-binary -u
