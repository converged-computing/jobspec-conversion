#!/bin/bash
#FLUX: --job-name=cv
#FLUX: -c=16
#FLUX: -t=28800
#FLUX: --priority=16

module purge
singularity exec --nv \
    --overlay /scratch/ds5749/NLQ/overlay-15GB-500K.ext3:ro /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif /bin/bash -c \
    "source /ext3/miniconda3/etc/profile.d/conda.sh; conda activate vslnet; 
    python siamese_train.py --model_name TransformerNet --epochs 10 --batch_size 32 --loss BCE"
    # SiameseConvNet, TransformerNet, vit_base, resnet, resnet_pretrained
