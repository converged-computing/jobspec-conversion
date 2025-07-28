#!/bin/bash
#FLUX: --job-name=isoseq_test_snakemake
#FLUX: --queue=hpg1-compute
#FLUX: -t=86400
#FLUX: --urgency=16

unset TMPDIR
module load python3
snakemake --configfile config.yaml --snakefile Snakefile -c 100 --jobs 50 --directory . --cluster-config hipergator.cluster.json --cluster "sbatch --qos={cluster.qos} -p {cluster.partition} -c {cluster.c} -n {cluster.N} --mail-type=FAIL --mail-user=d.ence@ufl.edu -t {cluster.time} --mem={cluster.mem} -J "isoseq_test" -o isoseq_test_%j.out -D /home/d.ence/d.ence_peter_share/pinus_taeda_L/MeJA_time_course_experiment/rnastar_deseq2_isoseq_trial_Jan_2021"
