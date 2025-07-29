#!/bin/bash
#FLUX: --job-name=SR
#FLUX: -c=60
#FLUX: --queue=all
#FLUX: --urgency=16

module load singularity/3.5.3
module load nextflow/21.04.1
cd '/kwak/hub/25_cbelliardo/25_MISTIC/tools'
nextflow run -profile singularity metagwgs/main.nf \
--skip_host_filter  \
--type 'SR' \
--quality_type "illumina" \
--adapter1 "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" \
--adapter2 "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" \
--kaiju_db \
--diamond_bank "/database/hub/NR/NR_diamond/NR_2020_01_diamond.dmnd" \
--gtdbtk_bank "/database/hub/GTDB/release20211115/"  \
--eggnogmapper_db_download \
--input "/kwak/hub/25_cbelliardo/25_MISTIC/LRvsSR/list_wgstool.csv"  
