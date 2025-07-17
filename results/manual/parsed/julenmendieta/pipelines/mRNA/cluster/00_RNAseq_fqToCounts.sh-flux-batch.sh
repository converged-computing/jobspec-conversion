#!/bin/bash
#FLUX: --job-name=mRNA_fqToQ
#FLUX: -c=12
#FLUX: --queue=short
#FLUX: -t=36000
#FLUX: --urgency=16

PROJECT_DIR=$1
RAW_FASTQ_DIR=$PROJECT_DIR"/demux_fastq"
EDITED_DIR=$PROJECT_DIR"/pipelineOut"
FASTQ_DIR=$EDITED_DIR"/fastq" 
libMetricsP="${EDITED_DIR}/libMetrics"
removeTemp="yes"
basePath=$2
REFERENCE_DIR=$3
GenomeIndex=$REFERENCE_DIR
chr_genome_size=$REFERENCE_DIR".sizes"
transcriptFasta=$4
salmonIndexP=$(dirname ${transcriptFasta})/Salmon
indexOutP=$(dirname ${GenomeIndex})
useGTF=$(realpath ${indexOutP}/genes/*gtf)
nfScripts="/home/jmendietaes/programas/pipelines/mRNA/cluster/sub-scripts"
rRNAp="/home/jmendietaes/programas/sortmerna/sortmerna-4.3.6-Linux/database"
module load SAMtools/1.12-GCC-10.2.0
module load GCCcore/11.2.0
module load Java/1.8.0_192
STAR=/home/jmendietaes/programas/STAR/source/STAR
wigToBigWig="/home/jmendietaes/programas/binPath/wigToBigWig"
picardPath='/home/jmendietaes/programas/picard/picard.jar'
Salmon=/home/jmendietaes/programas/Salmon/salmon-latest_linux_x86_64/bin/salmon
preseq="/home/jmendietaes/programas/Preseq/preseq_v2.0/preseq"
R="/home/jmendietaes/programas/miniconda3/envs/Renv/bin/Rscript"
sortmerna=/home/jmendietaes/programas/sortmerna/sortmerna-4.3.6-Linux/bin/sortmerna
sortmernaIndex=/home/jmendietaes/programas/sortmerna/sortmerna-4.3.6-Linux/database/idx
nCPU=$SLURM_CPUS_PER_TASK
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT
if [ ! -e ${EDITED_DIR} ]; then
    mkdir -p ${EDITED_DIR}
fi
cd $EDITED_DIR
FILES=($(cat $RAW_FASTQ_DIR/samplesNames.txt))
filename=${FILES[$SLURM_ARRAY_TASK_ID - 1]}
echo -e $SLURM_JOB_NODELIST 
echo "print =========================================="
echo "print SLURM_JOB_ID = $SLURM_JOB_ID"
echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
echo "print =========================================="
echo $filename
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
read1_path="${RAW_FASTQ_DIR}/${filename}_R1_001.fastq.gz"
read2_path="${RAW_FASTQ_DIR}/${filename}_R2_001.fastq.gz"
stepControl="${EDITED_DIR}/QC/pipelineStep_${filename}.txt"
summaryFile="${basePath}/QC/allStepsSummary/summary_${filename}.txt"
readLen=$(zcat ${read1_path} | head -n 2 | tail -n 1) 
readLen=$(echo -n ${readLen} | wc -c)
if [ ! -e ${bamsPath} ]; then
    mkdir -p ${bamsPath}
fi
if [ ! -e ${basePath}/spliceJunctions/ ] ; then
    mkdir -p ${basePath}/spliceJunctions
fi
if [ ! -e ${basePath}/logs/ ] ; then
    mkdir -p ${basePath}/logs/STAR
    mkdir -p ${basePath}/logs/trim_galore
    mkdir -p ${basePath}/logs/sortmerna
    mkdir -p ${basePath}/logs/salmon
fi
if [ ! -e ${basePath}/stats/ ] ; then
    mkdir -p ${basePath}/stats/
    mkdir -p ${basePath}/counts/salmon
fi
if [ ! -e ${basePath}/QC/ ] ; then
    #mkdir -p ${basePath}/QC/preseq
    mkdir -p ${basePath}/QC/allStepsSummary
fi
bamsPath="${basePath}/bamfiles"
if [ ! -e ${bamsPath} ] ; then
    mkdir -p ${bamsPath}/wholeGenome
    mkdir -p ${bamsPath}/transcriptome
fi
if [ ! -e ${basePath}/BigWig/ ] ; then
	mkdir -p ${basePath}/BigWig/wholeGenome
fi
if [ ! -e ${EDITED_DIR}/QC/ ] ; then
    mkdir -p ${EDITED_DIR}/QC/
fi
if [ ! -e ${stepControl} ] ; then
    touch ${stepControl}
fi
echo -e "Starting Summary file --------------------------------------------- \n"
linec=`sed "1q;d" ${stepControl}`
if [[ ${linec} != "Summary" ]]; then 
    echo -e "STARTING \n $(date) \n" 
    echo "SAMPLE: ${filename}" 
    # QC: read counts if file is gziped or not
    if file --mime-type ${read1_path} | grep -q gzip$; then
        Counts1="$(zcat ${read1_path} | echo $((`wc -l`/4)))"
        Counts2="$(zcat ${read2_path} | echo $((`wc -l`/4)))" 
    else
        echo "Not gzipped files"
        echo $read1_path
        #Counts1="$(cat ${RAW_FASTQ_DIR}/${filename}_R1_001.fastq | echo $((`wc -l`/4)))"
        #Counts2="$(cat ${RAW_FASTQ_DIR}/${filename}_R2_001.fastq| echo $((`wc -l`/4)))"
    fi
    echo -e "READ COUNTS\n" >> ${summaryFile}
    echo -e "sample name\tfastq name\tread count\tmillions" >> ${summaryFile}
    rc=$((Counts1/1000000))
    echo -e "${filename} \t ${filename}_R1 \t ${Counts1} \t ${rc}" >> ${summaryFile}
    rc=$((Counts2/1000000))
    echo -e "${filename} \t ${filename}_R2 \t ${Counts2} \t ${rc} \n" >> ${summaryFile}
    echo -e "Summary file - done ------------------------------------------- \n"
    # store stage control info
    echo "Summary" > ${stepControl}
else
    echo -e "Summary file - already done before ---------------------------- \n"
fi
adjustedMem=$(echo "print(int(round($SLURM_MEM_PER_NODE*0.96,0)/1000))" | python3)
if [ "$adjustedMem" -lt "5" ]; then
    adjustedMem=$(echo "print(int(round($SLURM_MEM_PER_NODE*0.96,0)))" | python3)
fi  
adjustedMem_bytes=$((1024*1024*1024*${adjustedMem}))
adjustedMem_Gb=$((${adjustedMem}-1))
echo "Memory as returned by Job:"
echo ${SLURM_MEM_PER_NODE}
echo  "Memory in Gb:"
echo ${adjustedMem}
echo  "Memory in bytes:"
echo ${adjustedMem_bytes}
gtfName=$(basename ${useGTF} | sed 's/\./_/g')
starIndexP="${indexOutP}/index/${gtfName}/${readLen}_bp"
if [ ! -e ${starIndexP}/SA ]; then
    echo -e "STAR index for ${readLen}_bp reads ----- not present\n"
    echo -e "Creating it"
    mkdir -p ${starIndexP}
    cd ${starIndexP}
    ${STAR} --runThreadN ${nCPU} \
        --runMode genomeGenerate \
        --genomeDir ${starIndexP}/ \
        --genomeFastaFiles ${GenomeIndex}.fa \
        --sjdbGTFfile ${useGTF} \
        --sjdbOverhang $((${readLen} - 1)) \
        --limitGenomeGenerateRAM ${adjustedMem_bytes}
else
    echo -e "STAR index for ${readLen}_bp reads ----- already present\n"
fi
echo -e "Starting Trimming and FASTQC ---------------------------------------\n"
linec=`sed "2q;d" ${stepControl}`
if [[ ${linec} != "Trim" ]]; then 
    # Trim_galore recommends less than 8 cpu
    trimCPU=$([ $nCPU -le 7 ] && echo "$nCPU" \
            || echo "7")
    if [ ! -e ${EDITED_DIR}/fastQC/ ]; then
        mkdir -p ${EDITED_DIR}/trimming/  
        mkdir -p ${EDITED_DIR}/fastQC/
    fi
    if [ ! -e ${EDITED_DIR}/fastQC/${filename}_R2_001.fastq_fastqc.html ]; then
        trim_galore -q 20 --length 20 --cores $trimCPU --paired --fastqc --gzip \
        --output_dir ${EDITED_DIR}/trimming/ --fastqc_args "--outdir ${EDITED_DIR}/fastQC/" \
        ${read1_path} ${read2_path}
    fi
    # Write trimming stats
    echo -e "READ TRIMMING" >> ${summaryFile}
    report1="${EDITED_DIR}/trimming/${filename}_R1_001.fastq.gz_trimming_report.txt"
    report2="${EDITED_DIR}/trimming/${filename}_R2_001.fastq.gz_trimming_report.txt"
    echo -e "Read 1" >> ${summaryFile}
    grep "Reads with adapters" ${report1} >> ${summaryFile}
    grep "Reads written (passing filters)" ${report1} >> ${summaryFile}
    echo -e "\nRead 2" >> ${summaryFile}
    grep "Reads with adapters" ${report2} >> ${summaryFile}
    grep "Reads written (passing filters)" ${report2} >> ${summaryFile}
    # Move TrimmGalore logs to be stored
    mv ${EDITED_DIR}/trimming/${filename}*trimming_report.txt ${basePath}/logs/trim_galore/
    echo -e "Trimming - done ----------------------------------------------- \n"
    # store stage control info
    echo "Trim" >> ${stepControl}
else
    echo -e "Trimming - already done before -------------------------------- \n"
fi
trimedRead1="${EDITED_DIR}/trimming/${filename}_R1_001_val_1.fq.gz"
trimedRead2="${EDITED_DIR}/trimming/${filename}_R2_001_val_2.fq.gz"
Salmon_tmp=$PROJECT_DIR"/pipelineOut/Salmon"
mkdir -p ${Salmon_tmp}/strandness/${filename}
cd ${Salmon_tmp}/strandness/${filename}
echo -e "Starting Strandness with Salmon ----------------------------------- \n"
fileNotExistOrOlder "${Salmon_tmp}/strandness/${filename}/logs/salmon_quant.log" \
                    "${trimedRead1} ${trimedRead2}"
if [[ ${analyse} == "yes" ]]; then
    ${Salmon} quant --geneMap ${useGTF} --threads ${nCPU} \
            --skipQuant --libType=A \
            -1 <(gunzip -c ${trimedRead1} | head -n 4000000) \
            -2 <(gunzip -c ${trimedRead2}| head -n 4000000) \
            -i ${salmonIndexP} \
            -o ${Salmon_tmp}/strandness/${filename}
fi
libType=$(grep "library type" ${Salmon_tmp}/strandness/${filename}/logs/salmon_quant.log)
libType=(${libType// / }) ; libType=${libType[-1]}
echo -e "Library type: ${libType}"
if grep -q "Library type" ${summaryFile}; then
    echo ""
else
    echo -e "\nLIBRARY TYPE" >> ${summaryFile}   
    echo -e "${libType}" >> ${summaryFile}
fi
echo -e "Strandness - done ------------------------------------------------- \n"
mkdir -p ${EDITED_DIR}/sortmerna/${filename}
cd ${EDITED_DIR}/sortmerna/${filename}
riboFltRead1="${EDITED_DIR}/sortmerna/${filename}_R1_001_riboFlt.fq.gz"
riboFltRead2="${EDITED_DIR}/sortmerna/${filename}_R2_001_riboFlt.fq.gz"
echo -e "Starting rRNA removal --------------------------------------------- \n"
linec=`sed "3q;d" ${stepControl}`
if [[ ${linec} != "rRNA" ]]; then 
    # Get parameter to input rRNA reference genomes
    riboFa=$(for f in $(find ${rRNAp}/*fasta); do echo "--ref ${f} "; done)
    ${sortmerna} ${riboFa} \
                --reads ${trimedRead1} \
                --reads ${trimedRead2} \
                --threads ${nCPU} \
                --workdir ${EDITED_DIR}/sortmerna/${filename}/ \
                --aligned rRNA_reads \
                --fastx \
                --other non_rRNA_reads \
                --paired_in \
                --idx-dir ${sortmernaIndex} \
                --out2 
    # Store aligned proportions
    echo -e "\nREADS ALIGNING rRNA" >> ${summaryFile} 
    sed -n '/Coverage by database/,$p' rRNA_reads.log | head -n -3 >> ${summaryFile} 
    # Rename and move files
    mv non_rRNA_reads_fwd.f*q.gz ${riboFltRead1}
    mv non_rRNA_reads_rev.f*q.gz ${riboFltRead2}
    mv rRNA_reads.log ${filename}.sortmerna.log
    mv rRNA_reads_fwd.f*q.gz ${filename}_R1_001_rRNA.fq.gz
    mv rRNA_reads_rev.f*q.gz ${filename}_R2_001_rRNA.fq.gz
    # Store logs
    mv ${filename}.sortmerna.log ${basePath}/logs/sortmerna
    # remove temporal trimmed fastq files
    if [[ $removeTemp == 'yes' ]] ; then
        rm ${trimedRead1}
        rm ${trimedRead2}
    fi
    echo "rRNA" >> ${stepControl}
    echo -e "rRNA removal - done ------------------------------------------- \n"
else
    echo -e "rRNA removal - already done before ---------------------------- \n"
fi
echo -e "Starting STAR Alignment ------------------------------------------- \n"
if [ ! -e ${EDITED_DIR}/BAM/${filename} ]; then
    mkdir -p ${EDITED_DIR}/STAR/BAM/${filename}
    #mkdir -p ${EDITED_DIR}/STAR/unMapped/
fi
cd ${EDITED_DIR}/STAR/BAM/${filename}
bamFile_pref="${EDITED_DIR}/STAR/BAM/${filename}/${filename}"
linec=`sed "4q;d" ${stepControl}`
if [[ ${linec} != "Align" ]]; then 
   ${STAR} --genomeDir ${starIndexP} \
        --readFilesIn ${riboFltRead1} ${riboFltRead2}  --readFilesCommand zcat \
        --runThreadN ${nCPU} \
        --outFileNamePrefix "${bamFile_pref}." --outSAMtype BAM Unsorted \
        --twopassMode Basic \
        --outFilterType BySJout \
        --sjdbOverhang $((${readLen} - 1)) \
        --outSAMattributes NH HI AS nM NM MD XS \
        --outSAMstrandField intronMotif \
        --quantMode GeneCounts TranscriptomeSAM \
        --outSAMattrRGline ID:$filename SM:${filename} LB:None PL:Illumina 
    # Log to store
    #${bamFile_pref}.Log.final.out
    mv ${bamFile_pref}.Log.final.out ${basePath}/logs/STAR
    # File with Splice junction coordinates
    #${bamFile_pref}.SJ.out.tab
    mv ${bamFile_pref}.SJ.out.tab ${basePath}/spliceJunctions/
    # File with gene counts
    #${bamFile_pref}.ReadsPerGene.out.tab
    # Store alignment stats
    echo -e "\nSTAR WHOLE GENOME ALIGNMENT" >> ${summaryFile}
    grep "Uniquely mapped reads" ${bamFile_pref}.Log.final.out | \
        sed 's/ *Uniq/Uniq/g'>> ${summaryFile}
    # Count reads at lon-noncoding with featureCounts
    echo -e "STAR Alignment - done ----------------------------------------- \n"
    # store stage control info
    echo "Align" >> ${stepControl}
    # remove temporal trimmed fastq files
    if [[ $removeTemp == 'yes' ]] ; then
        rm ${riboFltRead1}
        rm ${riboFltRead2}
    fi
else
    echo -e "STAR Alignment - already done before -------------------------- \n"
fi
transcriptBam="${bamFile_pref}.Aligned.toTranscriptome.out.bam"
echo -e "Starting BAM sorting --------------------------------------\n"
bamSort="${EDITED_DIR}/STAR/BAM/${filename}/${filename}.STAR.sort.bam"
linec=`sed "5q;d" ${stepControl}`
if [[ ${linec} != "BamSort" ]]; then 
    samtools sort -@ ${nCPU} \
                    -o ${bamSort} ${bamFile_pref}.Aligned.out.bam
    samtools index -b ${bamSort}
    samtools flagstat ${bamSort} > ${basePath}/stats/${filename}.flagstats
    samtools idxstats ${bamSort} > ${basePath}/stats/${filename}.idxstats
    echo -e "\nSAMTOOLS FLAGSTAT - unmarkedDuplicates" >> ${summaryFile}
    cat ${basePath}/stats/${filename}.flagstats >> ${summaryFile}
    echo -e "BAM sorting - done --------------------------------------\n"
    # store stage control info
    echo "BamSort" >> ${stepControl}
    # delete intermediate files
    if [[ $removeTemp == 'yes' ]] ; then
        rm ${bamFile_pref}.Aligned.out.bam
    fi
else
    echo -e "BAM sorting - already done before -----------------------------\n"
fi
Salmon_tmp=$PROJECT_DIR"/pipelineOut/Salmon"
mkdir -p ${Salmon_tmp}/${filename}/quant
cd ${Salmon_tmp}/${filename}/quant
echo -e "Starting Quantification with Salmon ------------------------------- \n"
linec=`sed "6q;d" ${stepControl}`
if [[ ${linec} != "SalmonQ" ]]; then 
    mkdir -p ${basePath}/counts/salmon/${filename}
    ${Salmon} quant --geneMap ${useGTF} --threads ${nCPU} \
            --libType=${libType} \
            -t ${transcriptFasta} \
            -a ${transcriptBam} \
            -o ${Salmon_tmp}/${filename}/quant \
            --gcBias \
            --gencode
    # Move important files
    cp ${Salmon_tmp}/${filename}/quant/logs/salmon_quant.log \
        ${basePath}/logs/salmon/${filename}_salmon_quant.log
    mv ${Salmon_tmp}/${filename}/quant/quant*sf \
        ${basePath}/counts/salmon/${filename}/
    #cp $prefix/aux_info/meta_info.json "${prefix}_meta_info.json"
    # Store transcript bam at final destination (might be slipped in the future)
    # samtools sort -@ ${nCPU} \
    #                 -o ${bamsPath}/transcriptome/${filename}.STAR-transcriptome.sort.bam \
    #                 ${transcriptBam}
    mv ${transcriptBam} ${bamsPath}/transcriptome/${filename}.STAR-transcriptome.bam
    echo -e "Salmon quantification - done -----------------------------------\n"
    # store stage control info
    echo "SalmonQ" >> ${stepControl}
else
    echo -e "Salmon quantification - already done before --------------------\n"
fi
echo -e "Starting duplicate marking ---------------------------------------- \n"
if [ ! -e ${libMetricsP} ]; then
    mkdir -p ${libMetricsP}
fi
bamSortMarkDup="${EDITED_DIR}/STAR/BAM/${filename}/${filename}.STAR.sort.markdup.bam"
cd ${EDITED_DIR}/STAR/BAM/${filename}
linec=`sed "7q;d" ${stepControl}`
if [[ ${linec} != "mrkDup" ]]; then 
    # Identify duplicated reads by flaging them in a new ioutput BAM file
    java -Xmx${adjustedMem_Gb}G -jar ${picardPath} MarkDuplicates I=${bamSort} \
            O=${bamSortMarkDup} \
            METRICS_FILE=${libMetricsP}/${filename}.bam.mkdup.txt
    samtools index -b ${bamSortMarkDup}
    echo -e "\nSAMTOOLS FLAGSTAT - markedDuplicates" >> ${summaryFile}
    samtools flagstat ${bamSortMarkDup} >> ${summaryFile}
    if [[ $removeTemp == 'yes' ]] ; then
        rm ${bamSort}
    fi
    echo -e "Duplicates marked - done -------------------------------------- \n"
    # store stage control info
    echo "mrkDup" >> ${stepControl}
else
    echo -e "Duplicates marking - already done before ---------------------- \n"
fi 
echo -e "DATE CHECK \n $(date) \n" 
echo -e "Starting remove chrM and useless chromosomes -----------------------\n"
bamSortMarkDupChr="${bamsPath}/wholeGenome/${filename}.STAR.sort.markdup.rmchr.bam"
linec=`sed "8q;d" ${stepControl}`
if [[ ${linec} != "Remove" ]]; then 
	samtools view -h ${bamSortMarkDup} | \
    awk '(!index($3, "random")) && (!index($3, "chrUn")) && ($3 != "chrM") && ($3 != "chrEBV")' | \
    samtools view -Sb - > ${bamSortMarkDupChr}
    samtools index ${bamSortMarkDupChr} -@ $nCPU
    # QC: Show final reads
    echo -e "\nSAMTOOLS FLAGSTAT - FINAL READS" >> ${summaryFile}
    samtools flagstat ${bamSortMarkDupChr} >> ${summaryFile}
    echo -e "Remove chrM and useless chromosomes - done ---------------------\n"
    # store stage control info
    echo "Remove" >> ${stepControl}
    if [[ $removeTemp == 'yes' ]] ; then
        rm ${bamSortMarkDup}
    fi
else
    echo -e "Remove chrM and useless chromosomes - already done before-------\n"
fi
echo -e "Starting BigWigs --------------------------------------------------\n"
bigWigOut="${basePath}/BigWig/${filename}.STAR.sort.markdup.rmchr.norm.bw"
linec=`sed "9q;d" ${stepControl}`
if [[ ${linec} != "BigWnorm1" ]]; then 
	bamCoverage --binSize 5 --normalizeUsing CPM --exactScaling \
    -b ${bamSortMarkDupChr} -of bigwig \
    -o ${bigWigOut} --numberOfProcessors $nCPU
    echo -e "BigWig norm 1 - done -------------------------------------------\n"
    # store stage control info
    echo "BigWnorm1" >> ${stepControl}
else
    echo -e "BigWig norm 1 - already done before ----------------------------\n"
fi
echo -e "END ------------------------------------------------------------------"
seff $SLURM_JOBID
exit 0
