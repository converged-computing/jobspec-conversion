#!/bin/bash
#FLUX: --job-name=flu
#FLUX: -t=86400
#FLUX: --urgency=16

input_dir='/oak/stanford/groups/horence/NOMAD/nomad_runs/tabula_sapiens/TSP_SS2_tissue/'$1'/'$2'/sample_sheet.csv'
output_dir='/oak/stanford/groups/horence/NOMAD/nomad_results/tabula_sapiens/TSP_SS2_tissue/'$1'/'$2'/results/'
ml python/3.6.1
ml py-numpy
ml py-pandas
ml biology
ml py-biopython/1.79_py39
run_title=$1'_'$2
run_title2="$run_title1""2"
mkdir "$run_title"
cp submit_parse.py "$run_title"
cp parallel_generate.py "$run_title"
cp make_intermediates.py "$run_title"
cp aspen.py "$run_title"
cd "$run_title"
awk '!array[$1]++' "$output_dir"summary.tsv > summary_filtered.tsv
python3 submit_parse.py "$input_dir" "$output_dir" "test" "$run_title"
sleep 1m
parallel_jobs="parallel_jobs.txt"
squeue -u hendrson --Format=name:80 | grep "$run_title" > "${parallel_jobs}"
while [ -s "$parallel_jobs" ]
do
    sleep 1m
    squeue -u hendrson --Format=name:80 | grep "$run_title" > "${parallel_jobs}"
done 
python3 parallel_generate.py "$output_dir" "test" "$run_title2"
