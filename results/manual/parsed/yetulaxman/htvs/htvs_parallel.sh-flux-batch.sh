#!/bin/bash
#FLUX: --job-name=placid-egg-2881
#FLUX: -c=20
#FLUX: --queue=small
#FLUX: -t=610
#FLUX: --urgency=16

module load maestro parallel
find data  -name '*.sdf' | \
parallel -j $SLURM_CPUS_PER_TASK bash ${SLURM_SUBMIT_DIR}/wrapper.sh {}
2.sd -LOCAL -NOJOBID"
