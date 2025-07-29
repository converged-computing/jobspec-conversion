#!/bin/bash
#SBATCH --job-name=test_nf
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --time=8-00:00:00
#SBATCH --qos=long

module load anaconda #3_2022.10
nextflow run all.nf -c config/run_samples_garnatxa_corals.config -profile conda -resume -with-report report.html -with-dag pipeline_dag.html
