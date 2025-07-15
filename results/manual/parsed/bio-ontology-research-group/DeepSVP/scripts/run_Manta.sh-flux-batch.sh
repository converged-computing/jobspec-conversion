#!/bin/bash
#FLUX: --job-name=ng_manta
#FLUX: -t=25200
#FLUX: --urgency=16

REF='/ibex/reference/KSL/hg38/Homo_sapiens_assembly38.fasta'
ID=$1
MANTA_ANALYSIS_PATH="~/$ID"
BAM="~/$ID.sorted.bam"
module load manta/1.6
configManta.py \
--bam $BAM \
--referenceFasta $REF \
--runDir $MANTA_ANALYSIS_PATH
python $MANTA_ANALYSIS_PATH/runWorkflow.py
