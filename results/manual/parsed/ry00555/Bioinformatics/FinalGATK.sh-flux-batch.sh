#!/bin/bash
#FLUX: --job-name=j_GATK
#FLUX: --queue=batch
#FLUX: -t=28800
#FLUX: --urgency=16

d $SLURM_SUBMIT_DIR
source config.txt
OUTDIR= "/scratch/ry00555/GATKRun109/"
if [ ! -d $OUTDIR ]
then
mkdir -p $OUTDIR
fi
 ml Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4
 trim_galore --paired --length 20 --fastqc --gzip -o ${OUTDIR}/TrimmedReads ${FASTQ}/*fastq\.gz
FILES="${OUTDIR}/TrimmedReads/*R1_001_val_1\.fq\.gz" #Don't forget the *
mkdir "${OUTDIR}/SortedBamFiles"
mkdir "${OUTDIR}/BigWigs"
mkdir "${OUTDIR}/Peaks"
for f in $FILES
do
		#${string//substring/replacement}
	file=${f##*/}
	#remove ending from file name to create shorter names for bam files and other downstream output
	name=${file/%_S[1-99]*_R1_001_val_1.fq.gz/}
	read2=$(echo "$f" | sed 's/R1_001_val_1\.fq\.gz/R2_001_val_2\.fq\.gz/g')
	#variable for naming bam file
 	bam="${OUTDIR}/SortedBamFiles/${name}.bam"
	#variable name for bigwig output
	bigwig="${OUTDIR}/BigWigs/${name}"
	#QualityBam="${OUTDIR}/SortedBamFiles/${name}_Q30.bam"
ml SAMtools/1.9-GCC-8.3.0
ml BWA/0.7.17-GCC-8.3.0
bwa mem -M -v 3 -t $THREADS $GENOME $f $read2 | samtools view -bhSu - | samtools sort -@ $THREADS -T $OUTDIR/SortedBamFiles/tempReps -o "$bam" -
samtools index "$bam"
ml deepTools/3.3.1-intel-2019b-Python-3.7.4
bamCoverage -p $THREADS -bs $BIN --normalizeUsing BPM --smoothLength $SMOOTH -of bigwig -b "$bam" -o "${bigwig}.bin_${BIN}.smooth_${SMOOTH}Bulk.bw"
done
cd $SLURM_SUBMIT_DIR
ml GATK/4.3.0.0-GCCcore-8.3.0-Java-1.8
ml picard/2.27.4-Java-13.0.2
ml BWA/0.7.17-GCC-8.3.0
module load BEDTools/2.29.2-GCC-8.3.0
module load SAMtools/1.10-GCC-8.3.0
module load BEDOPS/2.4.39-foss-2019b
ml Bowtie2/2.4.1-GCC-8.3.0
ml R/3.6.2-foss-2019b
mkdir PanelofNormals
mkdir Run109ReadGroups
mkdir CopyRatios
java -jar $EBROOTPICARD/picard.jar FastqToSam \
       F1=/scratch/ry00555/MapCutandRun/109_58_Genomic_S464_genomic_rep1_S34_R1_001.fastq.gz \
       F2=/scratch/ry00555/MapCutandRun/109_58_Genomic_S464_genomic_rep1_S34_R2_001.fastq.gz \
       R=GCF_000182925.2.fasta \
       O=PicardBamFiles/Picard109_58.bam \
       SM=sample58 \
       RG=rg109 \
       CREATE_INDEX=true \
       PL=ILLUMINA
       java -jar $EBROOTPICARD/picard.jar BuildBamIndex \
             I=Picard109_58.bam
       gatk CountReads \
         -I PicardBamFiles/Picard109_58.bam
         java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
                         -I /scratch/ry00555/OutputRun109/Run109Bam/109_59_Genomic.bam \
                         -O Run109ReadGroups/109_59_Genomic.bamoutput.bam \
                         -RGID 109_59 \
                         -RGLB lib109 \
                         -RGPL illumina \
                         -RGPU null \
                         -RGSM 59
                  samtools index /home/ry00555/Bioinformatics/CrassaGenome/Run109ReadGroups/109_59_Genomic.bamoutput.bam
         gatk CollectReadCounts \
              -I Run109ReadGroups/109_59_Genomic.bamoutput.bam \
              -R GCF_000182925.2.fasta \
              -L Crassa.interval_list \
              --interval-merging-rule OVERLAPPING_ONLY \
              -O 109tsv/109_59.counts.tsv
java -jar $EBROOTPICARD/picard.jar CreateSequenceDictionary \
  -R GCF_000182925.2.fasta \
  -O GCF_000182925.2.dict
java -jar $EBROOTPICARD/picard.jar BedToIntervalList \
-I crassa.bed \
-R GCF_000182925.2.fasta \
-SD GCF_000182925.2.dict \
-O Crassa.interval_list
gatk PreprocessIntervals \
          -R GCF_000182925.2.fasta \
          -L Crassa.interval_list \
          --interval-merging-rule OVERLAPPING_ONLY \
          --bin-length 1000 \
          --padding 0 \
          -O Crassa.preprocessed_intervals.interval_list
          gatk AnnotateIntervals \
                    -R GCF_000182925.2.fasta \
                    -L Crassa.interval_list \
                    --interval-merging-rule OVERLAPPING_ONLY \
                    -O Crassa_annotated_intervals.tsv
java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
                -I /scratch/ry00555/OutputRun109/Run109Bam/109_59_Genomic.bam \
                -O /home/ry00555/Bioinformatics/CrassaGenome/Run109ReadGroups/109_59_Genomic.bamoutput.bam \
                -RGID 1 \
                -RGLB lib1 \
                -RGPL illumina \
                -RGPU S34 \
                -RGSM 109_59
samtools index /home/ry00555/Bioinformatics/CrassaGenome/Run109ReadGroups/109_59_Genomic.bamoutput.bam
java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
                -I /scratch/ry00555/OutputRun109/SortedBamFiles/109_58_Genomic.bam \
                -O /home/ry00555/Bioinformatics/CrassaGenome/Run109ReadGroups/109_58_Genomic.bamoutput.bam \
                -RGID 1 \
                -RGLB lib1 \
                -RGPL illumina \
                -RGPU S34 \
                -RGSM 109_58
samtools index /home/ry00555/Bioinformatics/CrassaGenome/Run109ReadGroups/109_58_Genomic.bamoutput.bam
gatk CollectReadCounts \
     -I /scratch/ry00555/OutputRun109/SortedBamFiles/109_58_Genomic.bam \
     -L Crassa.interval_list \
     --interval-merging-rule OVERLAPPING_ONLY \
     -O /home/ry00555/Bioinformatics/CrassaGenome/109tsv/109_58.counts.tsv
java -jar $EBROOTPICARD/picard.jar ValidateSamFile \
  -I /home/ry00555/Bioinformatics/CrassaGenome/Run109ReadGroups/109_59_Genomic.bamoutput.bam \
  -R /home/ry00555/Bioinformatics/CrassaGenome/GCF_000182925.2.fasta
  MODE=SUMMARY
gatk CollectReadCounts \
     -I /scratch/ry00555/OutputRun109/SortedBamFiles/109_59_Genomic.bam \
     -L Crassa.interval_list \
     --interval-merging-rule OVERLAPPING_ONLY \
     -O /home/ry00555/Bioinformatics/CrassaGenome/109tsv/109_59.counts.tsv
gatk CreateReadCountPanelOfNormals \
  -I 109tsv/109_58.counts.tsv \
  --annotated-intervals Crassa_annotated_intervals.tsv \
  -O PanelofNormals/109_58cnv.pon.hdf5
gatk DenoiseReadCounts \
          -I 109tsv/109_59.counts.tsv \
          --annotated-intervals Crassa_annotated_intervals.tsv \
          --count-panel-of-normals PanelofNormals/109_58cnv.pon.hdf5 \
          --standardized-copy-ratios CopyRatios/109_59.standardizedCR.tsv \
          --denoised-copy-ratios CopyRatios/109_59.denoisedCR.tsv
gatk PlotDenoisedCopyRatios \
                --standardized-copy-ratios CopyRatios/109_59.standardizedCR.tsv \
                --denoised-copy-ratios CopyRatios/109_59.denoisedCR.tsv \
                --sequence-dictionary GCF_000182925.2.dict \
                --output-prefix Run109CNV_59 \
                --output PlotDenoisedCopyRatios
gatk ModelSegments \
  --denoised-copy-ratios CopyRatios/109_59.denoisedCR.tsv \
  --output-prefix 109_59 \
  -O ModelSegments
  gatk CallCopyRatioSegments \
           -I 109_59.cr.seg \
           -O 109_59.called.seg
gatk PlotModeledSegments \
       --denoised-copy-ratios CopyRatios/109_59.denoisedCR.tsv \
 --segments ModelSegments/109_59.modelFinal.seg \
--sequence-dictionary GCF_000182925.2.dict \
--output-prefix 109_59 \
-O PlotModelSegments
scp -r ry00555@xfer.gacrc.uga.edu:/home/ry00555/Bioinformatics/CrassaGenome/PlotModelSegments/109_59.modeled.png /Users/ry00555/Desktop/NeurosporaGenome
scp -r ry00555@xfer.gacrc.uga.edu:/home/ry00555/Bioinformatics/CrassaGenome/PlotDenoisedCopyRatios/Run109CNV_59.denoised.png /Users/ry00555/Desktop/NeurosporaGenome
