#!/bin/bash
#FLUX: --job-name=lt
#FLUX: -c=2
#FLUX: --queue=a100_1,a100_2,v100,rtx8000
#FLUX: -t=172800
#FLUX: --urgency=16

LOSS=$1
BS=$2
SEED=$3
ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/lg154/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
--overlay /scratch/lg154/sseg/dataset/tiny-imagenet-200.sqf:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python main_nc.py --dataset cifar100 -a resnet50 --epochs 600 --scheduler ms --norm gn --coarse \
  --loss ${LOSS} --eps 0.05 --batch_size ${BS} --seed 202${SEED} --store_name gn_coarse_${LOSS}_b${BS}_s${SEED}
"
