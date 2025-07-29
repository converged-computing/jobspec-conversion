#!/bin/bash
#FLUX: --job-name=lambdal
#FLUX: --urgency=16

echo "$0 : about to run gcs-lambdalabs-singularity on Speed..."
date
env
SINGULARITY=/encs/pkg/singularity-3.10.4/root/bin/singularity
SINGULARITY_BIND=$PWD:/speed-pwd,/speed-scratch/$USER:/my-speed-scratch,/nettemp
echo "Singularity will bind mount: $SINGULARITY_BIND for user: $USER"
time \
	srun $SINGULARITY run --nv /speed-scratch/nag-public/gcs-lambdalabs-stack.sif \
	/usr/bin/python3 -c 'import torch; print(torch.rand(5, 5).cuda()); print(\"I love Lambda Stack!\")'
echo "$0 : Done!"
date
