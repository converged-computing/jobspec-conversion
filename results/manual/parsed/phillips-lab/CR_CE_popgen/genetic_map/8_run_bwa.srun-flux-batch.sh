#!/bin/bash
#FLUX: --job-name=map_RAD
#FLUX: -c=4
#FLUX: --queue=phillips
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load bwa samtools easybuild GATK
ref_CHR="/projects/phillipslab/shared/ref_genomes/CR_PB_HIC/NCBI/CR.ncbi.softmasked.fasta"
outd="/projects/phillipslab/ateterina/CR_map/FINAL"
recalibr="/projects/phillipslab/ateterina/CR_map/FINAL/Parents/Parents_variant_lib.vcf"
regions="/projects/phillipslab/ateterina/CR_map/FINAL/Parents/Parents_variant_lib.bed"
picard="/projects/phillipslab/ateterina/scripts/picard/build/libs/picard.jar"
for DIR in A1 A2 B1 B2;do
		cd $outd/stacks/$DIR;
		LISTFILES=(*.fp1.fastq)
		file=${LISTFILES[$SLURM_ARRAY_TASK_ID]}
		name=${file/.fp1.fastq/}
		#map
		echo $file;
		bwa mem -M -R "@RG\tID:$name\tSM:$name\tPL:ILLUMINA\tPI:330" -t 16 $ref_CHR $file ${file/.fp1./.fp2.}>${file/.fp1.fastq/.PX506.m.sam} 2>$file.bwa.PX506.m.log;
		samtools view -bS ${file/.fp1.fastq/.PX506.m.sam}  >${file/.fp1.fastq/.PX506.m.TMP.bam}
		samtools sort -@ 4 -o ${file/.fp1.fastq/.PX506.sm.TMP.bam} ${file/.fp1.fastq/.PX506.m.TMP.bam};
		samtools index ${file/.fp1.fastq/.PX506.sm.TMP.bam}
	#mark duplicates
	java -Xmx20g -jar $picard MarkDuplicates MAX_RECORDS_IN_RAM=100000 INPUT=${file/.fp1.fastq/.PX506.sm.TMP.bam} OUTPUT=${file/.fp1.fastq/.PX506.ded.TMP.bam} METRICS_FILE=${file/.fp1.fastq/.PX506.TMP.metric} REMOVE_DUPLICATES=false;
	java -Xmx20g -jar $picard BuildBamIndex INPUT=${file/.fp1.fastq/.PX506.ded.TMP.bam};
		#recalibrate alignments
		java -Xmx10g -jar $EBROOTGATK/GenomeAnalysisTK.jar  -T BaseRecalibrator  -R $ref_CHR -I ${file/.fp1.fastq/.PX506.ded.TMP.bam} -knownSites $recalibr -o ${file/.fp1.fastq/.TMP.table};
		java -Xmx10g -jar $EBROOTGATK/GenomeAnalysisTK.jar -T PrintReads -R $ref_CHR -I ${file/.fp1.fastq/.PX506.ded.TMP.bam} -BQSR ${file/.fp1.fastq/.TMP.table} -o ${file/.fp1.fastq/.rec.TMP.bam};
		###filter multiple mapped and softmasked reads###
		samtools view -h ${file/.fp1.fastq/.rec.TMP.bam} >${file/.fp1.fastq/.rec.TMP.sam}
		grep -P "^@" ${file/.fp1.fastq/.rec.TMP.sam}>${file/.fp1.fastq/.PX506.m.f.TMP.sam};grep -vP "XA:|@" ${file/.fp1.fastq/.rec.TMP.sam}  >>${file/.fp1.fastq/.PX506.m.f.TMP.sam};
		samtools view  -@ 4 -F 4 -bS -q 15 -o ${file/.fp1.fastq/.PX506.m.f.TMP.bam} -L $regions ${file/.fp1.fastq/.PX506.m.f.TMP.sam};
		samtools sort -@ 4 -o ${file/.fp1.fastq/.PX506.fin2.bam} ${file/.fp1.fastq/.PX506.m.f.TMP.bam};
		samtools index ${file/.fp1.fastq/.PX506.fin2.bam};
done
