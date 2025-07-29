#!/bin/bash
#FLUX: --job-name=FFT-GPU-PERF
#FLUX: --exclusive
#FLUX: -t=10800
#FLUX: --urgency=16

set +x
BUILD_HOME=${HOME}/repos/nvstdpar/build-fft-gpu-nsight
mkdir -p ${BUILD_HOME}
cd ${BUILD_HOME}
rm -rf ./*
ml unload cudatoolkit
ml use /global/cfs/cdirs/m1759/wwei/nvhpc_23_7/modulefiles
ml nvhpc/23.7
cmake .. -DSTDPAR=gpu -DOMP=gpu -DCMAKE_CXX_COMPILER=$(which nvc++)
make -j fft-stdexec fft-stdpar
mkdir -p ${SCRATCH}/fft-gpu-nsight
cd ${SCRATCH}/fft-gpu-nsight
rm -rf ./*
srun --ntasks-per-node 1 dcgmi profile --pause
SIZE=4024000
srun nsys profile --force-overwrite true -o fft-gpu-stdexec.nsys --stats=true ${BUILD_HOME}/apps/fft/fft-stdexec --sch=gpu -N ${SIZE} |& tee nsys-fft-stdexec-gpu.log
srun nsys profile --force-overwrite true -o fft-gpu-stdpar.nsys --stats=true ${BUILD_HOME}/apps/fft/fft-stdpar -N ${SIZE} |& tee nsys-fft-stdpar-gpu.log
srun nsys profile --force-overwrite true -o fft-multigpu-stdexec.nsys --stats=true ${BUILD_HOME}/apps/fft/fft-stdexec --sch=multigpu -N ${SIZE} |& tee nsys-fft-multigpu-stdexec.log
srun ncu -f -o fft-gpu-stdexec.ncu  --target-processes all --print-summary per-gpu --replay-mode application  --set full ${BUILD_HOME}/apps/fft/fft-stdexec -N ${SIZE} --sch=gpu |& tee ncu-fft-stdexec-gpu.log
srun ncu -f -o fft-gpu-stdpar.ncu  --target-processes all --print-summary per-gpu --replay-mode application  --set full ${BUILD_HOME}/apps/fft/fft-stdpar -N ${SIZE} |& tee ncu-fft-stdpar-gpu.log
srun ncu -f -o fft-multigpu-stdexec.log  --target-processes all --print-summary per-gpu --replay-mode application  --set full ${BUILD_HOME}/apps/fft/fft-stdexec -N ${SIZE} --sch=multigpu |& tee ncu-fft-multigpu-stdexec.log
ncu -f -o fft-gpu-stdexec-roofline.ncu  --target-processes all --print-summary per-gpu --replay-mode application  --set roofline ${BUILD_HOME}/apps/fft/fft-stdexec -N ${SIZE} --sch=gpu |& tee ncu-fft-stdexec-gpu-roofline.log
srun ncu -f -o fft-gpu-stdpar-roofline.ncu  --target-processes all --print-summary per-gpu --replay-mode application  --set full ${BUILD_HOME}/apps/fft/fft-stdpar -N ${SIZE} |& tee ncu-fft-stdpar-gpu-roofline.log
srun ncu -f -o fft-multigpu-stdexec-roofline.log  --target-processes all --print-summary per-gpu --replay-mode application  --set roofline ${BUILD_HOME}/apps/fft/fft-stdexec -N ${SIZE} --sch=multigpu |& tee ncu-fft-multigpu-stdexec-roofline.log
srun --ntasks-per-node 1 dcgmi profile --resume
