#!/bin/bash
#FLUX: --job-name=rer_masterfilename
#FLUX: --queue=savio22_bigmem
#FLUX: -t=259200
#FLUX: --priority=16

module load gcc/4.8.5 openmpi # or module load intel openmpi, ALWAYS required
cd /global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/list_configs/masterfilename/ ;
rm -fr .snakemake ;
snakemake -s /global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/multi_rerconv_trees_Snakefile_new --configfile /global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/list_configs/masterfilename/config_masterfilename.json -j 7 -k
