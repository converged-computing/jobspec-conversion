#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: -c=48
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load GCC/11.2.0  OpenMPI/4.1.1  snakemake/6.10.0
module load SAMtools/1.14  BWA/0.7.17
<<README
    snakemake manual: https://snakemake.readthedocs.io/en/stable/index.html
README
genome_file='/scratch/data/bio/GCATemplates/e_coli/ref/GCF_000005845.2_ASM584v2_genomic.fna'
pe1_1='/scratch/data/bio/GCATemplates/e_coli/seqs/SRR10561103_1.fastq.gz'
pe1_2='/scratch/data/bio/GCATemplates/e_coli/seqs/SRR10561103_2.fastq.gz'
threads=$SLURM_CPUS_PER_TASK
output_bam="mapped_reads/A.bam"
echo "rule bwa_map:
    input:
        '$genome_file',
        '$pe1_1',
        '$pe1_2'
    threads: $threads
    output:
        '$output_bam'
    shell:
        'bwa mem -t {threads} {input} | samtools view -Sb - > {output}'" > Snakefile
snakemake --cores $threads
<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html
    - snakemake:
        Johannes Köster, Sven Rahmann, Snakemake—a scalable bioinformatics workflow engine,
        Bioinformatics, Volume 28, Issue 19, 1 October 2012, Pages 2520–2522,
        https://doi.org/10.1093/bioinformatics/bts480
CITATION
