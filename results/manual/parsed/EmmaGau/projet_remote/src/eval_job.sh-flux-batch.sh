#!/bin/bash
#FLUX: --job-name=remote_eval
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3/2022.10/gcc-11.2.0
module load cuda/10.2.89/intel-19.0.3.199
module load parmetis/4.0.3/intel-19.0.3.199-intel-mpi-int32-real64
source activate remote2
nvidia-smi
python src/eval.py --checkpoint_path /gpfs/workdir/reumauxl/projet_remote/results/2024-04-11T13-43-23/checkpoint_21.pt --split_path split3 --ndwi True
