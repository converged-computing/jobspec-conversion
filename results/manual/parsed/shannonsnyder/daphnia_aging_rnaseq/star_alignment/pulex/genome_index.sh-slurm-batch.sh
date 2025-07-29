#!/bin/bash
#FLUX: --job-name=star_index
#FLUX: -n=4
#FLUX: -c=12
#FLUX: --queue=memory
#FLUX: -t=10800
#FLUX: --urgency=16

module load easybuild
module load icc/2017.1.132-GCC-6.3.0-2.27
module load impi/2017.1.132                                                                             \
module load STAR/2.5.3a
genome_fasta="/projects/nereus/ssnyder3/aging_rnaseq/genomes/dpulex/ncbi-genomes-2023-05-22/GCF_021134715.1_A\
SM2113471v1_genomic.fna"
index_dir="/projects/nereus/ssnyder3/aging_rnaseq/genomes/dpulex/ncbi-genomes-2023-05-22/indexDirectory_modload"
GTFfile_path="/projects/nereus/ssnyder3/aging_rnaseq/genomes/dpulex/ncbi-genomes-2023-05-22/GCF_021134715.1_ASM211347\
1v1_genomic.gtf" #note: I generated this file from a GFF using cufflinks
num_threads=4
/usr/bin/time -v STAR --runMode genomeGenerate \
      --genomeDir $index_dir \
      --genomeFastaFiles $genome_fasta \
      --runThreadN $num_threads \
      --sjdbGTFfile $GTFfile_path \
      --genomeSAindexNbases 12
if [ $? -eq 0 ]; then
  echo "Genome indexing completed successfully!"
else
  echo "Genome indexing failed!"
fi
