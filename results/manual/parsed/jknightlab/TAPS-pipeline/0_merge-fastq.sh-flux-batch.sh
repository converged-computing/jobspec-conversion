#!/bin/bash
#FLUX: --job-name=fastq-merge
#FLUX: --queue=short
#FLUX: --urgency=16

input_dir=$PWD
output_dir=$PWD
while getopts i:o:s:h opt
do
	case $opt in
	i)
		input_dir=$OPTARG
		;;
	o)
		output_dir=$OPTARG
		;;
	s)
		sample_list_path=$OPTARG
		;;
	h)
		echo "Usage:	merge-fastq.sh [-i input_dir] [-o output_dir] [-s sample_list_path]"
		echo ""
		echo "Where:"
		echo "-i		Path to input directory containing FASTQ files [defaults to the working directory]"
		echo "-o		Path to output directory where to write merged FASTQ files [defaults to the working directory]"
		echo "-s		Path to a text file containing a list of samples (one sample per line). Sample names should match file naming patterns."
		echo ""
		exit 1
		;;
	esac
done
echo "------------------------------------------------" 
echo "Run on host: "`hostname` 
echo "Operating system: "`uname -s` 
echo "Username: "`whoami` 
echo "Started at: "`date` 
echo "------------------------------------------------" 
echo "[merge-fastq]:	Validating arguments..."
if [[ ! -d $input_dir ]]
then
        echo "[merge-fastq]:	ERROR: Input directory not found."
        exit 2
fi 
if [[ ! -d $output_dir ]]
then
        echo "[merge-fastq]:	ERROR: Output directory not found."
        exit 2
fi 
if [[ ! -f $sample_list_path ]]
then
        echo "[merge-fastq]:	ERROR: Sample list file not found"
        exit 2
fi
echo "[merge-fastq]:	Reading sample list..."
readarray sampleList < $sample_list_path
sampleName=$(echo ${sampleList[$((${SLURM_ARRAY_TASK_ID}-1))]} | sed 's/\n//g')
echo "[merge-fastq]:	Processing files for sample ${sampleName}..."
file_regex_1="$sampleName*_1.fq.gz"
file_regex_2="$sampleName*_2.fq.gz"
echo "[merge-fastq]:   Merging FASTQ files for read 1..."
zcat ${input_dir}/$file_regex_1 | gzip > ${output_dir}/${sampleName}_1.fastq.gz
echo "[merge-fastq]:   Merging FASTQ files for read 2..."
zcat ${input_dir}/$file_regex_2 | gzip > ${output_dir}/${sampleName}_2.fastq.gz
echo "[merge-fastq]:   ...done!"
