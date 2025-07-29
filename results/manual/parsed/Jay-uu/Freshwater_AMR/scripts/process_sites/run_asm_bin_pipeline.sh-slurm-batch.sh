#!/bin/bash
#FLUX: --job-name=nf_asm_bin
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
nextflow run asm_bin_pipeline.nf -c asm_bin_pipeline.config -resume
