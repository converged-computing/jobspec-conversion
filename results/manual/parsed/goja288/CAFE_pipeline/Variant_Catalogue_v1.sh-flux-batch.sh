#!/bin/bash
#FLUX: --job-name=dinosaur-chair-0955
#FLUX: -t=721800
#FLUX: --urgency=16

source /mnt/common/SILENT/Act3/conda/miniconda3/etc/profile.d/conda.sh
Nextflow=/mnt/common/Precision/NextFlow/nextflow
module load singularity
$Nextflow run Variant_Catalogue_v1.nf -profile GRCh37 -resume -with-trace -with-report -with-timeline  -with-dag flowchart.png
