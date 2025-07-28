#!/bin/bash
#FLUX: --job-name=job_wgpu
#FLUX: -c=4
#FLUX: -t=115800
#FLUX: --urgency=16

singularity exec --nv --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif /bin/bash -c "
source /ext3/env.sh
conda activate knowledge
bash run_lora.sh "${1}$"
"
