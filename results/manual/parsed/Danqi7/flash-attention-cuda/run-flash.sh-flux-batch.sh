#!/bin/bash
#FLUX: --job-name=flashattn
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

echo "***Purging module files"
echo ""
module purge
echo ""
echo "***Loading CUDA module file"
echo ""
module load CUDA
echo ""
module list
echo ""
echo "***Running nvidia-smi"
echo ""
nvidia-smi
echo ""
echo ""
echo "***Running deviceQuery"
/vast/palmer/apps/avx.grace/software/CUDAcore/11.3.1/extras/demo_suite/deviceQuery
echo ""
echo "***Building matmul"
make clean
make flash_attention
echo ""
echo "***Running Flash Attention module (n)"
time ./flash_attention 8192
echo ""
echo "***All Done."
