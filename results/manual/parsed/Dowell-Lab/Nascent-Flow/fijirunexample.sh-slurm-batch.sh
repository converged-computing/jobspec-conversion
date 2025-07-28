#!/bin/bash
#FLUX: --job-name=nextflow
#FLUX: --queue=long
#FLUX: -t=345600
#FLUX: --urgency=16

mkdir -p /scratch/Users/allenma/nexttemp4/
mkdir -p /scratch/Shares/dowell/down/temp/Nascentflow6/
module load sra/2.8.0 
module load bbmap/38.05
module load fastqc/0.11.8
module load hisat2/2.1.0
module load samtools/1.8
module load preseq/2.0.3
module load igvtools/2.3.75
module load mpich/3.2.1 
module load bedtools/2.28.0 
module load openmpi/1.6.4
module load gcc/7.1.0 
source /Users/allenma/Nexflow_pipelines/bin/activate
nextflow run main.nf -profile hg38 --workdir '/scratch/Users/allenma/nexttemp4/' --genome_id 'hg38' --outdir '/scratch/Shares/dowell/down/temp/Nascentflow6/' --email mary.a.allen@colorado.edu --fastqs '/scratch/Shares/dowell/down/temp/*.fastq.gz' --singleEnd --flip --counts --fstitch --tfit --dastk --prelimtfit
