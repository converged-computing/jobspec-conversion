#!/bin/bash
#FLUX: --job-name=fat-hippo-6609
#FLUX: --priority=16

module load SAMtools/1.12-GCC-10.2.0;
mkdir alignment_stats/;
bamdir="bam_hg38nodups"
ls -1 -d ${bamdir}/* | grep -v "bai" > ls_bam_files.txt  # ls -1 prints each file on a new line 
  ## SAMtools depth ##
echo "Calculating depths of filtered reads"
samtools depth -f ls_bam_files.txt -a -H -q 20 -Q 18 -r chrM -d 0 -o alignment_stats/depths_qfilt_${bamdir}.txt
echo "calculating depths of reads (no base or mapping quality filters)"
  ## SAMtools coverage ##
echo "calculating mean coverage of filtered reads across all files";
samtools coverage -b ls_bam_files.txt --excl-flags UNMAP,SECONDARY,QCFAIL,DUP -q 20 -Q 18 -r chrM -o alignment_stats/mean_coverage_qfilt_${bamdir}.txt;
echo "calculating mean coverage of all reads, no base or mapping quality filters";
readarray -t bams < ls_bam_files.txt;
echo "SRRfile	#rname	startpos	endpos	numreads	covbases	coverage	meandepth	meanbaseq	meanmapq" > alignment_stats/all_coverages_qfilt_${bamdir}.txt;
for i in "${bams[@]}";
do
 # remove bam/ prefix from i (bam/SRR*.bam) to get just SRR*.bam
 i_nodir=`echo ${i} | sed "s/${bamdir}\///"`
 i_nodir=${i_nodir/\.bam/}
 echo $i_nodir 
 # # with filters (baseq30)
  echo "${i_nodir}: coverage of filtered reads"
 # samtools coverage $i -q 30 -Q 18 -r chrM --excl-flags UNMAP,SECONDARY,QCFAIL,DUP -o alignment_stats/coverage_qfilt_${i_nodir}.txt;
 # echo "${i_nodir}	`grep chrM alignment_stats/coverage_qfilt_${i_nodir}.txt;`" >> alignment_stats/all_coverages_qfilt_30_${bamdir}.txt
 # rm alignment_stats/coverage_qfilt_${i_nodir}.txt; 
 # with jfilters
 samtools coverage $i -q 20 -Q 18 -r chrM --excl-flags UNMAP,SECONDARY,QCFAIL,DUP -o alignment_stats/coverage_qfilt_${i_nodir}.txt;
 echo "${i_nodir}	`grep chrM alignment_stats/coverage_qfilt_${i_nodir}.txt;`" >> alignment_stats/all_coverages_qfilt_${bamdir}.txt
 rm alignment_stats/coverage_qfilt_${i_nodir}.txt; 
done
rm ls_bam_files.txt;
module purge;
