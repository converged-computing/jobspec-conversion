#!/bin/bash
#FLUX: --job-name=red-peanut-butter-9464
#FLUX: --urgency=16

workflow_name="04-fit-butterfly"
module load R/4.2.0
module load gcc/10.2 pcre2/10.35 intel/2020.2 texlive/2018 pandoc
parent_dir=$(Rscript -e "cat(here::here())")
data_dir=${parent_dir}/data
output_dir=${parent_dir}/outputs
save_dir=${output_dir}/${workflow_name}
cd ${parent_dir}/code/${workflow_name}
mkdir -m 775 ${data_dir} || echo "Data directory already exists"
mkdir -m 775 ${output_dir} || echo "Output directory already exists"
mkdir -m 775 ${save_dir} || echo "Save directory already exists"
Rscript fit_params.R walk sr memory
