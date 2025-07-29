#!/bin/bash
#SBATCH --job-name=gat
#SBATCH --output=gat.%A.out
#SBATCH --error=gat.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=18000
#SBATCH --time=7-00:00:00
#SBATCH --partition=general

source activate python2_pgrayson
gat-run.py --ignore-segment-tracks --segments=${1} --annotations=${2} --workspace=workspace_galGal4.bed --num-samples=100000 --output-counts-pattern=count${1}_%s.txt --log=gat${1}.log > ${1}_gat.out
