#!/bin/bash
#SBATCH --job-name=gene_fidelity_snakemaster
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load python
(snakemake -s Snakefile_vcf \
    --directory $PWD \
    --restart-times 2 \
    --rerun-incomplete \
    --jobname "s.{rulename}.{jobid}.sh" \
    --profile ~/snakemake_profile \
) > "Snakemake.log" 2>&1
SNAKE_PID=$!
finish(){
    echo 'Stopping snakemake job.'
    kill -SIGINT $SNAKE_PID
    exit 0
}
trap finish SIGTERM
wait $SNAKE_PID
