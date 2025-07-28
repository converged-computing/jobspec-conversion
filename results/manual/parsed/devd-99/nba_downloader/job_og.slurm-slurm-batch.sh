#!/bin/bash
#FLUX: --job-name=sbatch-nba-dl
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load python/intel/3.8.6
singularity exec --overlay /scratch/dnp9357/rbda/overlay-15GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif /bin/bash -c "
source /ext3/env.sh
python3 download_script.py
"
