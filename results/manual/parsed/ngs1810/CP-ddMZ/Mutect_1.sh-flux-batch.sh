#!/bin/bash
#FLUX: --job-name=butterscotch-banana-4176
#FLUX: -t=172800
#FLUX: --priority=16

module load Java/1.8.0_121
module load GATK/4.0.0.0-Java-1.8.0_121
module load SAMtools
usage()
{
echo "# A script to call somatic variants gatk Mutect2, designed for the Phoenix supercomputer
"
}
BAMDIR=/data/neurogenetics/alignments/Illumina/genomes/CPtwins
OUTDIR=/fast/users/a1742674/outputs/SomaticVcalling/Mutect2_2
PONDIR=/data/neurogenetics/variants/vcf
POPDIR=/data/neurogenetics/RefSeq/GATK/b37
REFDIR=/data/biohub/Refs/human/gatk_bundle/2.8/b37
TEMDIR=$OUTDIR/tempdir
if [ ! -d $BAMDIR ]; then
    echo "$INDIR not found. Please check you have the right one."
        exit 1
fi
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi
if [ ! -d $TEMDIR ]; then
    mkdir -p $TEMDIR
fi
cd $BAMDIR
QUERIES=$(ls $BAMDIR/*.bam | xargs -n 1 basename| cut -f1 -d "-")
gatk Mutect2 \
-R $REFDIR/human_g1k_v37_decoy.fasta \
-I V2038-1.dedup.realigned.recalibrated.bam \
-I V2038-4.dedup.realigned.recalibrated.bam \
-tumor V2038-1 \
-normal V2038-4 \
--germline-resource $POPDIR/somatic-b37_af-only-gnomad.raw.sites.vcf \
--panel-of-normals $PONDIR/pon.vcf.gz \
--af-of-alleles-not-in-resource -1 \
--max-population-af 0.02 \
-O $OUTDIR/V2038.mosaic.PONs_gnomad.vcf
-bamout V2038_tumor_normal_m2.bam
