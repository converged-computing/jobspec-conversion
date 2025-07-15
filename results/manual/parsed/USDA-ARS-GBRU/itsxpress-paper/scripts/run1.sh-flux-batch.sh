#!/bin/bash
#FLUX: --job-name=moolicious-cinnamonbun-2373
#FLUX: --priority=16

OUTPUT=../output1
derepout= ../derep_out
analysis= ../analysis
ITS1=../data/its1
ITS2=../data/its2
ITS1_merged=../data/its1_merged
ITS2_merged=../data/its2_merged
ITS1_derep=../data/its1_derep
ITS2_derep=../data/its2_derep
ITS1_derep_report=$analysis/its1_derep_report.txt
ITS2_derep_report=$analysis/its2_derep_report.txt
ITS1_derep_csv=$analysis/its1_derep.csv
ITS2_derep_csv=$analysis/its2_derep.csv
reps=5
source activate itsxpresstestenv
for file in $ITS1/r1/*
  do
  	bname=`basename $file _R1.fastq.gz`
    bbmerge.sh in=$file in2=$ITS1/r2/"$bname"_R2.fastq.gz out=$ITS1_merged/"$bname".fasta
  done
for file in $ITS2/r1/*
  do
  	bname=`basename $file _R1.fastq.gz`
    bbmerge.sh in=$file in2=$ITS2/r2/"$bname"_R2.fastq.gz out=$ITS2_merged/"$bname".fasta
  done
echo "Details about vsearch merging are in the files $ITS1_derep_report and $ITS2_derep_report"
for file in $ITS1_merged/*
  do
  	bname=`basename $file`
    vsearch  --cluster_size $file --centroids $ITS1_derep/$bname --strand both --id 0.995 --threads 8  2>> $ITS1_derep_report
  done
for file in $ITS2_merged/*
  do
    bname=`basename $file`
    vsearch  --cluster_size $file --centroids $ITS2_derep/$bname --strand both --id 0.995 --threads 8 2>> $ITS2_derep_report
  done
python derep.py -i $ITS1_derep_report -t cluster -o $ITS1_derep_csv
python derep.py -i $ITS2_derep_report -t cluster -o $ITS2_derep_csv
for run in {1..$reps}
do
  sbatch --output=$OUTPUT/its1_samples_%A_%a.out --error=$OUTPUT/its1_samples_%A_%a.err test_samples.sh $ITS1 $ITS1_merged $OUTPUT ITS1
  sbatch --output=$OUTPUT/its2_samples_%A_%a.out --error=$OUTPUT/its2_samples_%A_%a.err test_samples.sh $ITS2 $ITS2_merged $OUTPUT ITS2
done
for run in {1..$reps}
do
	sbatch --output=$OUTPUT/its1_threads_%A_%a.out  --error=$OUTPUT/its1-threads_%A_%a.err test_threads.sh $ITS1_merged/4774-4-MSITS2a.fasta $ITS1/r1/4774-4-MSITS2a_R1.fastq.gz $ITS1/r2/4774-4-MSITS2a_R2.fastq.gz $OUTPUT ITS1
	sbatch --output=$OUTPUTits2_threads_%A_%a.out  --error=$OUTPUT/its2-threads_%A_%a.err test_threads.sh $ITS2_merged/4774-13-MSITS3.fasta $ITS2/r1/4774-4-MSITS3_R1.fastq.gz $ITS2/r2/4774-4-MSITS3_R2.fastq.gz $OUTPUT ITS2
done
sbatch --output=$derepout/its1_samples_%A_%a.out --error=$derepout/its1_samples_%A_%a.err test_100_samples.sh $ITS1 $ITS1_merged $derepout ITS1
sbatch --output=$derepout/its2_samples_%A_%a.out --error=$derepout/its2_samples_%A_%a.err test_100_samples.sh $ITS2 $ITS2_merged $derepout ITS2
