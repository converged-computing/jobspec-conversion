#!/bin/bash
#FLUX: --job-name=pegasus_RC
#FLUX: -t=172800
#FLUX: --urgency=16

time=`date +%d-%m-%Y-%H-%M` 
beginTime=`date +%s`
machine=`hostname`
echo "### NODE: $machine"
echo "### REF: ${REF}"
echo "### GATK: ${GATKPATH}"
echo "### KNOWN: ${KNOWN}"
echo "gatk base recalibration started on $machine"
java -Xmx48g -jar ${GATKPATH}/GenomeAnalysisTK.jar \
    -T BaseRecalibrator \
    -nct 4 \
    -l INFO \
    -R ${REF} \
    -knownSites ${KNOWN} \
    -I ${BAMFILE} \
    -cov ReadGroupCovariate \
    -cov QualityScoreCovariate \
    -cov CycleCovariate \
    -cov ContextCovariate \
    --disable_indel_quals \
    -o ${BAMFILE}.recal_data.grp > ${BAMFILE}.recalibrateOut
if [ $? -ne 0 ] ; then
    mv ${BAMFILE}.recalibrateOut ${BAMFILE}.recalibrateFail
    echo "recal failed at base recalibrator"
    rm -f ${BAMFILE}.recalibrateInQueue
    exit 1
fi
echo "gatk base recalibration print reads stage started"
java -Xmx48g -jar ${GATKPATH}/GenomeAnalysisTK.jar \
    -l INFO \
    -nct 4 \
    -R ${REF} \
    -I ${BAMFILE} \
    -T PrintReads \
    --out ${RECALBAM} \
    --disable_indel_quals \
    -BQSR ${BAMFILE}.recal_data.grp >> ${BAMFILE}.recalibrateOut
if [ $? -eq 0 ] ; then
    mv ${BAMFILE}.recalibrateOut ${BAMFILE}.recalibratePass
    echo "Automatically removed by recalibration step to save on space" > ${BAMFILE}
    touch ${RUNDIR}/${NXT1}
else
    mv ${BAMFILE}.recalibrateOut ${BAMFILE}.recalibrateFail
fi
rm -f ${BAMFILE}.recalibrateInQueue
endTime=`date +%s`
elapsed=$(( $endTime - $beginTime ))
(( hours=$elapsed/3600 ))
(( mins=$elapsed%3600/60 ))
echo "RUNTIME:RECAL:$hours:$mins" > ${BAMFILE}.rc.totalTime
time=`date +%d-%m-%Y-%H-%M` 
echo "gatk recalibration ended"
