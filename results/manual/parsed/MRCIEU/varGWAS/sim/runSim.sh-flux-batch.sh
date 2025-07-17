#!/bin/bash
#FLUX: --job-name=strawberry-eagle-8231
#FLUX: -c=3
#FLUX: --queue=cpu,mrcieu
#FLUX: -t=259200
#FLUX: --urgency=16

set -euo pipefail
module load apps/singularity/3.8.3
mkdir -p data
singularity exec \
--no-mount home \
--bind /user/home/ml18692/projects:/user/home/ml18692/projects \
--pwd `pwd` \
/user/home/ml18692/projects/varGWAS/sim/vargwas-sim.sif \
Rscript "$@"
