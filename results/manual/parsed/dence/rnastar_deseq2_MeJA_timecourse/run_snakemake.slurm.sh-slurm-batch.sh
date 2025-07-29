#!/bin/bash
#SBATCH --job-name=timecourse
#SBATCH --account=peter
#SBATCH --output=master_%j.out
#SBATCH --mail-user=mallory.morgan@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15gb
#SBATCH --time=8-00:00:00
#SBATCH --qos=peter

unset TMPDIR
module load python3
snakemake --rerun-incomplete --configfile config.yaml --snakefile Snakefile -c 20 --jobs 10 --directory . --cluster-config hipergator.cluster.json --cluster "sbatch --qos={cluster.qos} -c {cluster.c} -n {cluster.N} --mail-type=FAIL --mail-user=mallory.morgan@ufl.edu -t {cluster.time} --mem={cluster.mem} -J "timecourse" -o timecourse_%j.out -D /blue/peter/mallory.morgan/rnastar_deseq2_MeJA_timecourse"
