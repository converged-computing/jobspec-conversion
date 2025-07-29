#!/bin/bash
#FLUX: --job-name=nextflow_trim
#FLUX: -n=2
#FLUX: --queue=core
#FLUX: -t=864000
#FLUX: --urgency=16

export CONDA_ENVS_PATH='/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs'

cd /proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/process_sites/
module load conda
source conda_init.sh
export CONDA_ENVS_PATH=/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs
bash
mamba activate nextflow-22.10.6
nextflow run trim_pipeline.nf -c trim_pipeline.config -resume
