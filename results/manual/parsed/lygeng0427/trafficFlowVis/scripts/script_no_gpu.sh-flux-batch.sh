#!/bin/bash
#FLUX: --job-name=count_num_objects
#FLUX: -c=2
#FLUX: -t=216000
#FLUX: --priority=16

ext3_path=/scratch/lg3490/tfv/overlay-25GB-500K.ext3
sif_path=/scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif
singularity exec \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
conda activate vis
python main.py
"
