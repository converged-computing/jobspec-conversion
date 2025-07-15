#!/bin/bash
#FLUX: --job-name=hello-noodle-4319
#FLUX: -t=3600
#FLUX: --priority=16

IMAGE=${IMAGE:-/scratch/wz2247/singularity/images/pytorch_21.06-py3.sif}
ulimit -Sn $(ulimit -Hn)
singularity exec --no-home -B $HOME/.ssh -B /scratch -B $PWD --nv \
    --cleanenv \
    --overlay overlay-base.ext3:ro \
    --overlay overlay-packages.ext3:ro \
    $IMAGE /bin/bash << 'EOF'
source ~/.bashrc
conda activate /ext3/conda/bootcamp
python -um bootcamp.torch_dataloader_ulimit
EOF
