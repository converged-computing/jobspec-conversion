#!/bin/bash
#FLUX: --job-name=cowy-leopard-1692
#FLUX: --priority=16

source /mnt/common/SILENT/Act3/conda/miniconda3/etc/profile.d/conda.sh
Nextflow=/mnt/common/Precision/NextFlow/nextflow
module load singularity
prof=$1
$Nextflow run main.nf -profile GRCh38 -resume -with-trace -with-report -with-timeline  -with-dag flowchart.png
