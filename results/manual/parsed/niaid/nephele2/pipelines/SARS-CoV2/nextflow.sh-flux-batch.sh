#!/bin/bash
#FLUX --job-name=blue-spoon-3048
#FLUX --urgency=16

set -e
. /data/rapleeid/conda/etc/profile.d/conda.sh
conda activate
module load nextflow
nextflow run main.nf -with-dag /home/rapleeid/practice/nextflow/flowchart.html
