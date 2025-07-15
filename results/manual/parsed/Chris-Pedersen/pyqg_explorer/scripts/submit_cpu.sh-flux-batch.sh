#!/bin/bash
#FLUX: --job-name=run_dataset
#FLUX: -t=86400
#FLUX: --priority=16

module purge
singularity exec --nv \
	    --overlay /scratch/cp3759/sing/overlay-50G-10M.ext3:ro \
	    /scratch/work/public/singularity/cuda11.1-cudnn8-devel-ubuntu18.04.sif \
	    /bin/bash -c "source /ext3/env.sh; python3 /home/cp3759/Projects/pyqg_explorer/scripts/gen_single_dataset.py --save_to /scratch/cp3759/pyqg_data/sims/every_snap.nc --sampling_freq 1 --tmax=10"
