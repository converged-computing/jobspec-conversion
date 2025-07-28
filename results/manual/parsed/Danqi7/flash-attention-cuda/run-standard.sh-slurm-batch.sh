#!/bin/bash
#FLUX: --job-name=attn
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
make attn
echo ""
time ./attn 1024 64 16 # GPT2
echo ""
time ./attn 2048 64 16 # GPT2
echo ""
time ./attn 4096 64 16 # GPT2
echo ""
time ./attn 8192 64 16 # GPT2
echo ""
echo "***Running Standard Attention module (n, d, block dim)"
echo "***All Done."
