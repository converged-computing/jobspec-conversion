#!/bin/bash
#FLUX: --job-name=lt
#FLUX: -c=2
#FLUX: --queue=a100_1,a100_2,v100,rtx8000
#FLUX: -t=172800
#FLUX: --urgency=16

AUG=$1
ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/lg154/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
--overlay /scratch/lg154/sseg/dataset/tiny-imagenet-200.sqf:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python main_wb.py --dataset cifar10 -a resnet32 --imbalance_rate 0.01 --imbalance_type step --beta 0.5 --lr 0.01 --seed 2021\
 --epochs 200 --loss ce --aug ${AUG} --mixup -1 --mixup_alpha 1 --store_name ce_${AUG}
"
