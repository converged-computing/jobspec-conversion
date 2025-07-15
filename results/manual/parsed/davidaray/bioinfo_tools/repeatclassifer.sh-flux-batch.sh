#!/bin/bash
#FLUX: --job-name=rclassify
#FLUX: --queue=nocona
#FLUX: --priority=16

module --ignore-cache load gcc/10.1.0 r/4.0.2
. ~/conda/etc/profile.d/conda.sh
conda activate repeatmodeler
cd /lustre/scratch/daray/ixodes/iRic1/repeatclassifier
RepeatClassifier -consensi iRic1_extended_rep.fa
