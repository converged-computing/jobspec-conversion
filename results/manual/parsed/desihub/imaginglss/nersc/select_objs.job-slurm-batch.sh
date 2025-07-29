#!/bin/bash
#FLUX: --job-name=select_objs
#FLUX: -n=32
#FLUX: --queue=debug
#FLUX: -t=1200
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
OPTIONS=" --conf /project/projectdirs/m779/yfeng1/imaginglss/dr5.conf.py "
for T in ELG LRG QSO; do
    time srun -n 16 python ../scripts/imglss-mpi-select-objects.py \
    $OPTIONS \
    ${T} \
    /project/projectdirs/desi/users/yfeng1/imaginglss/legacysurvey/dr5/${T}.hdf5
done
