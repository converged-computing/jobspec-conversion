#!/bin/bash
#SBATCH --job-name=CS_nextflow_example
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=01:00:00

cd $SLURM_SUBMIT_DIR
module use --append /projects/omics_share/meta/modules
module load nextflow
nextflow main.nf \
-profile sumner \
--workflow rnaseq \
--gen_org mouse \
--sample_folder 'test/rna/mouse' \
--pubdir '/fastscratch/outputDir' \
-w '/fastscratch/outputDir/work'
