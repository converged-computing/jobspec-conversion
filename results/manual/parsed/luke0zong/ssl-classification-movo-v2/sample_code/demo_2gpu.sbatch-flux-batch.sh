#!/bin/bash
#FLUX: --job-name=fuzzy-squidward-6014
#FLUX: --exclusive
#FLUX: --queue=n1s16-t4-2
#FLUX: -t=3600
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/tmp/$USER'

/share/apps/local/bin/p2pBandwidthLatencyTest > /dev/null 2>&1
set -x 
mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
cp -rp /scratch/DL21SP/student_dataset.sqsh /tmp
echo "Dataset is copied to /tmp"
cd $HOME/test
singularity exec --nv \
--bind /scratch \
--overlay /scratch/DL21SP/conda.sqsh:ro \
--overlay /tmp/student_dataset.sqsh:ro \
/share/apps/images/cuda11.1-cudnn8-devel-ubuntu18.04.sif \
/bin/bash -c "
source /ext3/env.sh
conda activate dev
python demo_2gpu.py --checkpoint-dir $SCRATCH/checkpoints/demo
python eval.py --checkpoint-path $SCRATCH/checkpoints/demo/net_demo.pth
"
