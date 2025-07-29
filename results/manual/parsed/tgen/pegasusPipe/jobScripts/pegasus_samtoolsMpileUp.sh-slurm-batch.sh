#!/bin/bash
#FLUX: --job-name=pegasus_samtoolsMpileUp
#FLUX: -c=8
#FLUX: -t=345600
#FLUX: --urgency=16

time=`date +%d-%m-%Y-%H-%M`
beginTime=`date +%s`
machine=`hostname`
echo "### NODE: $machine"
echo "### REF: ${REF}"
echo "### RUNDIR: ${RUNDIR}"
echo "### NXT1: ${NXT1}"
echo "### NXT2: ${NXT2}"
echo "### SAMTOOLSPATH: ${SAMTOOLSPATH}"
echo "### BCFTOOLSPATH: ${BCFTOOLSPATH}"
echo "### TRACKNAME: ${TRACKNAME}"
echo "### BAMFILE: ${BAMFILE}"
echo "### D: ${D}"
echo "### BEDFILE: ${BEDFILE}"
echo "### CHRLIST: ${CHRLIST}"
echo "### STEP: ${STEP}"
echo "### STEPCOUNT: ${STEPCOUNT}"
echo "### GATKPATH: ${GATKPATH}"
echo "### samtools mpileup started at $time."
echo "${SAMTOOLSPATH}/samtools mpileup \
    -DsSOg \
    -C 50 \
    -F 0.01 \
    -l ${CHRLIST}/Step${STEP}.bed \
    -f ${REF} \
    ${BAMFILE} | \
${BCFTOOLSPATH}/bcftools call \
    -vmO v \
    -o ${TRACKNAME}_Step${STEP}.mpileup.vcf"
${SAMTOOLSPATH}/samtools mpileup \
    -DsSOg \
    -C 50 \
    -F 0.01 \
    -l ${CHRLIST}/Step${STEP}.bed \
    -f ${REF} \
    ${BAMFILE} | \
${BCFTOOLSPATH}/bcftools call \
    -vmO v \
    -o ${TRACKNAME}_Step${STEP}.mpileup.vcf
if [ $? -eq 0 ] ; then
    echo mpileup_${STEP}.Done
    echo "${SLURM_JOB_ID}" > ${TRACKNAME}_Step${STEP}.samtoolsMpileUpPass
    PROGRESS=$(ls ${TRACKNAME}*samtoolsMpileUpPass | wc -l)
else
    echo "${SLURM_JOB_ID}" > ${TRACKNAME}_Step${STEP}.samtoolsMpileUpFail
    rm -f ${TRACKNAME}_Step${STEP}.samtoolsMpileUpInQueue
    exit 1
fi
vcfList=""
for i in `seq 1 ${STEPCOUNT}`; do
    thisVcf="-V ${TRACKNAME}_Step$i.mpileup.vcf "
    vcfList="$vcfList $thisVcf"
done
if [ ${PROGRESS} -eq ${STEPCOUNT} ]
then
    #Concatenate VCF with GATK
    echo "java -cp ${GATKPATH}/GenomeAnalysisTK.jar org.broadinstitute.gatk.tools.CatVariants --reference ${REF} $vcfList -out ${TRACKNAME}.mpileup_All.vcf -assumeSorted"
    java -cp ${GATKPATH}/GenomeAnalysisTK.jar org.broadinstitute.gatk.tools.CatVariants --reference ${REF} $vcfList -out ${TRACKNAME}.mpileup_All.vcf -assumeSorted
    if [ $? -eq 0 ] ; then
        touch ${TRACKNAME}.samtoolsMpileUpPass
        touch ${RUNDIR}/${NXT1}
        touch ${RUNDIR}/${NXT2}
    else
        touch ${TRACKNAME}.samtoolsMpileUpFail
    fi
else
    echo mpileup_${STEP}.Done
fi
rm -f ${TRACKNAME}_Step${STEP}.samtoolsMpileUpInQueue
endTime=`date +%s`
elapsed=$(( $endTime - $beginTime ))
(( hours=$elapsed/3600 ))
(( mins=$elapsed%3600/60 ))
echo "RUNTIME:SAMTOOLSMPILEUP:$hours:$mins" > ${TRACKNAME}_Step${STEP}.samtoolsPileUp.totalTime
time=`date +%d-%m-%Y-%H-%M`
echo "SamtoolsMPileUp finished at $time."
