#!/bin/bash
#FLUX: --job-name=h5_ctestP
#FLUX: -t=1800
#FLUX: --urgency=16

cd @HDF5_BINARY_DIR@
CMD="ctest . -R MPI_TEST_ -E t_cache_image -C Release -T test"
echo "Run $CMD. Test output will be in build/ctestP.out"
$CMD >& ctestP.out
echo "Done running $CMD"
