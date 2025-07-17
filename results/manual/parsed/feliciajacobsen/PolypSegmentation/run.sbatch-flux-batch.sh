#!/bin/bash
#FLUX: --job-name=pusheena-earthworm-1058
#FLUX: -c=6
#FLUX: --queue=dgx2q
#FLUX: -t=86460
#FLUX: --urgency=16

ulimit -s 10240
mkdir -p ~/output/g001
module purge
module load slurm/20.02.7
module load cuda11.2/blas/11.2.2
module load cuda11.2/fft/11.2.2
module load cuda11.2/nsight/11.2.2
module load cuda11.2/profiler/11.2.2
module load cuda11.2/toolkit/11.2.2
module load pytorch-extra-py37-cuda11.2-gcc8/1.9.1  
source $HOME/.venv/bin/activate
srun nvidia-smi
hostname
srun python3 /home/feliciaj/PolypSegmentation/src/deep_ensemble.py
