#!/bin/bash
#FLUX: --job-name=4docc
#FLUX: -c=20
#FLUX: -t=3600
#FLUX: --priority=16

cd /scratch/$USER/Occ4D/baselines/4docc
singularity exec --nv \
	    --overlay /scratch/$USER/environments/occ4d.ext3:ro \
	    /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
	    /bin/bash -c "source /ext3/env.sh; 
        python eval.py -r /vast/xl3136/lyft_kitti \
            -d results/conv3d_lyft_p1010_lr0.0005_batch4_amp"
