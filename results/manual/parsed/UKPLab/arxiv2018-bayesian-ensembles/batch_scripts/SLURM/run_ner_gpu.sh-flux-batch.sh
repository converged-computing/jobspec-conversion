#!/bin/bash
#FLUX: --job-name=ner_gpu
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${cudaDir}/lib64:${LD_LIBRARY_PATH}'
export CPATH='${cudaDir}/include:${CPATH}'
export LIBRARY_PATH='${cudaDir}/lib64:${LD_LIBRARY_PATH}'

module load intel cuda gcc python/3.5.2 blas OpenBLAS/gcc/avx OpenBLAS/gcc/sse OpenBLAS/intel/avx/0.2.2
cudaDir="/home/ih68sexe/cudnn/cuda"
export LD_LIBRARY_PATH=${cudaDir}/lib64:${LD_LIBRARY_PATH}
export CPATH=${cudaDir}/include:${CPATH}
export LIBRARY_PATH=${cudaDir}/lib64:${LD_LIBRARY_PATH}
THEANO_FLAGS=mode=FAST_RUN,device=cuda*,floatX=float32,optimizer_including=cudnn python3 run_ner_experiments_gpu.py
