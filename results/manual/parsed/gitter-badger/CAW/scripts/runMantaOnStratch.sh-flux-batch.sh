#!/bin/bash
#FLUX: --job-name=fuzzy-banana-2004
#FLUX: --queue=node
#FLUX: -t=604800
#FLUX: --urgency=16

export NXF_TEMP='/scratch'
export NXF_LAUNCHBASE='/scratch'
export NXF_WORK='/scratch'

module load Nextflow
export NXF_TEMP=/scratch
export NXF_LAUNCHBASE=/scratch
export NXF_WORK=/scratch
nextflow run /home/szilva/CAW/main.nf -c /home/szilva/CAW/nextflow.config -profile localhost --project sens2016004 --verbose --steps skipPreprocessing,Manta --sample Preprocessing/Recalibrated/recalibrated.tsv
