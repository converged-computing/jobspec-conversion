#!/bin/bash
#FLUX: --job-name=split_1
#FLUX: --queue=rocmnodes
#FLUX: -t=360000
#FLUX: --urgency=16

spack load singularity@3.8.5
singularity exec --bind  /mnt/scratchc/fmlab/eudari01/BREAST_METABRIC2:/mnt -B /mnt/scratchc/fmlab/eudari01/trial:/data  packages.img4 python /mnt/Vgg19_Regression_each_fold_2.py
