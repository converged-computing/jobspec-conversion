#!/bin/bash
#FLUX: --job-name=pegasus_mutect
#FLUX: -t=172800
#FLUX: --urgency=16

beginTime=`date +%s`
machine=`hostname`
echo "### NODE: $machine"
echo "### REF: ${REF}"
echo "### RUNDIR: ${RUNDIR}"
echo "### CHRLIST: ${CHRLIST}"
echo "### GATKPATH: ${GATKPATH}"
echo "### OUTPUT: ${OUTPUT}"
echo "### STEP: ${STEP}"
echo "### STEPCOUNT: ${STEPCOUNT}"
echo "### COSMIC_VCF: ${COSMIC_VCF}"
echo "### SNPS: ${SNPS}"
echo "### NXT1: ${NXT1}"
echo "### WD: ${WD}"
echo "### TUMOR: ${TUMOR}"
echo "### NORMAL: ${NORMAL}"
echo "### MUTECTPATH: ${MUTECTPATH}"
echo "/home/tgenref/binaries/java/jdk1.6.0_45/bin/java -Djava.io.tmpdir=$TMPDIR -Xmx12G -jar ${MUTECTPATH}/muTect-1.1.4.jar \
    -nt 1 \
    -nct 1 \
    --analysis_type MuTect \
    --reference_sequence ${REF} \
    --intervals ${CHRLIST}/Step${STEP}.list \
    --cosmic ${COSMIC_VCF} \
    --dbsnp ${SNPS} \
    --input_file:normal ${NORMAL} \
    --input_file:tumor ${TUMOR} \
    --fraction_contamination 0.02 \
    --minimum_mutation_cell_fraction 0.0 \
    --minimum_normal_allele_fraction 0.0 \
    --min_qscore 5 \
    --gap_events_threshold 3 \
    --heavily_clipped_read_fraction 0.3 \
    --required_maximum_alt_allele_mapping_quality_score 20 \
    --max_alt_alleles_in_normal_count 2 \
    --max_alt_alleles_in_normal_qscore_sum 20 \
    --max_alt_allele_in_normal_fraction 0.03 \
    --out ${OUTPUT}_Step${STEP}_MuTectStats.out \
    --coverage_file ${OUTPUT}_Step${STEP}_MuTect_Cov.wig \
    --tumor_depth_file ${OUTPUT}_Step${STEP}_MuTect_TumorDepth.wig \
    --normal_depth_file ${OUTPUT}_Step${STEP}_MuTect_NormalDepth.wig \
    --vcf ${OUTPUT}_Step${STEP}_MuTect.vcf"
/home/tgenref/binaries/java/jdk1.6.0_45/bin/java -Djava.io.tmpdir=$TMPDIR -Xmx12G -jar ${MUTECTPATH}/muTect-1.1.4.jar \
    -nt 1 \
    -nct 1 \
    --analysis_type MuTect \
    --reference_sequence ${REF} \
    --intervals ${CHRLIST}/Step${STEP}.list \
    --cosmic ${COSMIC_VCF} \
    --dbsnp ${SNPS} \
    --input_file:normal ${NORMAL} \
    --input_file:tumor ${TUMOR} \
    --fraction_contamination 0.02 \
    --minimum_mutation_cell_fraction 0.0 \
    --minimum_normal_allele_fraction 0.0 \
    --min_qscore 5 \
    --gap_events_threshold 3 \
    --heavily_clipped_read_fraction 0.3 \
    --required_maximum_alt_allele_mapping_quality_score 20 \
    --max_alt_alleles_in_normal_count 2 \
    --max_alt_alleles_in_normal_qscore_sum 20 \
    --max_alt_allele_in_normal_fraction 0.03 \
    --out ${OUTPUT}_Step${STEP}_MuTectStats.out \
    --coverage_file ${OUTPUT}_Step${STEP}_MuTect_Cov.wig \
    --tumor_depth_file ${OUTPUT}_Step${STEP}_MuTect_TumorDepth.wig \
    --normal_depth_file ${OUTPUT}_Step${STEP}_MuTect_NormalDepth.wig \
    --vcf ${OUTPUT}_Step${STEP}_MuTect.vcf
if [ $? -eq 0 ] ; then
    echo MuTect_${STEP}.Done
    echo "${SLURM_JOB_ID}" > ${OUTPUT}_Step${STEP}.mutectPass
    PROGRESS=$(ls ${OUTPUT}*mutectPass | wc -l)
else
    echo "${SLURM_JOB_ID}" > ${OUTPUT}_Step${STEP}.mutectFail
    rm -f ${OUTPUT}_Step${STEP}.mutectInQueue
    exit 1
fi
for i in `seq 1 ${STEPCOUNT}`;
do
    thisVcf="-V ${OUTPUT}_Step${i}_MuTect.vcf "
    vcfList="$vcfList $thisVcf"
done
if [ ${PROGRESS} -eq ${STEPCOUNT} ]
then
    echo MuTect_${STEP}.Done
    #Concatenate VCF with GATK
    java -cp ${GATKPATH}/GenomeAnalysisTK.jar org.broadinstitute.gatk.tools.CatVariants \
        -R ${REF} \
        $vcfList \
        -out ${OUTPUT}_MuTect_All.vcf \
        -assumeSorted
    if [ $? -eq 0 ] ; then
        touch ${OUTPUT}.mutectPass
        touch ${RUNDIR}/${NXT1}
        touch ${RUNDIR}/${NXT2}
    else
        touch ${OUTPUT}.mutectFail
    fi
fi
rm -f ${OUTPUT}_Step${STEP}.mutectInQueue
endTime=`date +%s`
elapsed=$(( $endTime - $beginTime ))
(( hours=$elapsed/3600 ))
(( mins=$elapsed%3600/60 ))
echo "RUNTIME:MUTECT:$hours:$mins" > ${OUTPUT}_Step${STEP}.mutect.totalTime
