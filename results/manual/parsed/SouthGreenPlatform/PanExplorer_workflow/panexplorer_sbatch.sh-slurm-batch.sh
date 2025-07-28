#!/bin/bash
#FLUX: --job-name=panexplorer
#FLUX: -c=18
#FLUX: --queue=supermem
#FLUX: --urgency=16

export PANEX_PATH='$PWD'

module load singularity/4.0.1
export PANEX_PATH=$PWD
singularity exec $PANEX_PATH/singularity/panexplorer.sif snakemake --cores 1 -s Snakemake_files/Snakefile_pggb_heatmap_upset
