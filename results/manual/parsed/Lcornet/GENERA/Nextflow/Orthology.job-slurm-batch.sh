#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=2625
#SBATCH --time=5-01:00:00
#SBATCH --partition=bio

export OMP_NUM_THREADS='20'
export MKL_NUM_THREADS='20'

export OMP_NUM_THREADS=20
export MKL_NUM_THREADS=20
module --ignore-cache load Nextflow/21.08.0
nextflow run Orthology.nf --infiles=infiles --mode=inference --core=yes --corelist=corelist --specific=yes --specificlist=specificlist --anvio=no --type=nucleotide --cpu=20 
