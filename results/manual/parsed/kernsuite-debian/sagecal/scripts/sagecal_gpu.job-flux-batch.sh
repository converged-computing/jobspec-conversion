#!/bin/bash
#FLUX: --job-name=bricky-knife-3611
#FLUX: -t=120
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/cm/shared/package/cuda91/toolkit/9.1.85/lib64/stubs'

. /etc/bashrc
. /etc/profile.d/modules.sh
module load cmake/3.8.2
module load mpich/ge/gcc/64/3.2
module load gcc/6.3.0
module load casacore/2.4.1-gcc-6.3.0
module load wcslib/5.18-gcc-6.3.0
module load cfitsio/3.430-gcc-6.3.0
module load openblas/0.2.20
module load cuda91/toolkit/9.1.85
nvidia-smi
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cm/shared/package/cuda91/toolkit/9.1.85/lib64/stubs
ln -s /cm/shared/package/cuda91/toolkit/9.1.85/lib64/stubs/libnvidia-ml.so libnvidia-ml.so.1
/home/fdiblen/sagecal_gpu/build/dist/bin/sagecal_gpu
