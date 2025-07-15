#!/bin/bash
#FLUX: --job-name=dlana
#FLUX: -t=1800
#FLUX: --urgency=16

container=/cluster/tufts/wongjiradlab/larbys/larbys-containers/singularity_dldependencies_pytorch1.3.sing
RUN_DLANA_DIR=/cluster/tufts/wongjiradlab/larbys/run_dlana_jobs
module load singularity
srun singularity exec ${container} bash -c "cd ${RUN_DLANA_DIR} && source run.sh"
