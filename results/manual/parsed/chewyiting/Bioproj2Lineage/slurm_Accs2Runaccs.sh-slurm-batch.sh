#!/bin/bash
#FLUX: --job-name=Accs2Runaccs
#FLUX: -t=600
#FLUX: --urgency=16

dirtemplate='/path/to/cloned/repo/Bioproj2Lineage/' # this should point to the cloned github repo! 
bioproj='PRJNA736718'
batchno=23
sras=$(echo ${dirtemplate}'batchedtsvs/'${bioproj}'_batch'${batchno}'_sras.tsv')
reference=$(echo ${dirtemplate}'reference/NC_000962_3.fa')
wanted_lineage='lineage4.2'
basedir=$(pwd)
dirscript=$(echo ${dirtemplate}'scripts/')
mkdir -p sm_Accs2Runaccs
cd ./sm_Accs2Runaccs
cp -n ${dirtemplate}sm_Accs2Runaccs/Snakefile .
module purge
module load miniconda/23.5.2
conda activate snakemake
conda activate bioinfo
snakemake --cores all --config sras=${sras} reference=${reference} wanted_lineage=${wanted_lineage} basedir=${basedir}/sm_Accs2Runaccs/ dirscript=${dirscript}
