#!/bin/bash
#FLUX: --job-name=ViromeDiscovery
#FLUX: -c=8
#FLUX: -t=21540
#FLUX: --priority=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST} | cut -d "_" -f1)
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ${TMPDIR}/${SAMPLE_ID}/CT3
cd ${TMPDIR}/${SAMPLE_ID}/CT3 # since Mike has designed the logger checker this way & I do not want to rewrite his scripts
echo "$(pwd)"
module purge
module load Anaconda3
conda activate /scratch/p282752/tools/conda_envs/ct3_env
echo "> Running Cenote-Taker3"
cenotetaker3 \
	-c /scratch/p282752/ANALYSIS_CHILIADAL/SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.min1kbp.fasta \
	-r CenoteTaker3 \
	-p F \
	-t ${SLURM_CPUS_PER_TASK}
echo "> Moving results to /scratch"
rm -r ./CenoteTaker3/ct_processing # intermediate
rm -r ./CenoteTaker3/sequin_and_genome_maps # we will re-create it afterwards for selected contigs
mkdir -p /scratch/p282752/ANALYSIS_CHILIADAL/SAMPLES/${SAMPLE_ID}/virome_discovery/CenoteTaker3
cp ./CenoteTaker3/CenoteTaker3_cenotetaker.log /scratch/p282752/ANALYSIS_CHILIADAL/SAMPLES/${SAMPLE_ID}/virome_discovery/CenoteTaker3/
cp ./CenoteTaker3/CenoteTaker3_virus_summary.tsv /scratch/p282752/ANALYSIS_CHILIADAL/SAMPLES/${SAMPLE_ID}/virome_discovery/CenoteTaker3/
cp ./CenoteTaker3/final_genes_to_contigs_annotation_summary.tsv /scratch/p282752/ANALYSIS_CHILIADAL/SAMPLES/${SAMPLE_ID}/virome_discovery/CenoteTaker3/
conda list
conda deactivate
module list
module purge
