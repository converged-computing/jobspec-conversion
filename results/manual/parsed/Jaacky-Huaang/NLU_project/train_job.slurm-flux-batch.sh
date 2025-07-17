#!/bin/bash
#FLUX: --job-name=0220_bitfit
#FLUX: -c=2
#FLUX: --queue=a100_1,a100_2,v100,rtx8000
#FLUX: -t=14400
#FLUX: --urgency=16

ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
python /scratch/jh7956/hw2/train_model_use_bitfit.py
"
