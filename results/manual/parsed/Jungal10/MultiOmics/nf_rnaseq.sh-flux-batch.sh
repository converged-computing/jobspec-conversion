#!/bin/bash
#FLUX: --job-name=rnaseq_projectname
#FLUX: -n=50
#FLUX: --urgency=16

OUTDIR="/home/storage/DataLake/WIP/RNASeq/outdir_projectname"
WORKDIR="/home/cache/work_dias/"
INPUT_DATASHEET="/home/storage/DataLake/Input_datasheets/RNASeq_input_projectname.csv"
nextflow run nf-core/rnaseq \
-profile singularity \
-r 3.12.0 \
--input $INPUT_DATASHEET \
--outdir $OUTDIR \
-w $WORKDIR  \
-c ../Config_files/slurmstandard.config \
--fasta /home/storage/DataLake/Resources/assemblies/ENSEMBL/hg38/109/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
--igenomes_base /home/storage/DataLake/Resources/assemblies/ENSEMBL/hg38/109/ \
--gtf /home/storage/DataLake/Resources/assemblies/ENSEMBL/hg38/109/Homo_sapiens.GRCh38.109.gtf \
--remove_ribo_rna \
-resume
