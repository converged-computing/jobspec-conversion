#!/bin/bash
#FLUX: --job-name=milky-general-6976
#FLUX: --priority=16

set -e
. /data/rapleeid/conda/etc/profile.d/conda.sh
conda activate
module load nextflow
nextflow run main.nf -with-dag /home/rapleeid/practice/nextflow/flowchart.html
