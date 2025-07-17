#!/bin/bash
#FLUX: --job-name=h5_ctestP
#FLUX: -t=1800
#FLUX: --urgency=16

cd @HDF5_BINARY_DIR@
ctest . -R MPI_TEST_ -C Release -T test >& ctestP.out
echo "Done running ctestP.sl"
