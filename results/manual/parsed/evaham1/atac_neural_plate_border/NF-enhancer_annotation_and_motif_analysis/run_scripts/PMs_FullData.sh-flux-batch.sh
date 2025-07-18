#!/bin/bash
#FLUX: --job-name=NF-enhancer_annotation_and_motif_analysis
#FLUX: -t=151200
#FLUX: --urgency=16

export TERM='xterm'
export NXF_VER='22.10.3'
export NXF_SINGULARITY_CACHEDIR='/nemo/lab/briscoej/home/users/hamrude/singularity'
export NXF_HOME='/flask/scratch/briscoej/hamrude/atac_neural_plate_border/NF-enhancer_annotation_and_motif_analysis'
export NXF_WORK='work/'

export TERM=xterm
export NXF_VER=21.10.6
export NXF_SINGULARITY_CACHEDIR=/nemo/lab/briscoej/home/users/hamrude/singularity
export NXF_HOME=/flask/scratch/briscoej/hamrude/atac_neural_plate_border/NF-enhancer_annotation_and_motif_analysis
export NXF_WORK=work/
ml purge
ml Java/11.0.2
ml Nextflow/22.10.3
ml Singularity/3.6.4
export NXF_VER=22.10.3
nextflow pull Streit-lab/enhancer_annotation_and_motif_analysis
nextflow run Streit-lab/enhancer_annotation_and_motif_analysis \
    -r main \
    -profile singularity \
    --fasta /nemo/lab/briscoej/home/users/hamrude/raw_data/genomes/galgal6/Gallus_gallus.GRCg6a.dna.toplevel.fa \
    --gtf /nemo/lab/briscoej/home/users/hamrude/raw_data/genomes/galgal6/tag_chroms.gtf \
    --peaks_bed /flask/scratch/briscoej/hamrude/atac_neural_plate_border/output/NF-downstream_analysis/Downstream_processing/Cluster_peaks/2_peak_clustering/PMs/FullData/unbiasedPMs_without_chr.bed \
    --outdir ../output/PMs_FullData_annotation
