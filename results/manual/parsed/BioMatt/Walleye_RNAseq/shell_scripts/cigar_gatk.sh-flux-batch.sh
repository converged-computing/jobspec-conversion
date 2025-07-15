#!/bin/bash
#FLUX: --job-name=astute-avocado-9971
#FLUX: -t=86400
#FLUX: --priority=16

module load nixpkgs/16.09 intel/2018.3
module load gatk/4.0.8.1
echo "yes"
workingdir="/home/biomatt/scratch"
list=wall_dir.txt
string="sed -n "$SLURM_ARRAY_TASK_ID"p ${list}" 
str=$($string) 
var=$(echo $str | awk -F"\t" '{print $1}') 
set -- $var 
c1=$1 
echo "$c1" 
java -jar /cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/gatk/4.0.8.1/gatk-package-4.0.8.1-local.jar \
SplitNCigarReads --reference /home/biomatt/projects/def-kmj477/biomatt/Lace_files_annotated/walleye_lace.fasta \
--input ${workingdir}/markdup_bam/${c1}_pic_markdup.bam --output ${workingdir}/cigar_split/${c1}_cigar.bam
