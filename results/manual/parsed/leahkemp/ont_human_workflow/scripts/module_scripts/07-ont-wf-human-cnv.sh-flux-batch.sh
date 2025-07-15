#!/bin/bash
#FLUX: --job-name=07-ont-wf-human-cnv
#FLUX: -c=48
#FLUX: --queue=prod
#FLUX: -t=86400
#FLUX: --priority=16

SAMPLE="OM1052A"
WKDIR="/NGS/humangenomics/active/2022/run/ont_human_workflow/"
REF="/NGS/clinicalgenomics/public_data/encode/GRCh38/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta"
rm -rf "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/
mkdir -p "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/work/
mkdir -p "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/fastq/
rsync -av "${WKDIR}"/results/01-ont-guppy-gpu/"${SAMPLE}"/pass/*.fastq "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/fastq/ 
conda init bash
source ~/.bashrc
mamba env create \
--force \
-f "${WKDIR}"/scripts/envs/conda.htslib.1.10.2.yml
conda activate htslib.1.10.2
for file in "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/fastq/*.fastq ; do 
  echo -e "... processing $file ...";
  bgzip "$file";
  echo -e "... done ...";
done
mamba env create \
--force \
-f "${WKDIR}"/scripts/envs/conda.nextflow.22.10.1.yml
conda activate nextflow.22.10.1
cd "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/
nextflow run -c "${WKDIR}"/config/07-ont-wf-human-cnv/nextflow.config epi2me-labs/wf-cnv \
-r v0.0.3 \
-w "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/work/ \
-profile singularity \
-with-report \
-with-timeline \
-with-trace \
-resume \
--fastq "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/fastq/  \
--sample_sheet "${WKDIR}"/config/07-ont-wf-human-cnv/wf_human_cnv_sample_sheet.csv \
--fasta "${REF}" \
--genome hg38 \
--bin_size 500 \
--threads 48 \
--map_threads 24
mv "${WKDIR}"/results/05-ont-methyl-calling/"${SAMPLE}"/mod-counts.cpg.acc.bed \
"${WKDIR}"/results/05-ont-methyl-calling/"${SAMPLE}"/"${SAMPLE}"_mod-counts.cpg.acc.bed
mv "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/output/fastq_wf-cnv-report.html \
"${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/output/"${SAMPLE}"_fastq_wf-cnv-report.html
cd "${WKDIR}"/results/07-ont-wf-human-cnv/"${SAMPLE}"/output/qdna_seq/
for file in * ; do mv "$file" "${SAMPLE}_$file" ; done
cd "${WKDIR}"
