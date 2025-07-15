#!/bin/bash
#FLUX: --job-name=picrust_analysis
#FLUX: --queue=batch,guest
#FLUX: -t=43200
#FLUX: --priority=16

cd /common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/picrust
module load picrust2/2.4
picrust2_pipeline.py -s /common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/exports/rep-seqs/dna-sequences.fasta -i /common/claytonlab/maibennett/gorilla_cortisol/AnimalName-IndClusters/Cenzoo/qiime2/exports/table/feature-table-w-taxa.biom -o results
