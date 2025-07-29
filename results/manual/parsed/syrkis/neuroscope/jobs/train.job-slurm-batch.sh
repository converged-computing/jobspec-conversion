#!/bin/bash
#FLUX: --job-name=virian
#FLUX: -c=4
#FLUX: --queue=red
#FLUX: -t=3540
#FLUX: --urgency=16

module --ignore-cache load singularity/3.4.1
module --ignore-cache load CUDA/11.1.1-GCC-10.2.0
srun singularity exec --nv container.sif python3.11 main.py
