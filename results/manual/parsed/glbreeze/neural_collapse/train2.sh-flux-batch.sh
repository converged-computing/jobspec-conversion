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
python main.py --dset fmnist --model resnet18 --koleo_wt 0.01 --loss ce --koleo_type c --exp_name wd54_klc01
"
