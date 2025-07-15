#!/bin/bash
#FLUX: --job-name=arid-mango-4216
#FLUX: --queue=test
#FLUX: -t=900
#FLUX: --urgency=16

export PERMEDCOE_IMAGES='$(readlink -f $(pwd)/../../../BuildingBlocks/Resources/images/)/'
export PERMEDCOE_ASSETS='$(readlink -f $(pwd)/../../../BuildingBlocks/Resources/assets/)/'
export _DATA_DIR='$(readlink -f ../../Resources/data/)'
export SINGULARITY_BIND='$PERMEDCOE_ASSETS:$PERMEDCOE_ASSETS,$_DATA_DIR:$_DATA_DIR'

export PERMEDCOE_IMAGES=$(readlink -f $(pwd)/../../../BuildingBlocks/Resources/images/)/
export PERMEDCOE_ASSETS=$(readlink -f $(pwd)/../../../BuildingBlocks/Resources/assets/)/
export _DATA_DIR=$(readlink -f ../../Resources/data/)
export SINGULARITY_BIND="$PERMEDCOE_ASSETS:$PERMEDCOE_ASSETS,$_DATA_DIR:$_DATA_DIR"
snakemake --cores 10 meta_analysis 
