#!/bin/bash
#FLUX: --job-name=trust4_fastq
#FLUX: -c=64
#FLUX: --queue=general
#FLUX: -t=345600
#FLUX: --priority=16

dir_path="$2"
output_dir="$1"
reference_file="$3"
srun trust4_run_fastq.sh "$output_dir" "$dir_path" "$reference_file"
