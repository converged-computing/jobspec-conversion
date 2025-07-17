#!/bin/bash
#FLUX: --job-name=pensacola
#FLUX: -c=10
#FLUX: -t=172800
#FLUX: --urgency=16

module load nextflow
module load longqc
APPTAINER_CACHEDIR=./
export APPTAINER_CACHEDIR
nextflow run pensacola.nf -params-file params.yaml
mv ./*.out ./output
mv ./*err ./output
dt=$(date "+%Y%m%d%H%M%S")
mv ./output ./output-$dt
rm -r ./work
rm -r ./cache
