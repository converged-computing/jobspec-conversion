#!/bin/bash
#FLUX: --job-name=FFT-GPU
#FLUX: --exclusive
#FLUX: -t=28800
#FLUX: --urgency=16

set +x
mkdir -p ${HOME}/repos/nvstdpar/build-fft-gpu
cd ${HOME}/repos/nvstdpar/build-fft-gpu
rm -rf ./*
ml unload cudatoolkit
ml use /global/cfs/cdirs/m1759/wwei/nvhpc_23_7/modulefiles
ml nvhpc/23.7
ml gcc/12.2.0
ml cmake/3.24
cmake .. -DSTDPAR=gpu -DOMP=gpu -DCMAKE_CXX_COMPILER=$(which nvc++)
make -j fft-stdexec fft-stdpar
cd ${HOME}/repos/nvstdpar/build-fft-gpu/apps/fft
D=(536870912 1073741824)
for d in "${D[@]}"; do
    echo "stdexec:gpu for ${d}"
    srun -n 1 ./fft-stdexec -N ${d} --time --sch=gpu
    echo "stdpar:gpu for ${d}"
    srun -n 1  ./fft-stdpar -N ${d} --time 2>&1
done
for d in "${D[@]}"; do
    echo "stdexec:multi_gpu for ${d}"
    srun -n 1 ./fft-stdexec -N ${d} --time --sch=multigpu 2>&1
done
