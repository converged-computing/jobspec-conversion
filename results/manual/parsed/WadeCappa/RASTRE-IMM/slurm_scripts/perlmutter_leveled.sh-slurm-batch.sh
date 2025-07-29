#!/bin/bash
#SBATCH --job-name=m8_leveled_github_IC
#SBATCH --account=m1641
#SBATCH --output=/global/homes/w/wadecap/results/jobs/testing_leveled/github/m8_leveled_github_IC.o
#SBATCH --error=/global/homes/w/wadecap/results/jobs/testing_leveled/github/m8_leveled_github_IC.e
#SBATCH --mail-user=wade.cappa@wsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
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
srun -n 8 ./build/release/tools/mpi-randgreedi -i /global/cfs/cdirs/m1641/network-data/Binaries/github_IC_binary.txt -w -k 100 -p -d IC -e 0.13 -o /global/homes/w/wadecap/results/jobs/testing_leveled/github/m8_leveled_github_IC.json --run-streaming=false --branching-factors="2.4.8" --reload-binary -u 
