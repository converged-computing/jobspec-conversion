#!/bin/bash
#FLUX: --job-name=matching_objects
#FLUX: -c=2
#FLUX: --queue=a100_1,a100_2,v100,rtx8000
#FLUX: -t=86400
#FLUX: --priority=16

ext3_path=/scratch/lg3490/tfv/overlay-25GB-500K.ext3
sif_path=/scratch/work/public/singularity/cuda12.1.1-cudnn8.9.0-devel-ubuntu22.04.2.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
conda activate vis
python main.py
"
