#!/bin/bash
#SBATCH --job-name=ner_al_gpu
#SBATCH --output=./ner_al_gpu.out.%j
#SBATCH --error=./ner_al_gpu.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8182
#SBATCH --time=1-00:00:00
#SBATCH --exclusive

export LD_LIBRARY_PATH='${cudaDir}/lib64:${LD_LIBRARY_PATH}'
export CPATH='${cudaDir}/include:${CPATH}'
export LIBRARY_PATH='${cudaDir}/lib64:${LD_LIBRARY_PATH}'

module load intel cuda gcc python/3.5.2 blas OpenBLAS/gcc/avx OpenBLAS/gcc/sse OpenBLAS/intel/avx/0.2.2
cudaDir="/home/ih68sexe/cudnn/cuda"
export LD_LIBRARY_PATH=${cudaDir}/lib64:${LD_LIBRARY_PATH}
export CPATH=${cudaDir}/include:${CPATH}
export LIBRARY_PATH=${cudaDir}/lib64:${LD_LIBRARY_PATH}
THEANO_FLAGS=mode=FAST_RUN,device=cuda*,floatX=float32,optimizer_including=cudnn python3 run_ner_active_learning.py
