#!/bin/bash
#SBATCH --job-name=fr1_snakemake
#SBATCH --account=peter
#SBATCH --output=fr1_snakemake_%j.out
#SBATCH --mail-user=d.ence@mail.ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=4-00:00:00
#SBATCH --partition=hpg1-compute
#SBATCH --qos=peter

unset TMPDIR
module load python3 
mkdir results
snakemake --configfile config/config.yaml --snakefile ./workflow/Snakefile -c 50 --jobs 50 --directory . --cluster-config ../hipergator.cluster.json --cluster "sbatch --qos={cluster.qos} -p {cluster.partition} -c {cluster.c} -n {cluster.N} --mail-type=FAIL --mail-user=d.ence@ufl.edu -t {cluster.time} --mem={cluster.mem} -J "fr1_align" -o fr1_align_%j.out -D /home/d.ence/projects/pinus_taeda_L/Fr1_project/test_pipelines/snakemake_pipelines/pipelines_for_hipergator/fr1_project_snakefiles"
