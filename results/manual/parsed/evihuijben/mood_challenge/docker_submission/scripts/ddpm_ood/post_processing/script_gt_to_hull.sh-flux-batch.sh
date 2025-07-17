#!/bin/bash
#FLUX: --job-name=mood
#FLUX: --queue=bme.gpuresearch.q
#FLUX: -t=3600000
#FLUX: --urgency=16

source /home/bme001/s144823/conda/etc/profile.d/conda.sh
conda activate mood
cd /home/bme001/shared/mood/code/ddpm-ood/post_processing
srun python create_gt_hull_objects.py
