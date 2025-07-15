#!/bin/bash
#FLUX: --job-name=job_wgpu
#FLUX: -t=72000
#FLUX: --urgency=16

singularity exec --nv --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c "
source /ext3/env.sh
conda activate news-unmasked-gpu
TOKENIZERS_PARALLELISM=true python notebook.py &> log
"
