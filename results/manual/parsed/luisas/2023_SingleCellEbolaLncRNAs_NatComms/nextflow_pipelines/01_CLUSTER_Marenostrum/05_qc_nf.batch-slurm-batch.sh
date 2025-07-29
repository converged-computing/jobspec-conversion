#!/bin/bash
#SBATCH --job-name=NextflowQAPipeline
#SBATCH --output=out/Nextflow-%j.out
#SBATCH --error=err/Nextflow-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --qos=debug
#SBATCH --chdir=.

module load java/8u131
module load intel/2017.1
module load nextflow/19.03.0
module load singularity
nextflow run /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/06_SC_preprocess_object.nf \
                  --output_dir_name "01_scRNA-Seq_inVivo_rhemac10" \
                  -w /gpfs/projects/bsc83/Data/Ebola/work/ \
                  -c /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/configs/nextflow.sc_preprocess.config
