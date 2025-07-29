#!/bin/bash
#SBATCH --job-name=h5_ctestS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

cd @HDF5_BINARY_DIR@
CMD="ctest . -E MPI_TEST_ -C Release -j 32 -T test"
echo "Run $CMD. Test output will be in build/ctestS.out"
$CMD  >& ctestS.out
echo "Done running $CMD"
