#!/bin/bash
#SBATCH --job-name=picrust_analysis
#SBATCH --output=/common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/script_output/stdpi.out
#SBATCH --error=/common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/script_output/errpi.out
#SBATCH --mail-user=maiabennett@unomaha.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64000
#SBATCH --time=12:00:00
#SBATCH --partition=batch,guest
#SBATCH --constraint=ntasks-per-node=16

cd /common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/picrust
module load picrust2/2.4
picrust2_pipeline.py -s /common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/exports/rep-seqs/dna-sequences.fasta -i /common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/exports/table/feature-table-w-taxa.biom -o results
