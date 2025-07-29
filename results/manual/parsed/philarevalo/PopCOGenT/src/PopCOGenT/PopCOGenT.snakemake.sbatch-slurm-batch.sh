#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

source activate PopCOGenT
source /home/parevalo/apps/mugsy_trunk/mugsyenv.sh
snakemake --cluster-config cluster.yml --cluster "sbatch -p {cluster.partition} -N {cluster.nodes} -n {cluster.cores} --mem={cluster.mem}" --jobname {rulename}.{jobid} --jobs 250
