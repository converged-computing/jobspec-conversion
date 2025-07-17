#!/bin/bash
#FLUX: --job-name=0401_CPIP
#FLUX: --queue=a100_1,a100_2,v100
#FLUX: -t=18000
#FLUX: --urgency=16

ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif
cd /scratch/jh7956/CPIP
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python main.py"
