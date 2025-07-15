#!/bin/bash
#FLUX: --job-name=sbatch
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3/5.0.1
source activate tf1-gpu
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.5.0
whereis nvcc
which nvcc
nvcc --version
cd /scratch/gpfs/ky8517/leaf-torch/data/femnist
pwd
python3 -V
./preprocess.sh
