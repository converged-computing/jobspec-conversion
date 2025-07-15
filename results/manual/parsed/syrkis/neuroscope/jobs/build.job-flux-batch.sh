#!/bin/bash
#FLUX: --job-name=container
#FLUX: --queue=red,brown
#FLUX: -t=3600
#FLUX: --urgency=16

module load singularity
singularity build container.sif docker://syrkis/neuroscope
