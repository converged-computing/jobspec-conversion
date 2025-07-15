#!/bin/bash
#FLUX: --job-name=cifar_trades
#FLUX: -c=4
#FLUX: -t=72000
#FLUX: --priority=16

date
singularity exec --nv \
	    --overlay ~/zc2157/overlay-25GB-500K.ext3:ro \
	    /scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
	    /bin/bash -c "
source /ext3/env.sh
python3 train_trades_cifar10.py --beta 6 --lam 0 --model-dir model-cifar-baseline-final
date
"
