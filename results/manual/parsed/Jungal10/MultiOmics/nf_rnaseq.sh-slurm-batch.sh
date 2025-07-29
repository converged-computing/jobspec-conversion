#!/bin/bash
#SBATCH --job-name=rnaseq_projectname
#SBATCH --output=/home/storage/DataLake/WIP/Logs/rnaseq_projectname%j.out
#SBATCH --error=/home/storage/DataLake/WIP/Logs/rnaseq_projectname%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=50
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60GB
#SBATCH --chdir=/home/storage/DataLake/Sandbox/

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
