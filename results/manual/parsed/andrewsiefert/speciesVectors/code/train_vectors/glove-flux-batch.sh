#!/bin/bash
#FLUX: --job-name=evasive-muffin-9625
#FLUX: -c=4
#FLUX: --queue=teton-gpu
#FLUX: -t=21600
#FLUX: --urgency=16

module load swset/2018.05
module load cuda/10.1.243
module load miniconda3/4.3.30
source activate /pfs/tc1/home/asiefer1/conda/gpu/tensorflow/tensorflow_env
cd ~
srun python ~/projects/speciesVectors/code/train_vectors/local/model10.py
source deactivate
