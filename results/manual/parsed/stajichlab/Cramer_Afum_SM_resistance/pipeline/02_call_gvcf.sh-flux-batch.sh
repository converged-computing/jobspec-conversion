#!/bin/bash
#FLUX: --job-name=swampy-chip-1834
#FLUX: -c=8
#FLUX: --queue=short
#FLUX: --urgency=16

module load picard
module load gatk/4
module load bcftools
MEM=32g
SAMPFILE=samples.csv
if [ -f config.txt ]; then
    source config.txt
fi
DICT=$(echo $REFGENOME | sed 's/fasta$/dict/')
if [ ! -f $DICT ]; then
	picard CreateSequenceDictionary R=$GENOMEIDX O=$DICT
fi
mkdir -p $GVCFFOLDER/$GENOMENAME
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
 CPU=$SLURM_CPUS_ON_NODE
fi
N=${SLURM_ARRAY_TASK_ID}
if [ ! $N ]; then
 N=$1
fi
if [ ! $N ]; then
 echo "need to provide a number by --array slurm or on the cmdline"
 exit
fi
hostname
date
IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read STRAIN SAMPID
do
  # BEGIN THIS PART IS PROJECT SPECIFIC LIKELY
  # END THIS PART IS PROJECT SPECIFIC LIKELY
  echo "STRAIN is $STRAIN"
  GVCF=$GVCFFOLDER/$GENOMENAME/$STRAIN.g.vcf
  ALNFILE=$ALNFOLDER/$GENOMENAME/$STRAIN.$HTCEXT
  if [ -s $GVCF.gz ]; then
    echo "Skipping $STRAIN - Already called $STRAIN.g.vcf.gz"
    exit
  fi
  if [[ ! -f $GVCF || $ALNFILE -nt $GVCF ]]; then
      time gatk --java-options -Xmx${MEM} HaplotypeCaller \
   	  --emit-ref-confidence GVCF --sample-ploidy 1 \
   	  --input $ALNFILE --reference $REFGENOME \
   	  --output $GVCF --native-pair-hmm-threads $CPU \
	     -G StandardAnnotation -G AS_StandardAnnotation -G StandardHCAnnotation
 fi
 bgzip --threads $CPU -f $GVCF
 tabix $GVCF.gz
done
date
