#!/bin/bash
#FLUX: --job-name=Run1
#FLUX: -c=60
#FLUX: --queue=all
#FLUX: --urgency=16

module purge
module load singularity/3.7.3
module load nextflow/21.04.1
cd '/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/'
nextflow run -profile genotoul metagwgs/main.nf \ #--skip_host_filter  \
--skip_host_filter \
--skip_kaiju \
--type 'SR' \
--quality_type "illumina" \
--adapter1 "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" \
--adapter2 "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" \ #--kaiju_db \
--stop_at_clean \ #--diamond_bank "/database/hub/NR/NR_diamond/NR_2020_01_diamond.dmnd" \ #--gtdbtk_bank "/database/hub/GTDB/release20211115/"  \ #--eggnogmapper_db_download \
--input "/kwak/hub/25_cbelliardo/MISTIC/Salade_I/2_QC_fastq/list_wgstool.csv"  
