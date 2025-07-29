#!/bin/bash
#FLUX: --job-name=linkage_map_vanessa_lepmap_dtol
#FLUX: -n=2
#FLUX: --queue=core
#FLUX: -t=172800
#FLUX: --urgency=16

export CONDA_ENVS_PATH='/proj/uppstore2017185/b2014034_nobackup/Karin/envs/'

module load bioinfo-tools
module load conda
export CONDA_ENVS_PATH=/proj/uppstore2017185/b2014034_nobackup/Karin/envs/
module load R/4.0.0
module load R_packages/4.0.0
cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/output/07_LepMak3r_DTOL
conda activate lepmap_snake
snakemake --unlock
snakemake --cores 4 
wait
conda deactivate
