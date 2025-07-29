#!/bin/bash
#SBATCH --job-name=flashattn
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=45G
#SBATCH --time=00:20:00

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
