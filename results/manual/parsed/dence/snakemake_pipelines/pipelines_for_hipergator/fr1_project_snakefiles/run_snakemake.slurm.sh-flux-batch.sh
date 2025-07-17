#!/bin/bash
#FLUX: --job-name=fr1_snakemake
#FLUX: --queue=hpg1-compute
#FLUX: -t=345600
#FLUX: --urgency=16

unset TMPDIR
module load python3 
mkdir results
snakemake --configfile config/config.yaml --snakefile ./workflow/Snakefile -c 50 --jobs 50 --directory . --cluster-config ../hipergator.cluster.json --cluster "sbatch --qos={cluster.qos} -p {cluster.partition} -c {cluster.c} -n {cluster.N} --mail-type=FAIL --mail-user=d.ence@ufl.edu -t {cluster.time} --mem={cluster.mem} -J "fr1_align" -o fr1_align_%j.out -D /home/d.ence/projects/pinus_taeda_L/Fr1_project/test_pipelines/snakemake_pipelines/pipelines_for_hipergator/fr1_project_snakefiles"
