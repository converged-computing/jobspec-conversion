#!/bin/bash
#FLUX: --job-name=pegasus_snpEff
#FLUX: --exclusive
#FLUX: -t=57600
#FLUX: --urgency=16

beginTime=`date +%s`
machine=`hostname`
echo "### NODE: $machine"
echo "### DBVERSION: ${DBVERSION}"
echo "### VCF: ${VCF}"
echo "### SNPEFFPATH: ${SNPEFFPATH}"
echo "### RUNDIR: ${RUNDIR}"
echo "### NXT1: ${NXT1}"
echo "### Starting snpEff Annotator of vcf file: ${VCF}"
OUT=${VCF/.proj.md.bam}
snpEffOut=${OUT/.vcf/.snpEff.vcf}
snpEffInt=${OUT/.vcf/.snpEffInt.vcf}
snpEffTxt=${OUT/.vcf/.snpEff.txt}
summaryOut=${OUT/.vcf/.snpEff.summary_html}
set -e
java -Xmx6g -jar ${SNPEFFPATH}/snpEff.jar eff \
    -v \
    -i vcf \
    -o txt \
    -noLog \
    -s ${summaryOut} \
    -c ${SNPEFFPATH}/snpEff.config \
    ${DBVERSION} \
    ${VCF} > $snpEffTxt
java -Xmx6g -jar ${SNPEFFPATH}/snpEff.jar eff \
    -v \
    -i vcf \
    -o vcf \
    -noLog \
    -s ${summaryOut} \
    -c ${SNPEFFPATH}/snpEff.config \
    ${DBVERSION} \
    ${VCF} > $snpEffInt
set +e
if [ $? -ne 0 ] ; then
    echo "snpEff first part failed." >> ${VCF}.snpEffOut
    mv ${VCF}.snpEffOut ${VCF}.snpEffFail
else
    echo "snpEff first part complete." >> ${VCF}.snpEffOut
    echo "snpEff second part (snpSift) starting." >> ${VCF}.snpEffOut
    java -Xmx6g -jar ${SNPEFFPATH}/SnpSift.jar annotate \
        ${DBSNP} \
        $snpEffInt > $snpEffOut
    if [ $? -eq 0 ] ; then
        echo "snpEff second part (snpSift) complete." >> ${VCF}.snpEffOut
        mv ${VCF}.snpEffOut ${VCF}.snpEffPass
        touch ${RUNDIR}/${NXT1}
    else
        echo "snpEff second part (snpSift) failed." >> ${VCF}.snpEffOut
        mv ${VCF}.snpEffOut ${VCF}.snpEffFail
        rm -f $snpEffOut
    fi
fi
rm -f $snpEffInt
rm -f ${VCF}.snpEffInQueue
endTime=`date +%s`
elapsed=$(( $endTime - $beginTime ))
(( hours=$elapsed/3600 ))
(( mins=$elapsed%3600/60 ))
echo "RUNTIME:SNPEFF:$hours:$mins" > ${VCF}.snpeff.totalTime
time=`date +%d-%m-%Y-%H-%M` 
echo "Ending snpEff Annotator."
