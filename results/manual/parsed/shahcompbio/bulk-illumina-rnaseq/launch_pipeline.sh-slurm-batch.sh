#!/bin/bash
#SBATCH --job-name=transcripts
#SBATCH --output=slurm%j_snkmk.out
#SBATCH --mail-user=preskaa@mskcc.org
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=2-00:00:00

source /home/preskaa/miniconda3/bin/activate nf-core
module load singularity/3.7.1
outdir=/data1/shahs3/users/preskaa/bulk_illumina-rnaseq_test
samplesheet=${outdir}/test_samplesheet.csv
wrkdir=${outdir}/work
nextflow run shahcompbio/bulk-illumina-rnaseq \
  -c ${PWD}/conf/iris.config \
  -profile singularity,iris \
  -work-dir ${wrkdir} \
  -params-file nf-params.json \
  --input ${samplesheet} \
  --outdir ${outdir}
