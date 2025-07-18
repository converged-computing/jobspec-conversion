#!/bin/bash
#FLUX: --job-name=confused-destiny-3482
#FLUX: -c=4
#FLUX: --queue=cs
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Starting Tensorize"
singularity exec --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate adversarial-code
echo $(pwd)
python scripts/parse_so_data.py consolidate $1 $2 $3 -val ${4:-10000}
"
