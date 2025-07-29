#!/bin/bash
#SBATCH --job-name=NF-enhancer_annotation_and_motif_analysis
#SBATCH --mail-user=hamrude@crick.ac.uk
#SBATCH --mail-type=ALL,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-18:00:00

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
    -profile test,singularity \
    --fasta /nemo/lab/briscoej/home/users/hamrude/raw_data/genomes/galgal6/Gallus_gallus.GRCg6a.dna.toplevel.fa \
    --gtf /nemo/lab/briscoej/home/users/hamrude/raw_data/genomes/galgal6/tag_chroms.gtf \
    --outdir output
