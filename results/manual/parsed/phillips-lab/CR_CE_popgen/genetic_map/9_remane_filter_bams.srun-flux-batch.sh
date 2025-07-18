#!/bin/bash
#FLUX: --job-name=map_RAD
#FLUX: --queue=phillips
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load bwa samtools easybuild GATK bedtools
ref_CHR="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
outd="/projects/phillipslab/ateterina/CR_map/FINAL"
recalibr="/projects/phillipslab/ateterina/CR_map/FINAL/Parents/Parents_0011_filt_snps_ok.vcf"
picard="/projects/phillipslab/ateterina/scripts/picard/build/libs/picard.jar"
cd $outd/stacks
mkdir -p BAMS2
cp /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/PX506*ba* /projects/phillipslab/ateterina/CR_map/FINAL/stacks/
cp /projects/phillipslab/ateterina/CR_popgen/data/reads/BAMS/PX553*ba* /projects/phillipslab/ateterina/CR_map/FINAL/stacks/
mv *ba* BAMS/
mv PX506.M.ind.bam PX506.bam
mv PX506.M.ind.bai PX506.bam.bai
mv PX553.M.ind.bam PX553.bam
mv PX553.M.ind.bai PX553.bam.bai
for DIR in A1 A2 B1 B2;do
       cd $outd/stacks/$DIR;
	   for file in *.PX506.fin2.ba*;do
		   cp $file $outd/stacks/BAMS2/${DIR}_${file/.PX506.fin2/.FIN};
	   done
done
cd $outd/stacks/BAMS2
for i in *FIN.bam;do
	bedtools intersect -abam $i -b $outd/Parents/Parents_variant_lib.bed > ${i/FIN.bam/TMP.bam}
done
for i in *TMP.bam;do
	bedtools coverage -b $i -sorted -a $outd/Parents/Parents_variant_lib.bed > ${i/bam/COVER}
	awk '{ sum += $4 } END { if (NR > 0) print sum }' ${i/bam/COVER} > ${i/bam/COVER.total}
done
grep "." *TMP*total |grep -v "PX" -  |sort -t":" -k2n |sed -e "s/:/\t/g" - |awk '{if ($2>10000){print;}}' - |cut -f1 -d "_" - |sort | uniq -c
grep "." *TMP*total |grep -v "PX" -  |sort -t":" -k2n |sed -e "s/:/\t/g" - |awk '{if ($2<10000){print;}}' - | cut -f1 >LIST_LOW_COV.txt
mkdir -p DATA_COPY
mv *.* DATA_COPY/
mv DATA_COPY/*[0-9].TMP.ba* .
mkdir -p LOW
while read file; do
	    pattern=${file/.TMP.COVER.total/}; mv $pattern.* LOW/;
done < DATA_COPY/LIST_LOW_COV.txt
