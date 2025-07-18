#!/bin/bash
#FLUX: --job-name=HTC
#FLUX: -n=16
#FLUX: -t=172800
#FLUX: --urgency=16

module load java/8
module load gatk/3.7
module load picard
MEM=32g
GENOMEIDX=/bigdata/stajichlab/shared/projects/Candida/Clus_reseq/genome/candida_lusitaniae_ATCC42720_w_CBS_6936_MT.fasta
BAMDIR=bam
SAMPLEFILE=samples.info
b=`basename $GENOMEIDX .fasta`
dir=`dirname $GENOMEIDX`
if [ ! -f $dir/$b.dict ]; then
 java -jar $PICARD CreateSequenceDictionary R=$GENOMEIDX O=$dir/$b.dict SPECIES="Candida lusitaniae" TRUNCATE_NAMES_AT_WHITESPACE=true
fi
CPU=$SLURM_CPUS_ON_NODE
if [ ! $CPU ]; then 
 CPU=1
fi
LINE=${SLURM_ARRAY_TASK_ID}
if [ ! $LINE ]; then
 LINE=$1
fi
if [ ! $LINE ]; then
 echo "Need a number via slurm --array or cmdline"
 exit
fi
SAMPLE=`sed -n ${LINE}p $SAMPLEFILE | awk '{print $1}'`
hostname
echo "SAMPLE=$SAMPLE"
OUTDIR=Variants_Adown20
b=`basename $GENOME .fasta`
N=$BAMDIR/$SAMPLE.realign.down.bam
if [ ! -f $OUTDIR/$SAMPLE.g.vcf ]; then
java -Xmx${MEM} -jar $GATK \
  -T HaplotypeCaller \
  -ERC GVCF \
  -ploidy 1 \
  -I $N -R $GENOMEIDX \
  -forceActive -disableOptimizations \
  -o $OUTDIR/$SAMPLE.g.vcf -nct $CPU
fi
