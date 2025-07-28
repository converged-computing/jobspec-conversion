#!/bin/bash
#FLUX: --job-name=metagenotate_sbatch
#FLUX: --queue=cpu2023,cpu2022,cpu2021,cpu2019,synergy
#FLUX: -t=604800
#FLUX: --urgency=16

log_dir="$(pwd)"
log_file="logs/metagenotate-analysis.log.txt"
num_jobs=60
latency_wait=15
restart_times=10
echo "started at: `date`"
source ~/.bashrc
conda activate snakemake
snakemake --unlock
snakemake --cluster-config cluster.json --cluster 'sbatch --partition={cluster.partition} --cpus-per-task={cluster.cpus-per-task} --nodes={cluster.nodes} --ntasks={cluster.ntasks} --time={cluster.time} --mem={cluster.mem} --output={cluster.output} --error={cluster.error}' --latency-wait $latency_wait --restart-times $restart_times --rerun-incomplete --keep-going --jobs $num_jobs --use-conda &> $log_dir/$log_file
output_dir=$(grep "output_dir" < config.yaml | grep -v "#" | cut -d ' ' -f2 | sed 's/"//g')
list_files=$(grep "list_files" < config.yaml | grep -v "#" | cut -d ' ' -f2 | sed 's/"//g')
snakemake_file_dir="${output_dir}/snakemake_files"
mkdir -p $snakemake_file_dir
cp $list_files $snakemake_file_dir
cp Snakefile $snakemake_file_dir
cp config.yaml $snakemake_file_dir
cp cluster.json $snakemake_file_dir
cp metagenotate_sbatch.sh $snakemake_file_dir 
cp -rf logs $snakemake_file_dir
cp -rf utils $snakemake_file_dir
echo "finished with exit code $? at: `date`"
