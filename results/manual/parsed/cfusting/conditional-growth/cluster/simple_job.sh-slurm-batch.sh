#!/bin/bash
#FLUX: --job-name=catnap
#FLUX: -c=2
#FLUX: --queue=preempt
#FLUX: -t=604800
#FLUX: --urgency=16

module load singularity/3.6.1
singularity exec --nv --writable-tmpfs image_latest.sif python conditional-growth/experiments/distance_traveled/optimize_sim.py
