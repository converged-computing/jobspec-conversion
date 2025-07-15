#!/bin/bash
#FLUX: --job-name=fuzzy-banana-4479
#FLUX: -t=18000
#FLUX: --priority=16

module unload gcc/cray/8.1.0
module load gcc/8.1.0
module load r/3.3.2
input_dir="PATH TO THE FOLDER WITH ALL THE PIPELINE OUTPUT DATA"
output_dir="PATH TO THE DESIRED OUTPUT DIRECTORY"
code_dir="PATH TO CODE DIRECTORY"
R --no-save $input_dir $output_dir < $code_dir/data_analysis_nuclei.r
