#!/bin/bash
#FLUX: --job-name=delicious-general-0537
#FLUX: -c=16
#FLUX: --queue=himem
#FLUX: --priority=16

InputSam=$1
Prefix=$2
Filename=$(basename "$InputSam")
OutDir=$(dirname "$InputSam")
Name="${Filename%.*}"
CurDir=$PWD
WorkDir="$TMPDIR"
mkdir -p $WorkDir
cp $InputSam $WorkDir/.
cd $WorkDir
Extension=$(echo $Filename | rev | cut -f1 -d '.' | rev)
if [[ $Extension == "bam" ]]; then
  echo ".bam file extension found"
  echo "converting to sam"
  samtools view --threads 8 -o $Name.sam $CurDir/$InputSam
  echo "Reheadering the bam file using the original sam headers"
  samtools view -H $CurDir/$InputSam > header.sam
  cat header.sam $Name.sam > ${Name}_reheader.sam
  Filename=${Name}_reheader.sam
fi
echo "Removing reads with the XS:i flag (multimapping reads)"
grep -v "XS:i" $Filename > tmp.sam
echo "Converting sam to bam format"
samtools view --threads 8 -bS -o $Name.bam tmp.sam
echo "Sorting and indexing the bam file"
samtools sort --threads 8 -o "$Name"_nomulti_sorted.bam $Name.bam
samtools index -@ 8 "$Name"_nomulti_sorted.bam "$Name"_nomulti_sorted.bam.index
echo "Filtering reads to retain only concordant paired reads"
samtools view -b -h -f 3 -o "$Name"_nomulti_proper.bam "$Name"_nomulti_sorted.bam
"Sorting and indexing concordant, paired reads bam file"
samtools sort --threads 8 -o "$Name"_nomulti_proper_sorted.bam "$Name"_nomulti_proper.bam
samtools index -@ 8 "$Name"_nomulti_proper_sorted.bam "$Name"_nomulti_proper_sorted.bam.index
echo "Using picard tools to remove duplicate reads"
ProgDir=/projects/oldhome/sobczm/bin/picard-tools-2.5.0
java -jar $ProgDir/picard.jar MarkDuplicates \
  INPUT="$Name"_nomulti_proper_sorted.bam \
  OUTPUT="$Name"_nomulti_proper_sorted_nodup.bam \
  METRICS_FILE="$Name"_nomulti_proper_sorted_nodup.txt \
  REMOVE_DUPLICATES=TRUE ASSUME_SORTED=TRUE MAX_RECORDS_IN_RAM=500000000 \
  MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 VALIDATION_STRINGENCY=LENIENT
echo "Adding the given sample information to the BAM file: $Prefix"
java -jar $ProgDir/picard.jar AddOrReplaceReadGroups \
  INPUT="$Name"_nomulti_proper_sorted_nodup.bam \
  OUTPUT="$Name"_nomulti_proper_sorted_nodup_rg.bam \
  SORT_ORDER=coordinate CREATE_INDEX=true RGID=$Prefix  RGSM=$Prefix \
  RGPL=Illumina RGLB=library RGPU=barcode VALIDATION_STRINGENCY=LENIENT
  samtools index "$Name"_nomulti_proper_sorted_nodup_rg.bam
mv "$Name"_nomulti_proper_sorted_nodup.txt $CurDir/$OutDir/.
mv "$Name"_nomulti_proper_sorted_nodup_rg.bam $CurDir/$OutDir/.
mv "$Name"_nomulti_proper_sorted_nodup_rg.bam.bai $CurDir/$OutDir/.
rm -rf $WorkDir
