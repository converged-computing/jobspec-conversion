#!/bin/bash
#SBATCH --job-name=ng_manta
#SBATCH --output=logs/manta_slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=150Gb
#SBATCH --time=07:00:00

REF='/ibex/reference/KSL/hg38/Homo_sapiens_assembly38.fasta'
ID=$1
MANTA_ANALYSIS_PATH="~/$ID"
BAM="~/$ID.sorted.bam"
module load manta/1.6
configManta.py \
--bam $BAM \
--referenceFasta $REF \
--runDir $MANTA_ANALYSIS_PATH
python $MANTA_ANALYSIS_PATH/runWorkflow.py
