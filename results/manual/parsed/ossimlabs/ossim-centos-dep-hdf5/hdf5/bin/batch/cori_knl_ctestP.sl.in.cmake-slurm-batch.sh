#!/bin/bash
#SBATCH --job-name=h5_ctestP
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=knl,quad,cache

cd @HDF5_BINARY_DIR@
CMD="ctest . -R MPI_TEST_ -E t_cache_image -C Release -T test"
echo "Run $CMD. Test output will be in build/ctestP.out"
$CMD >& ctestP.out
echo "Done running $CMD"
