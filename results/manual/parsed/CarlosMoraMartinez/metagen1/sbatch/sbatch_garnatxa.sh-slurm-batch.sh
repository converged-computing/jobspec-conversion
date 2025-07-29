#!/bin/bash
#SBATCH --job-name=test_nf
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --qos=long

module load anaconda #3_2022.10
nextflow run all.nf -c config/run_samples_garnatxa.config -profile conda -resume -with-timeline timeline.html -with-report report.html -with-dag pipeline_dag.html
