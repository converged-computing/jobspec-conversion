#!/bin/bash
#FLUX: --job-name=vulchecker_prepare_data
#FLUX: -c=2
#FLUX: --queue=gpu-tk
#FLUX: --priority=16

export PATH='/ukp-storage-1/schroeder_e/ninja:$PATH'

source /ukp-storage-1/schroeder_e/VulChecker/venv/bin/activate
module load cuda/10.0
cd /ukp-storage-1/schroeder_e/VulChecker
export PATH=/ukp-storage-1/schroeder_e/llvm/llvm-project/clang-build/bin:$PATH
export PATH=/ukp-storage-1/schroeder_e/llvm/llvm-project/llvm-build/bin:$PATH
export PATH=/ukp-storage-1/schroeder_e/ninja:$PATH
cd data/
hector configure --llap-lib-dir /ukp-storage-1/schroeder_e/llvm/llvm-project/llvm-build/lib --labels labels.json cmake "" 121 190 415 416
