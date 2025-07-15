#!/bin/bash
#FLUX: --job-name=gassy-poodle-5692
#FLUX: --urgency=16

module purge
module load python
source activate TOGA
chainfile=$1
targetCDSbed=$2
target2bit=$3
query2bit=$4
outname=$5
isoforms=$6 # tsv file with CDS gene and transcript id as columns
/n/home_rc/afreedman/software/TOGA/toga.py $chainfile $targetCDSbed $target2bit $query2bit --kt --pn $outname -i $isoforms  --nc /n/home_rc/afreedman/software/TOGA/my_nextflow_config_files --cb 10,100 --cjn 750 
