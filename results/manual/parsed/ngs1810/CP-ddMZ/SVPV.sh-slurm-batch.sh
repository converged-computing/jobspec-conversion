#!/bin/bash
#SBATCH --account=robinson
#SBATCH --mail-user=a1742674@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=00:05:00
#SBATCH --partition=batch

INDIR=/fast/users/a1742674/SV_VZ
OUTDIR=/fast/users/a1742674/SV_VZ/V3726_2407
DELLY=/fast/users/a1742674/outputs/SVcalling/dellyOut
REF=/fast/users/a1742674/SV_VZ/SV_ref
CNVNATOR=/fast/users/a1742674/outputs/cnvnator_2_080519
BAMDIR=/data/neurogenetics/alignments/Illumina/genomes/CPtwins
T1=${BAMDIR}/V3726-1.dedup.realigned.recalibrated.bam
F=${BAMDIR}/V3726-2.dedup.realigned.recalibrated.bam
M=${BAMDIR}/V3726-3.dedup.realigned.recalibrated.bam
T2=${BAMDIR}/V3726-4.dedup.realigned.recalibrated.bam
if [ ! -d $INDIR ]; then
    echo "$INDIR not found. Please check you have the right one."
        exit 1
fi
if [ ! -d $OUTDIR ]; then
    mkdir -p $OUTDIR
fi
	ml Python/3.6.1-foss-2016b
	ml numpy/1.12.1-foss-2016b-Python-3.6.1
	ml R/3.6.0-foss-2016b
	ml SAMtools/1.3.1-GCC-5.3.0-binutils-2.25
	ml BCFtools/1.3.1-GCC-5.3.0-binutils-2.25
	python ${INDIR}/SVPV/SVPV -vcf ${DELLY}/V3726_merged.bcf_germline_PASS.vcf -samples V3726-1,V3726-2,V3726-3,V3726-4 -aln $T1,$F,$M,$T2 -o ${OUTDIR}/delly -svtype INV -chrom 10 -ref_gene ${REF}/refGeneCh37_hg19.txt 
