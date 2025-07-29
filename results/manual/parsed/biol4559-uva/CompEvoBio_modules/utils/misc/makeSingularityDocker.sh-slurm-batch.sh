#!/bin/bash
#FLUX: --job-name=makeSingularity
#FLUX: --queue=instructional
#FLUX: -t=14400
#FLUX: --urgency=16

module load singularity
cd /project/biol4559-aob2x/singularity
singularity pull --disable-cache destv2.sif docker://jcbn/dest_v2.5:latest
