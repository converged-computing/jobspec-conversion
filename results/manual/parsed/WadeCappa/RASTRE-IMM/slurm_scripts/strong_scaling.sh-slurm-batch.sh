#!/bin/bash
#SBATCH --job-name=m65_wikipedia
#SBATCH --account=m1641
#SBATCH --output=/global/cfs/cdirs/m1641/network-results/strong_scaling/wikipedia/m65_wikipedia.o
#SBATCH --error=/global/cfs/cdirs/m1641/network-results/strong_scaling/wikipedia/m65_wikipedia.e
#SBATCH --mail-user=wade.cappa@wsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=65
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
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
srun -n 65 ./build/release/tools/mpi-greedi-im -i /global/cfs/cdirs/m1641/network-data/Binaries/wikipedia_binary.txt -w -k 100 -p -d IC -e 0.13 -o /global/cfs/cdirs/m1641/network-results/strong_scaling/wikipedia/m65_wikipedia.json --run-streaming=true --epsilon-2=0.077 --reload-binary
