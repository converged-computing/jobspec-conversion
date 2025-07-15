#!/bin/bash
#FLUX: --job-name=wilds_job
#FLUX: -c=4
#FLUX: --urgency=16

singularity exec --nv --bind /scratch/$USER --overlay /scratch/$USER/overlay-25GB-500K.ext3:rw /scratch/$USER/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif bash -c '
source /ext3/env.sh
conda activate WILDS
python /scratch/js12556/CG-WILDS/main.py --group 1 --epoch 12 --subset_size 0.05
'
