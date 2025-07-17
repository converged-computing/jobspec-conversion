#!/bin/bash
#FLUX: --job-name=eccentric-buttface-8242
#FLUX: --queue=
#FLUX: -t=36000
#FLUX: --urgency=16

pwd; hostname; date
module load software/nextflow-23.04.3
cd <run directory>
work="<work directory>"
nextflow run wes/getFastqBamQualityReports.nf -w ${work} -profile local -resume --threads 4 --njobs 10
