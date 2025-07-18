#!/bin/bash
#FLUX: --job-name=STAR_align_and_QC
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

module load star #Load STAR into path
module load picard #Load Picard into path
module load fastqc #Load FastQC into path
output_directory=$1 #get parent directory of where fastq files are located from argument
code_directory=$2
fastq_file=$3
get_human=$4
get_mouse=$5
if [ $get_human = true ]; then 
    source "$code_directory/hsapiens_workflow_config.sh"; else
        source "$code_directory/mmusculus_workflow_config.sh"
fi
line_number=$SLURM_ARRAY_TASK_ID #get index of which file to process from $SGE_TASK_ID provided by gridengine
fastq_path="$(sed "${line_number}q; d" "${fastq_file}")" #extract only the line number corresponding to $SGE_TASK_ID
fastq_path_R1="${fastq_path}_R1_001.fastq.gz"
fastq_path_R2="${fastq_path}_R2_001.fastq.gz"
fastq_name="$(basename "${fastq_path}")" #get only the file name from the path
fastqc_directory="${output_directory}/QC/FastQC" #provide path to FastQC output directory
mkdir -p "${fastqc_directory}" #make FastQC output directory if it doesn't exist
echo "Running FastQC on ${fastq_name}..."
if [ ! -f "${fastqc_directory}"/"${fastq_name}"_R1_001_fastqc.zip ] || [ ! -f "${fastqc_directory}"/"${fastq_name}"_R2_001_fastqc.zip ]; then
	fastqc --noextract --outdir "${fastqc_directory}" "${fastq_path_R1}" "${fastq_path_R2}" #Run FastQC on fastq file and output to FastQC directory
	echo "...FastQC complete for ${fastq_name}"
else
	echo "FastQC already performed for this sample lane"
fi
align_output_dir="${output_directory}/alignment_output" #Make individual directories for BAM and reads output - could change to output all together?
mkdir -p "$align_output_dir"
cd "$align_output_dir"
echo "STAR alignment beginning for ${fastq_name}..."
bamfile="${align_output_dir}/${fastq_name}_Aligned.sortedByCoord.out.bam"
if [ ! -f "${bamfile}" ]; then
    STAR --runMode alignReads `#Tell STAR you are aligning reads from a fastq raw reads file` \
        --outFileNamePrefix "${fastq_name}_" `#Specify prefix for files`\
        --runThreadN 8 `#Run STAR with 8 threads - you must reserve this many threads` \
        --genomeDir "${star_index}" `#provide path to pre-generated STAR genome index` \
        --readFilesIn "${fastq_path_R1}" "${fastq_path_R2}" `#provide path to fastq file to be aligned` \
        --readFilesCommand "zcat" `#provide decompression command` \
        --outSAMtype BAM SortedByCoordinate `#tell STAR to output aligned reads as BAM that has been sorted - skips using samtools to sort` \
        --quantMode TranscriptomeSAM GeneCounts `#tell STAR to generate counts like HTSeq does - saves step of running HTSeq` \
        --sjdbGTFfile "${annotation_gtf}" `#provide path to genome annotation GTF - needed for generating counts` \
        --twopassMode Basic `#use two pass model` \
        --outSAMstrandField intronMotif  `#add field for stranded output` \
        --outFilterIntronMotifs RemoveNoncanonical  `#remove potentially invalid splice junctions`
        #--outFilterScoreMinOverLread -1.5 \ #sets lower threshold for alignment score
        #--outFilterMatchNminOverLread -1.5 #sets lower threshold for number of aligned bases
        #--outTmpDir "/tmp/STAR_tmp_${fastq_name}" `#output STAR temp files to /tmp instead of current directory` \
    echo "...STAR alignment complete for ${fastq_name}"
else	
	echo "STAR alignment already complete for ${fastq_name}"
fi
cd "${output_directory}"
picard_directory="${output_directory}/QC/picard_qc" #provide a path to the output directory for Picard results
mkdir -p "${picard_directory}"
echo "Picard QC has begun for ${fastq_name}..."
alignment_stats_directory="${picard_directory}/alignment_stats" #create a path for subdirectory for alignment statistics
mkdir -p "${alignment_stats_directory}" #create the subdirectory for the above path
alignment_stats_file="${alignment_stats_directory}/${fastq_name}_alignment_stats.txt" #create a file name for the alignment statistics
if [ ! -f "${alignment_stats_file}" ]; then
    picard CollectAlignmentSummaryMetrics `#tell Picard to run the CollectAlignmentSummaryMetrics tool` \
        REFERENCE_SEQUENCE="${reference_genome}" `#provide the path to the reference genome used for alignment` \
        INPUT="${bamfile}" `#provide path to bam file aligned by STAR` \
        OUTPUT="${alignment_stats_file}" `#provide a path for Picard to write the alignment statistics to a file` \
        ASSUME_SORTED=true `#tell Picard the bam file aligned by STAR is already sorted by coordinats`\
        ADAPTER_SEQUENCE=null `#tell Picard to not use a set of default sequences for the adapter sequence`
    echo "...alignment_stats.txt is now created for ${fastq_name}..."
else
    echo "...BAM file already analyzed for alignment metrics for ${fastq_name}..."
fi
rnaseq_stats_directory="${picard_directory}/rnaseq_stats" #provide path to subdirectory for RNA-seq statistics
mkdir -p "${rnaseq_stats_directory}" #create the subdirectory for the above path
rnaseq_stats_file="${rnaseq_stats_directory}/${fastq_name}_rnaseq_stats.txt" #create a file name for the RNA-seq statistics
if [ ! -f "${rnaseq_stats_file}" ]; then
    picard CollectRnaSeqMetrics `#tell Picard to run the CollectAlignmentSummaryMetrics tool` \
        REFERENCE_SEQUENCE="${reference_genome}" `#provide the path to the reference genome used for alignment` \
        INPUT="${bamfile}" `#provide path to bam file aligned by STAR` \
        OUTPUT="${rnaseq_stats_file}" `#provide a path for Picard to write the RNA-seq statistics to a file` \
        STRAND_SPECIFICITY=NONE `#tell Picard that the aligned bam file is not strand specific - change this if your data is strand specific!`\
        REF_FLAT="${annotation_refFlat}" `#provide a path to a RefFlat annotation file` \
        ASSUME_SORTED=true `#tell Picard the bam file aligned by STAR is already sorted by coordinats`
    echo "...rnaseq_stats.txt is now created for ${fastq_name}"
else
    echo "...BAM file already analyzed for RNA seq metrics for ${fastq_name}"
fi
gcbias_stats_directory="${picard_directory}/gcbias_stats" #provide path to subdirectory for GC bias statistics
mkdir -p "${gcbias_stats_directory}" #create the subdirectory for the above path
gcbias_stats_prefix="${gcbias_stats_directory}/${fastq_name}" #create a prefix for the GC bias statistics
if [ ! -f "${gcbias_stats_prefix}"_gcbias_summary.txt ]; then
    picard CollectGcBiasMetrics `#tell Picard to run the CollectGcBiasMetrics tool` \
        REFERENCE_SEQUENCE="${reference_genome}" `#provide the path to the reference genome used for alignment` \
        INPUT="${bamfile}" `#provide path to bam file aligned by STAR` \
        OUTPUT="${gcbias_stats_prefix}_gcbias_stats.txt" `#provide a path for Picard to write the GC bias statistics to a file` \
        ASSUME_SORTED=true `#tell Picard the bam file aligned by STAR is already sorted by coordinats` \
        CHART_OUTPUT="${gcbias_stats_prefix}_gcbias_chart.pdf" `#provide a path for Picard to write a .pdf with a graph summarizing GC bias` \
        SUMMARY_OUTPUT="${gcbias_stats_prefix}_gcbias_summary.txt" `#provide a path for Picard to write the GC bias statistics to a file`
    echo "...gcbias_summary stats are now created for ${fastq_name}..."
else
    echo "...BAM file already analyzed for GC bias for ${fastq_name}..."
fi
echo "...Picard QC complete for ${fastq_name}"
