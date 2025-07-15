#!/bin/bash
#FLUX: --job-name=scruptious-train-1579
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export HDF5_USE_FILE_LOCKING='FALSE  '

export OMP_NUM_THREADS=1
set -x
source /usr/common/contrib/bccp/conda-activate.sh 3.6
(cd ../; python setup.py sdist )
version=`python ../setup.py --version`
bcast-pip ../dist/imaginglss-$version.tar.gz
export HDF5_USE_FILE_LOCKING=FALSE  
time srun -n 512 python -u ../scripts/imglss-mpi-make-random.py \
    --conf /project/projectdirs/m779/yfeng1/imaginglss/dr5.conf.py \
    20000000 \
    /project/projectdirs/desi/users/yfeng1/imaginglss/legacysurvey/dr5/RANDOM.hdf5
