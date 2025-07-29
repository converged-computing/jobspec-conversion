#!/bin/bash
#FLUX: --job-name=h5_ctestS
#FLUX: -t=1800
#FLUX: --urgency=16

cd @HDF5_BINARY_DIR@
CMD="ctest . -E MPI_TEST_ -C Release -j 32 -T test"
echo "Run $CMD. Test output will be in build/ctestS.out"
$CMD  >& ctestS.out
echo "Done running $CMD"
