#!/bin/bash
#FLUX: --job-name=minimap2
#FLUX: -c=12
#FLUX: -t=3600
#FLUX: --urgency=16

module load minimap/2.12
PROJ=/ufrc/mcintyre/share/maize_ainsworth
OUTD=$PROJ/mapping_minimap2_b73
    if [ ! -e $OUT ]; then mkdir -p $OUT; fi
IND=$PROJ/isoseq3_analysis/polish_by_individual
DESIGN_FILE=$PROJ/design_files/df_maize_test_PacBio_fullpath_noHeader_allSamples.csv
DESIGN=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $DESIGN_FILE)
IFS=',' read -ra ARRAY <<< "$DESIGN"
PACBIO_NUM=${ARRAY[0]}
GENO=${ARRAY[1]}
TRT=${ARRAY[2]}
ID=${ARRAY[3]}
SAMPLE_NAME=${ID}_${GENO}_${TRT}
REF=/ufrc/mcintyre/share/references/maize_b73/b73_genome_ensemblgenomes/fasta/zea_mays/dna/Zea_mays.B73_RefGen_v4.dna_sm.toplevel.fa
OUT=$OUTD/$GENO/$TRT
    if [ ! -e $OUT ]; then mkdir -p $OUT; fi
IN=$IND/$GENO/$TRT
date
echo "***Combine Polish Fasta.gz***
"
if [ ! -e $OUT/${SAMPLE_NAME}.polished.all.hq.fasta.gz ]; then
    zcat $IN/${SAMPLE_NAME}.*.?.hq.fasta.gz $IN/${SAMPLE_NAME}.*.??.hq.fasta.gz > $OUT/${SAMPLE_NAME}.polished.all.hq.fasta
    echo "    Creating combined polish fasta file"
else
    echo "    Combined polish fasta file already exists"
fi
date
echo "***Combine Polish Fastq.gz***
"
if [ ! -e $OUT/${SAMPLE_NAME}.polished.all.hq.fastq.gz ]; then
    zcat $IN/${SAMPLE_NAME}.*.?.hq.fastq.gz $IN/${SAMPLE_NAME}.*.??.hq.fastq.gz > $OUT/${SAMPLE_NAME}.polished.all.hq.fastq
    echo "    Creating combined polish fastq file"
else
    echo "    Combined polish fastq file already exists"
fi
date
echo "***Minimap2 Map***
"
minimap2 -t 12 -a -x splice -u f --secondary=no -C 5 $REF $OUT/${SAMPLE_NAME}.polished.all.hq.fasta \
    > $OUT/${SAMPLE_NAME}.polished.all.hq.mapped.sam 2>$OUT/${SAMPLE_NAME}.minimap2.log
date
