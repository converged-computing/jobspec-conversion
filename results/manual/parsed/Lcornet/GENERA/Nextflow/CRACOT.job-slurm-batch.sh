#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=12000
#SBATCH --time=5-01:00:00
#SBATCH --partition=bio

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run CRACOT.nf --genomes=genomes --lineage=Genomes.taxomonomy --list=positive-list.txt --cpu=20 --num=100 --taxolevel=<FIELD> --duplication=4 --replacement=0 --single=0 --hgtrate=none --hgtrandom=no --duplicationhgt=0 --replacementhgt=0 --singlehgt=0
