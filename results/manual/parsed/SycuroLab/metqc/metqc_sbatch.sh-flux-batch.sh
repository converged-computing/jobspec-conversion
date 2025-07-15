#!/bin/bash
#FLUX: --job-name=hello-salad-4861
#FLUX: --queue=synergy
#FLUX: -t=604800
#FLUX: --urgency=16

log_dir="$(pwd)"
log_file="logs/metqc-analysis.log.txt"
num_jobs=60
latency_wait=15
restart_times=10
max_inventory_time=20
echo "started at: `date`"
source ~/.bashrc
conda activate snakemake
snakemake --cluster-config cluster.json --cluster 'sbatch --partition={cluster.partition} --cpus-per-task={cluster.cpus-per-task} --nodes={cluster.nodes} --ntasks={cluster.ntasks} --time={cluster.time} --mem={cluster.mem} --output={cluster.output} --error={cluster.error}' --jobs $num_jobs --latency-wait $latency_wait --restart-times $restart_times --rerun-incomplete --max-inventory-time $max_inventory_time --use-conda &> $log_dir/$log_file
output_dir=$(grep "output_dir" < config.yaml | grep -v "#" | cut -d ' ' -f2 | sed 's/"//g')
list_files=$(grep "list_files" < config.yaml | grep -v "#" | cut -d ' ' -f2 | sed 's/"//g')
snakemake_file_dir="${output_dir}/snakemake_files"
mkdir -p $snakemake_file_dir
cp $list_files $snakemake_file_dir
cp Snakefile $snakemake_file_dir
cp config.yaml $snakemake_file_dir
cp cluster.json $snakemake_file_dir
cp metqc_sbatch.sh $snakemake_file_dir 
cp metqc_run* $snakemake_file_dir
cp -rf logs $snakemake_file_dir
cp -rf utils $snakemake_file_dir
python utils/scripts/parse_snakemake_command_logs.py --log_infile $log_dir/$log_file --output_dir $output_dir
echo "finished with exit code $? at: `date`"
