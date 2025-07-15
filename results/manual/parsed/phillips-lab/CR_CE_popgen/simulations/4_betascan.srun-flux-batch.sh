#!/bin/bash
#FLUX: --job-name=betascan
#FLUX: --queue=phillips
#FLUX: -t=720000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load bedtools
BED="/projects/phillipslab/ateterina/slim/worms_snakemake/ref.windows.40kb.bed"
BED100="/projects/phillipslab/ateterina/slim/worms_snakemake/ref.windows.100kb.bed"
glactools="/projects/phillipslab/ateterina/scripts/glactools/glactools"
reffai="/projects/phillipslab/ateterina/slim/worms_snakemake/ref.fai"
betascan="/projects/phillipslab/ateterina/scripts/BetaScan/BetaScan.py"
dir="/projects/phillipslab/ateterina/slim/worms_snakemake"
if [ ! -f ref.fai ]
then
  echo  -e "1\t3000000" >ref.fai
  bedtools makewindows -g ref.fai -w 40000 > ref.windows.40kb.bed
  bedtools makewindows -g ref.fai -w 100000 > ref.windows.100kb.bed
fi
for simdir in sim30rep sim70rep simmut15 neutral_extra balancing;do
  cd $dir/$simdir
  listfiles=(d*/*[015ypt].vcf)
  name=${listfiles[$SLURM_ARRAY_TASK_ID]}
  filename=(${name//\// })
  echo $filename
  cd ${filename[0]}
  file=${filename[1]}
  #make one header for all files
  if [ ! -f headerBETA.txt ]
  then
	     grep "#" $file > headerBETA.txt
     fi
  rm -f ${file/.vcf/.40kb.BETA}
  rm -f ${file}*TMP*
  while read window; do
	   echo $window > ${file}.TMP.TARGET.bed;
		 sed -i "s/ /\t/g" ${file}.TMP.TARGET.bed;
	   cat headerBETA.txt > ${file}.TMP.vcf;
	   bedtools intersect -b ${file}.TMP.TARGET.bed -a $file >>${file}.TMP.vcf;
	   sed -i "s/\t0\t/\tA\t/g" ${file}.TMP.vcf
	   sed -i "s/\t1\t/\tT\t/g" ${file}.TMP.vcf
	   $glactools vcfm2acf --onlyGT --fai $reffai ${file}.TMP.vcf > ${file}.TMP.acf.gz
	   $glactools acf2betascan --fold ${file}.TMP.acf.gz | gzip > ${file}.TMP.beta.txt.gz
	   #w/o mutations, as we don't know it for the empirical data
	   python2 $betascan -i ${file}.TMP.beta.txt.gz -fold -o ${file}.TMP.betascores.txt
	   #remove first line
	   sed -i '1d' ${file}.TMP.betascores.txt
	   #average values
	   awk '{ sum += $2 } END { if (NR > 0) {print sum / NR ;} else {print "0"}}' ${file}.TMP.betascores.txt > ${file}.TMP.betascores.SUM.txt
	   #combine it with bad
	   paste -d'\t' ${file}.TMP.TARGET.bed ${file}.TMP.betascores.SUM.txt >>${file/.vcf/.40kb.BETA}
   done < $BED
   rm ${file}*TMP.vcf
   rm ${file}.TMP*
done
for simdir in decay decay_balancing exponent fluctuations;do
  cd $dir/$simdir
  listfiles=(d*/*[015ypt].vcf)
  name=${listfiles[$SLURM_ARRAY_TASK_ID]}
  filename=(${name//\// })
  echo $filename
  cd ${filename[0]}
  file=${filename[1]}
  #make one header for all files
  if [ ! -f headerBETA.txt ]
  then
	     grep "#" $file > headerBETA.txt
     fi
  rm -f ${file/.vcf/.100kb.BETA}
  rm -f ${file}*TMP*
  while read window; do
	   echo $window > ${file}.TMP.TARGET.bed;
		 sed -i "s/ /\t/g" ${file}.TMP.TARGET.bed;
	   cat headerBETA.txt > ${file}.TMP.vcf;
	   bedtools intersect -b ${file}.TMP.TARGET.bed -a $file >>${file}.TMP.vcf;
	   sed -i "s/\t0\t/\tA\t/g" ${file}.TMP.vcf
	   sed -i "s/\t1\t/\tT\t/g" ${file}.TMP.vcf
	   $glactools vcfm2acf --onlyGT --fai $reffai ${file}.TMP.vcf > ${file}.TMP.acf.gz
	   $glactools acf2betascan --fold ${file}.TMP.acf.gz | gzip > ${file}.TMP.beta.txt.gz
	   #w/o mutations, as we don't know it for the empirical data
	   python2 $betascan -i ${file}.TMP.beta.txt.gz -fold -o ${file}.TMP.betascores.txt
	   #remove first line
	   sed -i '1d' ${file}.TMP.betascores.txt
	   #average values
	   awk '{ sum += $2 } END { if (NR > 0) {print sum / NR ;} else {print "0"}}' ${file}.TMP.betascores.txt > ${file}.TMP.betascores.SUM.txt
	   #combine it with bad
	   paste -d'\t' ${file}.TMP.TARGET.bed ${file}.TMP.betascores.SUM.txt >>${file/.vcf/.100kb.BETA}
   done < $BED100
   rm ${file}*TMP.vcf
   rm ${file}.TMP*
done
