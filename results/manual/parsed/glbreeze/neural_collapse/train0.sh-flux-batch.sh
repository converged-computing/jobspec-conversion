#!/bin/bash
#FLUX: --job-name=nc
#FLUX: -c=2
#FLUX: --queue=a100_1,a100_2,v100,rtx8000
#FLUX: -t=172800
#FLUX: --priority=16

ext3_path=/scratch/$USER/python36/python36.ext3
sif_path=/scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python main.py --dset stl10 --model resnet50 --wd 54 --max_epochs 800 \
 --scheduler ms --loss ce --batch_size 8 --exp_name wd54_ms_ce_b8
"
