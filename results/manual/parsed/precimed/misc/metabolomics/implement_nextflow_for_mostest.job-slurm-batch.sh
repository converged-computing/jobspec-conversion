#!/bin/bash
#SBATCH --job-name=mostest_nf
#SBATCH --account=p33
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16GB
#SBATCH --time=12-04:20:00

export NXF_OFFLINE='TRUE'

module purge
source /cluster/projects/p33/users/mohammadzr/envs/nextf/bin/activate
module load java/jdk-11.0.1+13
export NXF_OFFLINE='TRUE'
nextflow run mostest_with_nextflow_v1.nf --pheno ../liver/pheno/liver_pheno_test1.csv --out test_out --cov ../liver/pheno/liver_cov_test1.csv --project 'liver_test' -resume -with-timeline mostest_nextflow_report
