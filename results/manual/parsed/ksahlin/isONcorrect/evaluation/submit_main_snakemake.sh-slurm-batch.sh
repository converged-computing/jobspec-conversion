#!/bin/bash
#SBATCH --job-name=main_snake
#SBATCH --mail-user=ksahlin@kth.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=14-00:00:00

source activate py36
snakemake --keep-going -j 999999 --cluster "sbatch --exclude={cluster.exclude} --mem {cluster.mem} -c {cluster.cpus-per-task} -N {cluster.Nodes}  -t {cluster.runtime} -J {cluster.jobname} --mail-type={cluster.mail_type} --mail-user={cluster.mail}" --cluster-config cluster.json --configfile experiments.json --latency-wait 100 --verbose
