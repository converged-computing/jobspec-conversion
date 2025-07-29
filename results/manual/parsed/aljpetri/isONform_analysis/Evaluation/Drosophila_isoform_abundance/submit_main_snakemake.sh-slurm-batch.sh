#!/bin/bash
#SBATCH --job-name=IsONformDrosophila
#SBATCH --account=snic2022-5-592
#SBATCH --mail-user=alexander.petri@math.su.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00

set -o errexit
module load gcc/9.3.0
module load bioinfo-tools
module load minimap2/2.24-r1122
snakemake --keep-going -j 999999 --cluster "sbatch -A {cluster.account} -C {cluster.C} -c {cluster.cpus-per-task} -N {cluster.Nodes}  -t {cluster.runtime} -J {cluster.jobname} --mail-type={cluster.mail_type} --mail-user={cluster.mail}" --cluster-config cluster.json --configfile cluster_config.json --latency-wait 100 --verbose 
