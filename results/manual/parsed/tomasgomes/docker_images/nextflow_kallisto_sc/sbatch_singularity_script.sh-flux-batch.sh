#!/bin/bash
#FLUX: --job-name=test_wrapper
#FLUX: -c=2
#FLUX: -t=43200
#FLUX: --priority=16

singularity run --mount type=bind,src=$(pwd),dst=/rootvol \
        /mnt/beegfs/singularity/images/nextflow_kallisto_sc.sif run \
        /rootvol/kallisto_pipeline.nf --transcriptome \
        /rootvol/human_Ens109_GRCh38p13.fa.gz --velomode true \
        --genome /rootvol/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
        --gtf /rootvol/genome/Homo_sapiens.GRCh38.110.gtf.gz \
        --overhang 100 --cores 12 --white /rootvol/10xv3_whitelist.txt \
        --protocol 10xv3 --samplename "test_velo_10xv3" --outdir /rootvol/ \
        --t2g /rootvol/human_Ens109_GRCh38p13_t2g.txt --geneid "both" \
        --reads "/rootvol/Brain_Tumor_3p_fastqs/*.fastq.gz"
