#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=7500
#SBATCH --time=20-01:00:00
#SBATCH --partition=bio

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run Braker.nf --genome=<genome.fna> --prot=<BrakerDB> --SRA=none --brakermode=<mode> --cpu=20 --currentpath=<PWD>
