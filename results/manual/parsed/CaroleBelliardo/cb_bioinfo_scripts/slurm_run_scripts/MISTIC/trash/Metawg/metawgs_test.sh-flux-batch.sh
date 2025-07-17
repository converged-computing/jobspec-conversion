#!/bin/bash
#FLUX: --job-name=Run1
#FLUX: -c=60
#FLUX: --queue=all
#FLUX: --urgency=16

module purge
module load singularity/3.7.3
module load nextflow/21.04.1
cd /kwak/hub/25_cbelliardo/MISTIC/
nextflow run -profile test,genotoul metagwgs/main.nf \
--type 'SR' \
--input 'metagwgs-test-datasets/small/input/samplesheet.csv' \
--skip_host_filter --skip_kaiju --stop_at_clean
