#!/bin/bash
#FLUX: --job-name=train_cnn
#FLUX: -c=10
#FLUX: -t=43200
#FLUX: --priority=16

module purge
singularity exec --nv \
	    --overlay /scratch/cp3759/sing/overlay-50G-10M.ext3:ro \
	    /scratch/work/public/singularity/cuda11.1-cudnn8-devel-ubuntu18.04.sif \
	    /bin/bash -c "source /ext3/env.sh; python3 /home/cp3759/Projects/pyqg_explorer/scripts/diffusion_mnist/run_unet.py"
