#!/bin/bash
#FLUX: --job-name=mRNA_countA
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

basePath=$1
REFERENCE_DIR=$2
indexOutP=$(dirname ${REFERENCE_DIR})
geneGTF=$(realpath ${indexOutP}/genes/*gtf)
projectName=$3
bamsPath="${basePath}/bamfiles/wholeGenome/valid/${projectName}"
outpath=${basePath}"/furtherAnalysis/${projectName}"
salmonQin=${basePath}/counts/salmon/${projectName}
subScripts="/home/jmendietaes/programas/pipelines/mRNA/cluster/sub-scripts"
R="/home/jmendietaes/programas/miniconda3/envs/Renv/bin/Rscript"
qualimap="/home/jmendietaes/programas/pipelines/qualimap/qualimap_v2.2.1/qualimap"
module load Java/1.8.0_192
numfmt=~/programas/miniconda3/bin/numfmt
nCPU=$SLURM_CPUS_PER_TASK
allbams=$(find ${bamsPath}/*bam -printf "${bamsPath}/%f\n" | \
        tr '\n' ' ')
allLabels=`for i in $allbams; do basename ${i} | cut -d '.' -f 1; done | \
        tr '\n' ' '`
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT
if [ ! -e ${outpath}/counts ]; then
    mkdir -p ${outpath}/counts
    mkdir -p ${outpath}/QC/biotypes
fi
if [ ! -e ${outpath}/QC/deseq2 ]; then
    mkdir -p ${outpath}/QC/deseq2
    mkdir -p ${outpath}/QC/biotypes
    mkdir -p ${outpath}/QC/qualimap
    mkdir -p ${outpath}/QC/dupradar
fi
fileNotExistOrOlder () {
    # check if the file exists of it was created with a previous bam version 
    analyse="no"
    if [ ! -e $1 ]; then
    analyse="yes"
    # only proceed if the output file is older than the bam file
    # in this way if we resequenced and kept the name the analysis 
    # will be repeated
    else
    for tfile in $2; do
        # If $1 is older than any $2
        if [[ $1 -ot ${tfile} ]] ; then
        analyse="yes"
        echo $1" older than "${tfile}
        fi
    done
    fi
}
adjustedMem=$(echo "print(int(round($SLURM_MEM_PER_NODE*0.96,0)/1000))" | python3)
if [ "$adjustedMem" -lt "5" ]; then
    adjustedMem=$(echo "print(int(round($SLURM_MEM_PER_NODE*0.96,0)))" | python3)
fi  
echo  "Memory in Gb:"
echo ${adjustedMem}
adjustedMem_bytes=$(printf ${adjustedMem} | ${numfmt} --from-unit=Mi)
adjustedMem_Gb=${adjustedMem}
echo  "Memory in bytes:"
echo ${adjustedMem_bytes}
salmonOut=${outpath}/counts
cd ${salmonOut}
fileNotExistOrOlder "${salmonOut}/tximportMerge.transcript_counts.rds" \
            "${salmonQin}/*/quant.sf"
if [[ ${analyse} == "yes" ]]; then
    echo "Aggregate transcript-level salmon abundance estimates"
    # --salmon should be a folder with files names as samples and 
    #       containing Salmons quantification output quant.sf
    python ${subScripts}/salmon_tx2gene.py \
        --gtf ${geneGTF} \
        --salmon ${salmonQin} \
        --id "gene_id" \
        --extra "gene_name" \
        -o ${salmonOut}/salmon_tx2gene.tsv
    # Following script requires tximeta, but not sure for what
    ${R} ${subScripts}/salmon_tximport.r \
        Infer \
        ${salmonQin} \
        ${salmonOut}/tximportMerge
    # Store R rds sessions with summarized experiment of:
    #   Gene counts
    #   Gene counts scaled by gene length
    #   Gene counts scaled
    #   Transcript counts
    for f2 in gene_counts.tsv gene_counts_length_scaled.tsv \
    gene_counts_scaled.tsv; do
        ${R} ${subScripts}/salmon_summarizedexperiment.r \
            Infer \
            ${salmonOut}/tximportMerge.${f2} \
            ${salmonOut}/tximportMerge.gene_tpm.tsv
    done
    ${R} ${subScripts}/salmon_summarizedexperiment.r \
        Infer \
        ${salmonOut}/tximportMerge.transcript_counts.tsv \
        ${salmonOut}/tximportMerge.transcript_tpm.tsv
fi
samples=$(head -n 1 ${salmonOut}/tximportMerge.gene_tpm.tsv | \
                tr '\t' '\n' | \
                grep -v gene_ | sed 's/\./-/g')
lTypes=$(for s in ${samples}; do 
    grep -A 1 "LIBRARY TYPE" ${basePath}/QC/allStepsSummary/summary_${s}*txt |\
    tail -n 1; done | sort | uniq)
nTypes=$(echo ${lTypes} | wc -w)
if [ "$nTypes" -gt 1 ] ; then
    echo "ERROR: More than one library type"
    echo $nTypes 
    exit 1
fi
fileNotExistOrOlder "${outpath}/QC/deseq2/deseq2.plots.pdf" \
            "${salmonOut}/tximportMerge.gene_counts_length_scaled.tsv"
if [[ ${analyse} == "yes" ]]; then
    ${R} ${subScripts}/deseq2_qc.r \
        --count_file ${salmonOut}/tximportMerge.gene_counts_length_scaled.tsv \
        --outdir ${outpath}/QC/deseq2/ \
        --cores ${nCPU} 
fi
header="# id: 'biotype_counts'\n\
lType_=0
if [[ ${lTypes} == *"SF" ]] ; then
    lType_=1
elif [[ ${lTypes} == *"SR" ]] ; then
    lType_=2
fi
for bam in ${allbams}; do
    sampleId=$(basename ${bam} | cut -d '.' -f 1)
    # Check if we have already have done the biotype QC with this BAM
    fileNotExistOrOlder "${outpath}/QC/biotypes/${sampleId}_biotype_counts_mqc.tsv" \
            "${bam}"
    if [[ ${analyse} == "yes" ]]; then
        featureCounts -p  \
            -T ${nCPU} \
            -g gene_type \
            -a ${geneGTF} \
            -s ${lType_} \
            -o ${outpath}/QC/biotypes/${sampleId}.featureCounts.txt \
            ${bam}
        echo -e $header > ${outpath}/QC/biotypes/${sampleId}_biotype_counts_mqc.tsv
        cut -f 1,7 ${outpath}/QC/biotypes/${sampleId}.featureCounts.txt | \
            tail -n +3 >> ${outpath}/QC/biotypes/${sampleId}_biotype_counts_mqc.tsv
        allBiotypes=$(grep -v "^#" \
            ${outpath}/QC/biotypes/${sampleId}_biotype_counts_mqc.tsv | \
            cut -f 1 | tr '\n' ' ')
        python ${subScripts}/mqc_features_stat.py \
            ${outpath}/QC/biotypes/${sampleId}_biotype_counts_mqc.tsv \
            -s ${sampleId} \
            -f ${allBiotypes} \
            -o ${outpath}/QC/biotypes/${sampleId}_biotype_counts_mqc.tsv
    fi
done
rm ${outpath}/QC/biotypes/*featureCounts*
python ${subScripts}/biotypePlot.py ${outpath}/QC/biotypes/
lType_="non-strand-specific"
if [[ ${lTypes} == *"SF" ]] ; then
    lType_="strand-specific-forward"
elif [[ ${lTypes} == *"SR" ]] ; then
    lType_="strand-specific-reverse"
fi
echo "Running Qualimap"
cd ${outpath}/QC/qualimap/
for bam in ${allbams}; do
    sampleId=$(basename ${bam} | cut -d '.' -f 1)
    # Check if we have already have run Qualimap with this BAM
    fileNotExistOrOlder "${outpath}/QC/qualimap/${sampleId}/qualimapReport.html" \
            "${bam}"
    if [[ ${analyse} == "yes" ]]; then
        echo ${sampleId}
        mkdir -p ${outpath}/QC/qualimap/${sampleId}
        ${qualimap} rnaseq --java-mem-size=${adjustedMem_Gb}G \
                -bam ${bam} \
                -gtf ${geneGTF} \
                -p ${lType_} \
                --paired \
                -outdir ${outpath}/QC/qualimap/${sampleId}
    fi
done
lType_=0
if [[ ${lTypes} == *"SF" ]] ; then
    lType_=1
elif [[ ${lTypes} == *"SR" ]] ; then
    lType_=2
fi
for bam in ${allbams}; do
    ${R} ${subScripts}/dupradar.r ${bam} \
        ${outpath}/QC/dupradar \
        ${geneGTF} \
        ${lType_} \
        paired \
        ${nCPU}
done
