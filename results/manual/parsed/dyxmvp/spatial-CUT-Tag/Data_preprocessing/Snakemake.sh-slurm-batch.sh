#!/bin/bash
#SBATCH --job-name=Snakemake
#SBATCH --output=Snakemake.%j.out
#SBATCH --error=Snakemake.%j.err
#SBATCH --mail-user=your
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=64g
#SBATCH --time=5-00:00:00

SLURM_ARGS="-p {cluster.partition} -J {cluster.job-name} -n {cluster.ntasks} -c {cluster.cpus-per-task} \
--mem={cluster.mem} -t {cluster.time} --mail-type={cluster.mail-type} --mail-user={cluster.mail-user} \
-o {cluster.output} -e {cluster.error}"
snakemake -j 20 --cluster-config cluster.json --cluster "sbatch $SLURM_ARGS"
