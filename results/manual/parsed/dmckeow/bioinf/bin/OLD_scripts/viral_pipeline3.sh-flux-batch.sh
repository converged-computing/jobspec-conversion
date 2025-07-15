#!/bin/bash
#FLUX: --job-name=peachy-kitty-2851
#FLUX: -n=8
#FLUX: --queue=amdlarge
#FLUX: -t=86400
#FLUX: --urgency=16

module load minimap2/2.17
module load samtools
module load racon/1.4.20
CANU="/home/dcschroe/dcschroe/dmckeow/canu-2.2/bin/canu"
KRAKEN="/panfs/roc/msisoft/kraken/2.0.7beta/kraken2"
KDB="/panfs/roc/msisoft/kraken/kraken_db"
SEQKIT="/home/dcschroe/dcschroe/dmckeow/seqkit"
module load quast
cd $1
cd REF_"$(basename $1)"
for f in "$(basename $1)"*.mapped.fastq; do
  sed -i 's/ /___/g' "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".contigs.fasta
  sed -i 's/ /___/g' "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".unassembled.fasta
done
for f in "$(basename $1)"*.mapped.fastq; do
  cat "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".contigs.fasta "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".unassembled.fasta | sed 's/ /___/g' > "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".contigsall.fasta
  minimap2 -t 8 -ax map-ont "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".contigsall.fasta ../tmp_allreads.fastq > "$(basename $f .mapped.fastq)"/"$(basename $f .ref1.fna.gz)".racon.sam
  racon -u -m 8 -x -6 -g -8 -w 500 -t 8 ../tmp_allreads.fastq "$(basename $f .mapped.fastq)"/"$(basename $f .ref1.fna.gz)".racon.sam "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".contigsall.fasta > "$(basename $f .mapped.fastq)"/"$(basename $f .mapped.fastq)".contigsall.racon.fasta
done
cd ../DENOVO_"$(basename $1)"
minimap2 -t 8 -ax map-ont "$(basename $1)".contigsall.fasta ../tmp_allreads.fastq > "$(basename $1)".racon.sam
racon -u -m 8 -x -6 -g -8 -w 500 -t 8 ../tmp_allreads.fastq "$(basename $1)".racon.sam "$(basename $1)".contigsall.fasta > "$(basename $1)".contigsall.racon.fasta
