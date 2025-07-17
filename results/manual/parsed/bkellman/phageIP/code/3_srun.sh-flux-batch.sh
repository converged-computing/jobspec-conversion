#!/bin/bash
#FLUX: --job-name=expressive-mango-2581
#FLUX: -c=20
#FLUX: --queue=medium
#FLUX: -t=259205
#FLUX: --urgency=16

                                           # You can change the filenames given with -o and -e to any filenames you'd like
basedir=/n/scratch/users/b/bek321/phageIP/
cr=50
hd=25
SAMPLES=../data-raw/phipflow_demo_pan-cov-example/sample_table_with_beads_and_lib.DEMO.csv
PEP=../data-raw/peptide_table/VIR3_clean.csv
wait
cd ${basedir}data-raw/fastq/
source /home/${USER}/.bashrc
source activate phipflow2 
COUNTER=1
for infile in *.fastq.gz
do
        base=$(basename ${infile} .fastq.gz)
        trimmomatic SE -threads 2 ${infile} ${base}.trim.fastq.gz CROP:${cr} HEADCROP:${hd} SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:/n/scratch/users/b/bek321/phageIP_PASC/data-raw/peptide_table/VIR3_clean.adapt.fa:2:30:10 &
        COUNTER=$[$COUNTER +1]
       if (( $COUNTER % 10 == 0 ))           # no need for brackets
        then
            wait
        fi
done
wait
cd ${basedir}data-final
nextflow run matsengrp/phip-flow -r V1.12  \
        --sample_table $SAMPLES \
        --peptide_table $PEP \
        --read_length 50 --oligo_tile_length 168 \
        --run_zscore_fit_predict true \
        --run_cpm_enr_workflow true \
        --summarize_by_organism true \
        --output_wide_csv true \
        --output_tall_csv true \
        --peptide_org_col Organism \
        --sample_grouping_col sample_ID \
        --results phipflow_pan_cov_DEMO_"$(date -I)" \
        -resume
