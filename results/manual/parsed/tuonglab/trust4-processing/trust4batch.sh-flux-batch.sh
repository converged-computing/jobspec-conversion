#!/bin/bash
#FLUX: --job-name=trust4
#FLUX: -c=150
#FLUX: --queue=general
#FLUX: -t=1209600
#FLUX: --urgency=16

output_dir="$1"
bam_files_dir="$2"
reference_file="$3"
srun trust4run.sh "$output_dir" "$bam_files_dir" "$reference_file"
