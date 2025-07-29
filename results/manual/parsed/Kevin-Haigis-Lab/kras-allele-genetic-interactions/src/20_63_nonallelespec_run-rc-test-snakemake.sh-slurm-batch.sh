#!/bin/bash
#SBATCH --output=logs/rc-nonallelespec/snakemake_%A.log
#SBATCH --error=logs/rc-nonallelespec/snakemake_%A.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=2-00:00:00

module unload python
module load gcc conda2 slurm-drmaa/1.1.1
conda activate rctest
snakemake \
  --snakefile src/20_62_nonallelespec_rc-test-Snakefile.py \
  --jobs 9980 \
  --restart-times 0 \
  --cluster-config config/rc-test-snakemake-cluster.json \
  --latency-wait 120 \
  --drmaa " -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J}"
conda deactivate
