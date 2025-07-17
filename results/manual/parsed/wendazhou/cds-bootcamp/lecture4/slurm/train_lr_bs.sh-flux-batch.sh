#!/bin/bash
#FLUX: --job-name=misunderstood-puppy-0713
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

IMAGE=${IMAGE:-/scratch/wz2247/singularity/images/pytorch_21.06-py3.sif}
OVERLAY_DIR=${OVERLAY_DIR:-../lecture2}
singularity exec --no-home -B $HOME/.ssh -B /scratch -B $PWD --nv \
    --cleanenv \
    --overlay $OVERLAY_DIR/overlay-base.ext3:ro \
    --overlay $OVERLAY_DIR/overlay-packages.ext3:ro \
    $IMAGE /bin/bash << 'EOF'
source ~/.bashrc
conda activate /ext3/conda/bootcamp
python -um bootcamp.train_lr --multirun batch_size=128,256,512,1024,2048,4096 scale_lr_by_bs=True
EOF
