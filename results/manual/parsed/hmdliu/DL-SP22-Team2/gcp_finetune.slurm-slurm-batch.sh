#!/bin/bash
#FLUX: --job-name=torch
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
cp -rp /scratch/DL22SP/labeled.sqsh /tmp
echo "Dataset is copied to /tmp"
singularity exec --nv \
--bind /scratch \
--overlay /scratch/hl3797/conda.ext3:ro \
--overlay /tmp/labeled.sqsh \
/share/apps/images/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
source /ext3/env.sh
python main_finetune.py $1 > $1.log 2>&1
"
