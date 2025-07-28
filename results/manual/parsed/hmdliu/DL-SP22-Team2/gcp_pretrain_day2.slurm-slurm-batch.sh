#!/bin/bash
#FLUX: --job-name=torch
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=n1c24m128-v100-4
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
cp -rp /scratch/DL22SP/unlabeled_224.sqsh /tmp
echo "Dataset is copied to /tmp"
singularity exec --nv \
--bind /scratch \
--overlay /scratch/hl3797/conda.ext3:ro \
--overlay /tmp/unlabeled_224.sqsh \
/share/apps/images/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
source /ext3/env.sh
python main_pretrain.py \
        --resume ./output_dir/mae-day1/checkpoint-40.pth \
        --output_dir ./output_dir/mae-day2 \
        --log_dir ./output_dir/mae-day2
"
