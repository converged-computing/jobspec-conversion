#!/bin/bash
#SBATCH --account=indikar99
#SBATCH --mail-user=cstansbu@umich.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=1-12:00:00
#SBATCH --constraint=ntasks-per-node=1

CONFIG='config/cluster'
CORES=36
conda env export > environment.yml
cp Snakefile workflow.smk
snakemake --profile ${CONFIG} --use-conda --cores ${CORES} --rerun-incomplete --latency-wait 90 --verbose -s workflow.smk 
