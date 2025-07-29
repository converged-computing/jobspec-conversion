#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=2625
#SBATCH --time=5-01:00:00

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run Genome-downloader.nf --taxolevel=<FIELD1> --group=<FIELD2> --genbank=yes --dRep=no --ignoreGenomeQuality=no --cpu=20 
