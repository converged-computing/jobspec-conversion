#!/bin/bash
#SBATCH --job-name=03-ont-wf-human-variation-calling
#SBATCH --output=./logs/slurm-%j-%x.out
#SBATCH --mail-user=leah.kemp@esr.cri.nz
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=130G
#SBATCH --time=1-00:00:00

SAMPLE="OM1052A"
WKDIR="/NGS/humangenomics/active/2022/run/ont_human_workflow/"
MODEL="dna_r9.4.1_450bps_hac"
REF="/NGS/clinicalgenomics/public_data/encode/GRCh38/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta"
TDREPETS="/NGS/clinicalgenomics/public_data/beds/human_GRCh38_no_alt_analysis_set.trf.bed"
rm -rf "${WKDIR}"/results/03-ont-wf-human-variation-calling/"${SAMPLE}"/
mkdir -p "${WKDIR}"/results/03-ont-wf-human-variation-calling/"${SAMPLE}"/work/
mkdir -p "${WKDIR}"/results/03-ont-wf-human-variation-calling/"${SAMPLE}"/
conda init bash
source ~/.bashrc
mamba env create \
--force \
-f "${WKDIR}"/scripts/envs/conda.nextflow.22.10.1.yml
conda activate nextflow.22.10.1
cd "${WKDIR}"/results/03-ont-wf-human-variation-calling/"${SAMPLE}"/
nextflow run -c "${WKDIR}"/config/03-ont-wf-human-variation-calling/nextflow.config epi2me-labs/wf-human-variation \
-r v1.0.0 \
-w "${WKDIR}"/results/03-ont-wf-human-variation-calling/"${SAMPLE}"/work/ \
-profile singularity \
-with-report \
-with-timeline \
-with-trace \
-resume \
--threads 24 \
--snp \
--sv \
--phase_vcf \
--use_longphase \
--basecaller_cfg "${MODEL}" \
--tr_bed "${TDREPETS}" \
--bam "${WKDIR}"/results/02-ont-bam-merge/"${SAMPLE}"/"${SAMPLE}"_merged_sorted.bam \
--ref "${REF}" \
--sample_name "${SAMPLE}" \
--out_dir "${WKDIR}"/results/03-ont-wf-human-variation-calling/"${SAMPLE}"/
cd "${WKDIR}"
