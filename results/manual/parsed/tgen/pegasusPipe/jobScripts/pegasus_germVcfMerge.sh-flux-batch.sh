#!/bin/bash
#FLUX: --job-name=pegasus_germVCFmerge
#FLUX: -c=8
#FLUX: -t=345600
#FLUX: --urgency=16

set -o pipefail
module load picard-tools/1.128
PICARD=$(which picard.jar)
REFDICT="${REF%.fa}.dict"
time=`date +%d-%m-%Y-%H-%M`
beginTime=`date +%s`
machine=`hostname`
echo "### NODE: $machine" >> ${TRACKNAME}.vcfMergerInQueue
echo "### JOBID: ${SLURM_JOB_ID}" >> ${TRACKNAME}.vcfMergerInQueue
echo "### REF: ${REF}"
echo "### REFDICT: ${REFDICT}"
echo "### RUNDIR: ${RUNDIR}"
echo "### NXT1: ${NXT1}"
echo "### SAMTOOLSPATH: ${SAMTOOLSPATH}"
echo "### BCFTOOLSPATH: ${BCFTOOLSPATH}"
echo "### BAMFILE: ${BAMFILE}"
echo "### D: ${D}"
echo "### BEDFILE: ${BEDFILE}"
echo "### CHRLIST: ${CHRLIST}"
echo "### GATKPATH: ${GATKPATH}"
echo "### HCVCF: $HCVCF"
echo "### FBVCF: $FBVCF"
echo "### MPVCF: $MPVCF"
echo "### VTPATH: $VTPATH"
echo "### TRACKNAME: ${TRACKNAME}"
echo "### Germline vcf merger started at $time."
java -jar ${PICARD} SortVcf I=${HCVCF} O=${TRACKNAME}.HC.sorted.vcf SD=${REFDICT}
cat ${TRACKNAME}.HC.sorted.vcf | ${VTPATH}/vt normalize - -r ${REF} | ${VTPATH}/vt uniq - -o ${TRACKNAME}.HC.norm.vcf
if [ $? -eq 0 ] ; then
    echo "hcVcf was normalized correctly"
else
    touch ${TRACKNAME}.vcfMergerFail
    rm -f ${TRACKNAME}.vcfMergerInQueue
    exit 1
fi
java -jar ${PICARD} SortVcf I=${FBVCF} O=${TRACKNAME}.freebayes.sorted.vcf SD=${REFDICT}
cat ${TRACKNAME}.freebayes.sorted.vcf | ${VTPATH}/vt normalize - -r ${REF} | ${VTPATH}/vt uniq - -o ${TRACKNAME}.freebayes.norm.vcf
if [ $? -eq 0 ] ; then
    echo "fbVcf was normalized correctly"
else
    touch ${TRACKNAME}.vcfMergerFail
    rm -f ${TRACKNAME}.vcfMergerInQueue
    exit 1
fi
java -jar ${PICARD} SortVcf I=${MPVCF} O=${TRACKNAME}.mpileup.sorted.vcf SD=${REFDICT}
cat ${TRACKNAME}.mpileup.sorted.vcf | ${VTPATH}/vt normalize - -r ${REF} | ${VTPATH}/vt uniq - -o ${TRACKNAME}.mpileup.norm.vcf
if [ $? -eq 0 ] ; then
    echo "mpVcf was normalized correctly"
else
    touch ${TRACKNAME}.vcfMergerFail
    rm -f ${TRACKNAME}.vcfMergerInQueue
    exit 1
fi
java -jar ${GATKPATH}/GenomeAnalysisTK.jar \
    -T CombineVariants \
    -R ${REF} \
    --variant:haplotypeCaller ${TRACKNAME}.HC.norm.vcf \
    --variant:freebayes ${TRACKNAME}.freebayes.norm.vcf \
    --variant:mpileup ${TRACKNAME}.mpileup.norm.vcf \
    --genotypemergeoption UNIQUIFY \
    --disable_auto_index_creation_and_locking_when_reading_rods \
    --out ${TRACKNAME}.merged.vcf
if [ $? -eq 0 ] ; then
    echo "the 3 variant callers were merged successfully"
    touch ${TRACKNAME}.vcfMergerPass
else
    touch ${TRACKNAME}.vcfMergerFail
    exit 1
fi
rm -f ${TRACKNAME}.vcfMergerInQueue
endTime=`date +%s`
elapsed=$(( $endTime - $beginTime ))
(( hours=$elapsed/3600 ))
(( mins=$elapsed%3600/60 ))
echo "RUNTIME:GERMVCFMERGE:$hours:$mins" > ${TRACKNAME}.germVcfMerge.totalTime
time=`date +%d-%m-%Y-%H-%M`
echo "Germline vcf Merger finished at $time."
