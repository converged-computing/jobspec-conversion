#!/bin/bash
#FLUX: --job-name=remote_SAM
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3/2022.10/gcc-11.2.0
module load cuda/10.2.89/intel-19.0.3.199
module load parmetis/4.0.3/intel-19.0.3.199-intel-mpi-int32-real64
source activate remote2
nvidia-smi
python src/train.py --split_path split3 --ndwi True
