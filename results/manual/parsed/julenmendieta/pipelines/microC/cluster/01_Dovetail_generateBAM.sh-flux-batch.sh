#!/bin/bash
#FLUX: --job-name=microC
#FLUX: -c=16
#FLUX: -t=72000
#FLUX: --urgency=16

export PATH='/home/jmendietaes/programas/miniconda3/bin:$PATH'

PROJECT_DIR=$1
RAW_FASTQ_DIR=$PROJECT_DIR"/demux_fastq"
EDITED_DIR=$PROJECT_DIR"/pipelineOut"
FASTQ_DIR=$EDITED_DIR"/fastq" 
basePath=$2
bamsPath="${basePath}/bamfiles"
REFERENCE_DIR=$3
GenomeIndex=$REFERENCE_DIR
preseq=/home/jmendietaes/programas/preseq_v2.0/preseq-3.1.2/installation/bin/preseq
microCScripts="/home/jmendietaes/programas/pipelines/microC/cluster"
removeTemp="no"
export PATH="/home/jmendietaes/programas/miniconda3/bin:$PATH"
module load BWA/0.7.17-foss-2018b
module load SAMtools/1.12-GCC-10.2.0
module load CMake/3.21.1-GCCcore-11.2.0
module load HTSlib/1.11-GCC-10.2.0
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT
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
            if [[ $1 -ot ${tfile} ]] ; then
                analyse="yes"
                echo $1" older than "${tfile}
            fi
        done
    fi
}
read1_path="${RAW_FASTQ_DIR}/${filename}_R1_001.fastq.gz"
read2_path="${RAW_FASTQ_DIR}/${filename}_R2_001.fastq.gz"
tempdir="${EDITED_DIR}/tmp"
statsOut="${basePath}/QC/pairtools_${filename}"
outpair="${basePath}/pairtools/${filename}_outpairs.gz"
samFile="${EDITED_DIR}/BAM/${filename}.sam"
if [ ! -e ${EDITED_DIR} ]; then
    mkdir -p ${EDITED_DIR}
    mkdir -p ${basePath}/QC
    mkdir -p ${basePath}/pairtools
    mkdir -p ${tempdir}
    mkdir -p ${EDITED_DIR}/BAM
fi
cd $EDITED_DIR
outbam="${EDITED_DIR}/BAM/${filename}.PT.bam"
fileNotExistOrOlder "${outbam}" \
                    "${read1_path} ${read2_path}"
if [[ ${analyse} == "yes" ]]; then
    echo -e "Starting Alignment and duplicate removal ------------------------------\n"
    bwa mem -5SP -T0 -t${SLURM_CPUS_PER_TASK} ${REFERENCE_DIR}.fa ${read1_path} ${read2_path}| \
    \
    pairtools parse --min-mapq 40 --walks-policy 5unique \
    --max-inter-align-gap 30 --nproc-in ${SLURM_CPUS_PER_TASK} \
    --nproc-out ${SLURM_CPUS_PER_TASK} --chroms-path ${REFERENCE_DIR}.fa | \
    \
    pairtools sort --tmpdir=${tempdir} --nproc ${SLURM_CPUS_PER_TASK} | \
    \
    pairtools dedup --nproc-in ${SLURM_CPUS_PER_TASK} \
    --nproc-out ${SLURM_CPUS_PER_TASK} --mark-dups --output-stats "${statsOut}.txt" | \
    \
    pairtools split --nproc-in ${SLURM_CPUS_PER_TASK} \
    --nproc-out ${SLURM_CPUS_PER_TASK} --output-pairs ${outpair} --output-sam - | \
    \
    samtools view -bS -@${SLURM_CPUS_PER_TASK} | \
    samtools sort -@${SLURM_CPUS_PER_TASK} -o ${outbam} ;samtools index ${outbam}
    ## slow version
    # # Alignment
    # bwa mem -5SP -T0 -t${SLURM_CPUS_PER_TASK} ${REFERENCE_DIR}.fa \
    #                 ${read1_path} ${read2_path} -o ${samFile}
    # # Recording valid ligation events
    # parsedSam="${EDITED_DIR}/BAM/${filename}.parsed.sam"
    # pairtools parse --min-mapq 40 --walks-policy 5unique \
    #         --max-inter-align-gap 30 --nproc-in ${SLURM_CPUS_PER_TASK} \
    #         --nproc-out ${SLURM_CPUS_PER_TASK} \
    #         --chroms-path ${REFERENCE_DIR}.fa ${samFile} > ${parsedSam}
    # # sorting pairsam file
    # sortedSam="${EDITED_DIR}/BAM/${filename}.parsed.sorted.sam"
    # pairtools sort --nproc ${SLURM_CPUS_PER_TASK} --tmpdir=${tempdir} ${parsedSam} > ${sortedSam}
    # # Remove PCR duplicates
    # dedupSAM="${EDITED_DIR}/BAM/${filename}.parsed.sorted.dedup.sam"
    # pairtools dedup --nproc-in ${SLURM_CPUS_PER_TASK} \
    #             --nproc-out ${SLURM_CPUS_PER_TASK} --mark-dups \
    #             --output-stats "${statsOut}.txt" --output ${dedupSAM} \
    #              ${sortedSam}
    # # Generate pairs and bam files
    # unsortSAM="${EDITED_DIR}/BAM/${filename}.parsed.sorted.dedup.unsort.sam"
    # pairtools split --nproc-in ${SLURM_CPUS_PER_TASK} \
    #         --nproc-out ${SLURM_CPUS_PER_TASK} --output-pairs ${outpair} \
    #          --output-sam ${unsortSAM} ${dedupSAM}
    # samtools sort -@${SLURM_CPUS_PER_TASK} -T ${tempdir}/tempfile.bam -o ${outbam} ${unsortSAM}
    # samtools index ${outbam}
    # Get mapping stats
    # value thressholds for valid
    #Metric	                        Shallow Seq (20M)	Deep Seq (100-200M)
    #No-Dup Read Pairs	            >75%	            >50%
    #No-dup cis read pairs ≥ 1kb	>20%	            >20%
    python3 ${microCScripts}/00_NR_get_qc.py -p "${statsOut}.txt" > "${statsOut}_processed.txt"
    mv ${statsOut}_processed.txt ${statsOut}.txt
else
    echo -e "Alignment and duplicate removal - already done before--------------------------\n"
fi
echo -e "Starting remove chrM and useless chromosomes ------------------------------\n"
outbam2="${bamsPath}/${filename}.PT.rmchr.bam"
fileNotExistOrOlder "${outbam2}" \
                    "${outbam}"
if [[ ${analyse} == "yes" ]]; then
	samtools view -h ${outbam} | \
    awk '(!index($3, "random")) && (!index($3, "chrUn")) && ($3 != "chrM") && ($3 != "chrEBV")' | \
    samtools view -Sb - > ${outbam2}
    samtools index ${outbam2} -@ $SLURM_CPUS_PER_TASK
    echo -e "Remove chrM and useless chromosomes - done ----------------------------------\n"
    if [[ $removeTemp == 'yes' ]] ; then
        rm ${outbam}
    fi
else
    echo -e "Remove chrM and useless chromosomes - already done before--------------------------\n"
fi
if [ ! -e ${basePath}/BigWig/ ]; then
	mkdir ${basePath}/BigWig/
fi
bigWigOut="${basePath}/BigWig/${filename}.PT.rmchr.bw"
fileNotExistOrOlder "${bigWigOut}" \
                    "${outbam2}"
if [[ ${analyse} == "yes" ]]; then
	bamCoverage --binSize 5 --normalizeUsing CPM --exactScaling \
    -b ${outbam2} -of bigwig \
    -o ${bigWigOut} --numberOfProcessors $SLURM_CPUS_PER_TASK
    echo -e "BigWig norm 1 - done ---------------------------------------------\n"
else
    echo -e "BigWig norm 1 - already done before ------------------------------\n"
fi
outPreseq="${basePath}/QC/preseq/${filename}.preseq"
fileNotExistOrOlder "${outPreseq}" \
                    "${outbam2}"
if [[ ${analyse} == "yes" ]]; then
	$preseq lc_extrap -bam -pe -extrap 2.1e9 -step 1e8 \
        -seg_len 1000000000 -output ${outPreseq} ${outbam2}
    echo -e "Preseq QC - done ---------------------------------------------\n"
else
    echo -e "Preseq QC - already done before ------------------------------\n"
fi
echo -e "END --------------------------------------------------"
seff $SLURM_JOBID
exit 0
