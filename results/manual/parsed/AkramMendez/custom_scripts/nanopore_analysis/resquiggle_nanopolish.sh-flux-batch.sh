#!/bin/bash
#FLUX: --job-name=nanopolish
#FLUX: -n=32
#FLUX: --queue=node
#FLUX: -t=43200
#FLUX: --urgency=16

module load bioinfo-tools
module load nanopolish
fastq=$(realpath $1) #Path to basecalled fastQ reads
fast5=$(realpath $2) #Path to fast5 files
bam=$(realpath $3)  #Path to BAM alignment
genome=$(realpath $4)   #Path to reference genome fasta file
summary=$(realpath $5)  #Path to sequencing_summary.txt file
outdir=$(realpath $6)   #Path to output directory
name=$7 #Name for saving the output eventalign file.
cd $SNIC_TMP
echo "Index with Nanopolish"
nanopolish index -d ${fast5} ${fastq}
echo "Nanopolish eventalign"
nanopolish eventalign --reads ${fastq} \
--bam ${bam} \
--genome ${genome} \
--signal-index \
--scale-events \
--summary ${summary} \
--progress \
--threads ${SLURM_NTASKS} >> ${outdir}/${name}_eventalign.txt
echo "Copying index to ${outdir}"
cp *.index ${outdir}
cp *.fai ${outdir}
cp *.gzi ${outdir}
cp *.readdb ${outdir}
echo "Done."
