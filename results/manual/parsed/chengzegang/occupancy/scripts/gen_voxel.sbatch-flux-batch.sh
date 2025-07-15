#!/bin/bash
#FLUX: --job-name=gen_voxel
#FLUX: -c=16
#FLUX: -t=14400
#FLUX: --urgency=16

singularity exec --nv \
        --overlay /scratch/zc2309/nuscenes.ext3:ro \
	    --overlay /scratch/$USER/containers/overlay.ext3:ro  \
	    /scratch/work/public/singularity/cuda12.2.2-cudnn8.9.4-devel-ubuntu22.04.3.sif \
	    /bin/bash -c "source /ext3/env.sh; cd /scratch/zc2309/occupancy; bash scripts/gen_voxel.sh"
