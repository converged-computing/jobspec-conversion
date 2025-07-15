#!/bin/bash
#FLUX: --job-name=43BHEK_unmapped
#FLUX: --queue=normal
#FLUX: -t=259200
#FLUX: --priority=16

    # --ont_reads_txt "/scratch/bag222/data/ont_data/R10_V14_cDNA_Test_202310/final_data/*.txt" \
    # --contamination_ref "../../references/master_contaminant_reference.fasta" \
    # --housekeeping "../../references/hg38.HouseKeepingGenes.bed" \
nextflow ../../workflow/main.nf --ont_reads_fq "./results/44B_Cerebellum/44B_Cerebellum-demultiplexed/*" \
    --ref "/project/mteb223_uksr/sequencing_resources/references/Ensembl/mouse_m39_soft_mask/Mus_musculus.GRCm39.dna_sm.primary_assembly.fa" \
    --annotation "/scratch/bjwh228/cDNA_pipeline/submission/results/Mouse_Brain_discovery/bambu_discovery/extended_annotations.gtf" \
    --cdna_kit "PCS111" \
    --out_dir "44B_Cerebellum_discovery" \
    --is_discovery "False" \
    --track_reads "True" \
    --mapq "10" \
    --step "2" \
    --is_chm13 "False" \
    -resume
