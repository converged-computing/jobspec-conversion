#!/bin/bash
#FLUX: --job-name=docker-buildgenom
#FLUX: -n=12
#FLUX: --queue=exacloud
#FLUX: -t=14400
#FLUX: --urgency=16

dir=/home/groups/EllrottLab/cell-dissociation
ses=build-ref-genom
threads=11
cd ${dir}
mkdir /mnt/scratch/5420
mkdir /mnt/scratch/5420/${ses}
mkdir /mnt/scratch/5420/${ses}/input
mkdir /mnt/scratch/5420/${ses}/input/reference_files
mkdir /mnt/scratch/5420/${ses}/output
mkdir /mnt/scratch/5420/${ses}/output/genome_ref
cd /mnt/scratch/5420/${ses}/input/reference_files
wget ftp://ftp.ensembl.org/pub/release-98/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
zcat /mnt/scratch/5420/${ses}/input/reference_files/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz > /mnt/scratch/5420/${ses}/input/TEMP-ref.fa
wget ftp://ftp.ensembl.org/pub/release-98/gtf/homo_sapiens/Homo_sapiens.GRCh38.98.gtf.gz
zcat /mnt/scratch/5420/${ses}/input/reference_files/Homo_sapiens.GRCh38.98.gtf.gz > /mnt/scratch/5420/${ses}/input/TEMP-ref.gtf
cd ${dir}
echo '##### Building genome indexes #####'
sudo /opt/acc/sbin/exadocker pull alexdobin/star:2.6.1d
sudo /opt/acc/sbin/exadocker run --rm -v /mnt/scratch/5420/${ses}:/tmp \
    alexdobin/star:2.6.1d \
    STAR \
    --runThreadN ${threads} \
    --runMode genomeGenerate \
    --genomeDir /tmp/output/genome_ref/ \
    --genomeFastaFiles /tmp/input/TEMP-ref.fa \
    --sjdbGTFfile /tmp/input/TEMP-ref.gtf \
    --sjdbOverhang 100 \
    --outFileNamePrefix /tmp/output/genome_ref/Log \
    --genomeSAsparseD 1
echo '##### Cleaning up workspace #####'
cp -r /mnt/scratch/5420/${ses}/output/* /home/groups/EllrottLab/cell-dissociation/raw-data
cp -r /mnt/scratch/5420/${ses}/input/reference_files /home/groups/EllrottLab/cell-dissociation/raw-data
rm -rf /mnt/scratch/5420/${ses}
