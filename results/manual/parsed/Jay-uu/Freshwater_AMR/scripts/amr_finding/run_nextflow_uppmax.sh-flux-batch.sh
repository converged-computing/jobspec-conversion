#!/bin/bash
#FLUX: --job-name=peachy-spoon-6891
#FLUX: --urgency=16

export CONDA_ENVS_PATH='/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs'

cd /proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/amr_finding
module load conda
source conda_init.sh
export CONDA_ENVS_PATH=/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs
bash
mamba activate nextflow-22.10.6
nextflow run amr_finding_pipeline.nf -c amr_finding_uppmax.config -resume
