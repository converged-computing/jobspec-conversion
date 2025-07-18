#!/bin/bash
#FLUX: --job-name=lama_popavg
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity
singularity exec LAMA.sif lama_workspace/population_average.sh 2> lama_workspace/lama_popavg.err 1> lama_workspace/lama_popavg.out
