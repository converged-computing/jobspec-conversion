#!/bin/bash
#FLUX: --job-name=trainingCycleGAN
#FLUX: --queue=cuda
#FLUX: -t=828000
#FLUX: --urgency=16

module load nvidia/cudasdk/10.1
module load singularity/3.2.1
singularity exec -s /bin/bash --nv maio9.img bash -c 'python ./CycleNLPGAN/train.py --name translation --dataroot data --batch_size 8 --task translation'
