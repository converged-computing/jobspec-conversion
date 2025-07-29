#!/bin/bash
#FLUX: --job-name=Zhang_Nextflow
#FLUX: --queue=batch
#FLUX: -t=345600
#FLUX: --urgency=16

SUBDIR=$(pwd)
if [[ ! -d /scratch/bjl34716/nf_dev/gg-catalog ]]; then
    mkdir -p /scratch/bjl34716/nf_dev/gg-catalog
fi
cd /scratch/bjl34716/nf_dev/gg-catalog
module load Nextflow/22.04.5
nextflow run lorentzben/gg-catalog-nf \
        -r main \
        -with-tower \
        -c /home/bjl34716/applegate/villegas/compare_methods/.nextflow/config/gacrc.config \
        -profile slurm,singularity \
        -params-file /home/bjl34716/my_utils/gg-catalog/code/params/test_params.yaml \
        -latest \
        -resume
