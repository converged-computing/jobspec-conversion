#!/bin/bash
#SBATCH --job-name=viral_hunt
#SBATCH --account=bhurwitz
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60gb
#SBATCH --time=3-00:00:00
#SBATCH --partition=standard

source activate viral_env
cd /xdisk/bhurwitz/mig2020/rsgrps/bhurwitz/alise/my_scripts/v2_Viral_hunt_snakemake
echo "snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} -mem={cluster.m}"  --cluster-config config/cluster.yaml -j 10 --latency-wait 15"
snakemake --cluster "sbatch -A {cluster.group} -p {cluster.partition} -n {cluster.n} -t {cluster.time} --mem={cluster.m}"  --cluster-config config/cluster.yaml -j 30 --latency-wait 15
