#!/bin/bash
#SBATCH --job-name=h5_ctestP
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

cd @HDF5_BINARY_DIR@
ctest . -R MPI_TEST_ -C Release -T test >& ctestP.out
echo "Done running ctestP.sl" 
