#!/bin/bash
#FLUX: --job-name=delicious-dog-4182
#FLUX: --urgency=16

export LD_PRELOAD=''

cmdstan_ver=2.31.1
make_cores=6
IMAGE=$WORK/singularity/edge-trait-meta_4.2.0.sif # singularity image
cmdstan_direc=$SCRATCH/cmdstan # Feel free to change to $WORK, though that will require modifying the scripts that call it.
cmdstan_temp=$cmdstan_direc # If you change cmdstan_direc to $WORK, change this to download temp files elsewhere.
tarball="cmdstan-${cmdstan_ver}.tar.gz"
url="https://github.com/stan-dev/cmdstan/releases/download/v${cmdstan_ver}/${tarball}"
cd $cmdstan_tmp
wget $url 
tar -xf $tarball -C $cmdstan_direc
cd $cmdstan_direc/cmdstan-${cmdstan_ver}
echo CXXFLAGS += -march=native -mtune=native -DEIGEN_USE_BLAS -DEIGEN_USE_LAPACKE >> make/local
echo LDLIBS += -lblas -llapack  >> make/local # -llapacke
echo STAN_THREADS = true >> make/local
echo CXXFLAGS += -DEIGEN_USE_MKL_ALL -I"/usr/include/mkl" >> make/local
echo LDLIBS += -lmkl_intel_lp64 -lmkl_sequential -lmkl_core >> make/local
export LD_PRELOAD=""
module load tacc-apptainer
module unload xalt
HDIR=/home
singularity exec -H $HDIR $IMAGE make -j${make_cores} build
