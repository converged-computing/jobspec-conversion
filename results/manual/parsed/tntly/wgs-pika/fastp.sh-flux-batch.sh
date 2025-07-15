#!/bin/bash
#FLUX: --job-name=fastp
#FLUX: -c=16
#FLUX: --priority=16

cd /home/tly/wgs-pika/samples/
output_dir="/home/tly/wgs-pika/results/fastp/"
module purge
module load intel-python3
for f1 in *_L004_R1_001.fastq.gz
do
  # Construct the names of the second paired-end files
  # 27552_S1_L004_R2_001.fastq.gz
  f2=$(echo $f1 | sed 's/_R1_/_R2_/')
  # Extract the sample names
  # 27552_S1
  name=$(echo $f1 | sed 's/_L004_R1_001.fastq.gz//')
  # Define the file paths for the output files
  # /home/tly/wgs-pika/results/fastp/
  output_f1="${output_dir}trimmed_${f1}"
  output_f2="${output_dir}trimmed_${f2}"
  # Define the file paths for the HTML and JSON files
  # /home/tly/wgs-pika/results/fastp/
  html="${output_dir}reports/${name}.html"
  json="${output_dir}reports/${name}.json"
  # Run fastp
  fastp \
  -i $f1 -I $f2 \
  -o $output_f1 -O $output_f2 \
  -j $json -h $html \
  -w $SLURM_CPUS_PER_TASK
done
