#!/bin/bash
#FLUX: --job-name=Babel_${PARTITION}
#FLUX: --gpus-per-task=1
#FLUX: --queue=${PARTITION}
#FLUX: -t=50400
#FLUX: --urgency=16

PARTITION="$1"
if [ "$PARTITION" == "hgx2q" ]; then
    CUDA_ARCH="sm_80"
elif [ "$PARTITION" == "dgx2q" ]; then
    CUDA_ARCH="sm_70"  # or the appropriate value for hgx2q
else
    echo "Invalid PARTITION value. Please use 'dgx2q' or 'hgx2q'."
    exit 1
fi
module purge
module load slurm/21.08.8
module load cuda11.8/blas/11.8.0
module load cuda11.8/fft/11.8.0
module load cuda11.8/nsight/11.8.0
module load cuda11.8/profiler/11.8.0
module load cuda11.8/toolkit/11.8.0
module load cmake/gcc/3.27.9
cd ../../../BabelStream
cmake -B ../Master/Mas/GPU_n/Build-x86_64/ -DCMAKE_INSTALL_PREFIX=. -H. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=/cm/shared/apps/cuda11.8/toolkit/11.8.0/bin/nvcc -DCUDA_ARCH="$CUDA_ARCH"
cd ../Master/Mas/GPU_n/Build-x86_64/
cmake --build 
./cuda-stream
