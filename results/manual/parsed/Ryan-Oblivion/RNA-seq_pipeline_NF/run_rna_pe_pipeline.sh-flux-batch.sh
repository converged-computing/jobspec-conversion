#!/bin/bash
#FLUX: --job-name=rna_pl
#FLUX: --queue=cm
#FLUX: -t=36000
#FLUX: --priority=16

module purge
module load nextflow/23.04.1
nextflow run -resume pe_rna_sle_pipeline.nf --reads "/scratch/rj931/tf_sle_project/all_sle_data/45*-IAV*polya*_{R1,R2}*.fastq.gz" \
--filts "filt_files/45*-IAV*polya*_{R1,R2}*.filt*"
nextflow run -resume pe_rna_sle_pipeline.nf --reads "/scratch/rj931/tf_sle_project/all_sle_data/45*-IAV*polya*_{R1,R2}*.fastq.gz" \
--filts "filt_files/45*-IAV*polya*_{R1,R2}*.filt*" 
find . -name *fastqc.zip > fastqc_files.txt
module load multiqc/1.9
multiqc -force --file-list fastqc_files.txt --filename 'multiqc_report.html'
