#!/bin/bash
#FLUX: --job-name=blank-lamp-6428
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=43200
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
cp -rp /scratch/DL22SP/unlabeled_224.sqsh /tmp
cp -rp /scratch/DL22SP/labeled.sqsh /tmp
echo "Dataset is copied to /tmp"
singularity exec --nv \
--bind /scratch \
--overlay /scratch/DL22SP/conda.ext3:ro \
--overlay /tmp/unlabeled_224.sqsh \
--overlay /tmp/labeled.sqsh \
/share/apps/images/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
/bin/bash -c "
source /ext3/env.sh
conda activate
python demo.py
"
