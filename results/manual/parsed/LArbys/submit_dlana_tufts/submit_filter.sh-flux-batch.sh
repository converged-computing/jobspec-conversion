#!/bin/bash
#FLUX: --job-name=dlfilter
#FLUX: -t=2400
#FLUX: --urgency=16

container=/cluster/tufts/wongjiradlab/larbys/larbys-containers/singularity_dldependencies_pytorch1.3.sing
RUN_DLANA_DIR=/cluster/tufts/wongjiradlab/larbys/run_dlana_jobs
OFFSET=0
module load singularity
srun singularity exec ${container} bash -c "cd ${RUN_DLANA_DIR} && source run_filter_test.sh $OFFSET"
