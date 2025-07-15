#!/bin/bash
#FLUX: --job-name=buttery-avocado-4832
#FLUX: --priority=16

module load singularity
cd /project/biol4559-aob2x/singularity
singularity pull --disable-cache destv2.sif docker://jcbn/dest_v2.5:latest
