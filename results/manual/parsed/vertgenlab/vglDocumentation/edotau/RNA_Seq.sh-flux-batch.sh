#!/bin/bash
#FLUX: --job-name=Snps.RNA-Seq
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

set -e
module load GATK/4.1.0.0-gcb01 java/1.8.0_45-fasrc01 samtools/1.9-gcb01 fastqc/0.11.5-fasrc01 STAR/2.7.2b-gcb01
picard=/data/lowelab/edotau/software/picard.jar
star_ref=/data/lowelab/edotau/toGasAcu1.5/idx/STAR_2
REF=/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa
input1=$1
input2=$2
PREFIX=$(echo $input1 | cut -d '_' -f 1)
bn=$PREFIX
opdir=$bn".RNA-Seq"
mkdir -p $opdir
READ1=$opdir/${PREFIX}_R1.fastq.gz
READ2=$opdir/${PREFIX}_R2.fastq.gz
fastqc -t $SLURM_CPUS_ON_NODE $input1 $input2 -o $opdir
/data/lowelab/edotau/bin/github.com/bbmap/bbduk.sh \
	in1=$input1 \
	in2=$input2 \
	out1=$READ1 \
	out2=$READ2 \
	minlen=25 qtrim=rl trimq=10 ktrim=r k=25 mink=11 hdist=1 \
	ref=/data/lowelab/edotau/bin/github.com/bbmap/resources/adapters.fa
echo -e "["$(date)"]\tAligning.."
STAR --outFileNamePrefix $opdir/$bn --outSAMtype BAM Unsorted --outSAMstrandField intronMotif --outSAMattrRGline ID:$bn CN:Gonomics LB:PairedEnd PL:Illumina PU:HiSeqX SM:$bn --genomeDir $star_ref --runThreadN $SLURM_CPUS_ON_NODE --readFilesCommand zcat --readFilesIn $READ1 $READ2 --twopassMode Basic
echo -e "["$(date)"]\tSorting.."
samtools sort -@ $SLURM_CPUS_ON_NODE -o $opdir/$bn"_sorted.bam" $opdir/$bn"Aligned.out.bam"
rm $opdir/$bn"Aligned.out.bam"
echo -e "["$(date)"]\tIndexing.."
samtools index -@ $SLURM_CPUS_ON_NODE $opdir/$bn"_sorted.bam"
echo -e "["$(date)"]\tMarking duplicates.."
java -Xmx12G -jar $picard MarkDuplicates I=$opdir/$bn"_sorted.bam" O=$opdir/$bn"_dupMarked.bam" M=$opdir/$bn"_dup.metrics" CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT 2>$opdir/$bn.MarkDuplicates.log
rm $opdir/$bn"_sorted.bam"
rm $opdir/$bn"_sorted.bam.bai"
echo "RNA transcript ASSEMBLY...(stringtie)"
module add StringTie/2.1.1-gcb01
gtf=/data/lowelab/edotau/toGasAcu1.5/RNA-Seq/stickleback_f1_hybrid.gtf
stringtie $opdir/$bn"_dupMarked.bam" -p $SLURM_CPUS_ON_NODE -G $gtf -o ${PREFIX}.RNA-Seq.gtf -l ${PREFIX^^} -v
echo -e "["$(date)"]\tSpliting reads.."
gatk SplitNCigarReads --java-options "-Xmx12G" --input $opdir/$bn"_dupMarked.bam" --output $opdir/$bn"_split.bam" --reference $REF 2>$opdir/$bn.SplitNCigarReads.log
samtools index -@ $SLURM_CPUS_ON_NODE $opdir/$bn"_split.bam"
submit=${PREFIX}.gatk.txt
exit 0
