#!/bin/bash
#FLUX: --job-name=PostDiscovery
#FLUX: -c=8
#FLUX: -t=21540
#FLUX: --urgency=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST} | cut -d "_" -f1)
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/CheckV_pruning
mkdir -p ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning
module purge
module load CheckV/1.0.1-foss-2021b-DIAMOND-2.1.8
module list
checkv end_to_end \
    ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_viral.fasta \
    ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning \
    -t ${SLURM_CPUS_PER_TASK} \
    -d /scratch/hb-llnext/databases/checkv-db-v1.5
sed -i 's/\ /_/g' ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning/proviruses.fna 
sed -i 's/\//_/g' ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning/proviruses.fna 
cat ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning/*viruses.fna > ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_pruned_viral.fasta
mv ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning/contamination.tsv ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/CheckV_pruning/
rm -r ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning
mkdir ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning
checkv end_to_end \
    ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_pruned_viral.fasta \
    ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning \
    -t ${SLURM_CPUS_PER_TASK} \
    -d /scratch/hb-llnext/databases/checkv-db-v1.5
mv ${TMPDIR}/${SAMPLE_ID}/CheckV_pruning/quality_summary.tsv ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/CheckV_pruning/
module load R
Rscript New_contigs_ID_and_metadata.R /scratch/p282752/ANALYSIS_CHILIADAL/SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/ ${SAMPLE_ID}
cp ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_pruned_viral.fasta ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_pruned_viral_renamed.fasta
awk 'NR>1' ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/Extended_TOF  | awk '{print $15"\t"$17}' | while IFS=$'\t' read -r old_id new_id; do
        sed "s/>$old_id\b/>$new_id/" -i ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_pruned_viral_renamed.fasta
done
module purge
