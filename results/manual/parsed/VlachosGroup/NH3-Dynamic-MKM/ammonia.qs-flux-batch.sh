#!/bin/bash
#FLUX: --job-name=amm_01
#FLUX: --queue=ccei_biomass
#FLUX: -t=172800
#FLUX: --urgency=16

. /opt/shared/slurm/templates/libexec/openmp.sh
vpkg_require matlab/r2020b
srun matlab -nodisplay -nosplash -nodesktop -singleCompThread -r 'amm_main4(593)'
