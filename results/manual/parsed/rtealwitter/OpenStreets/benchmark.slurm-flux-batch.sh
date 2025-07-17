#!/bin/bash
#FLUX: --job-name=benchmark
#FLUX: -c=8
#FLUX: -t=12600
#FLUX: --urgency=16

singularity exec --nv --overlay $SCRATCH/overlay-25GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate
conda activate take_a_ride
python3 code/benchmark.py
"
