#!/bin/bash
#FLUX: --job-name=red-frito-0972
#FLUX: --urgency=16

module load singularity
cd /project/biol4559-aob2x/singularity
singularity pull --disable-cache destv2.sif docker://jcbn/dest_v2.5:latest
