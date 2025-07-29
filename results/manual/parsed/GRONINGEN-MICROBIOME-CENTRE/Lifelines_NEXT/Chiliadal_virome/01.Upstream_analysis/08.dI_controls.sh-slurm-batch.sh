#!/bin/bash
#FLUX: --job-name=PostDiscovery
#FLUX: -c=2
#FLUX: -t=93540
#FLUX: --urgency=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST} | cut -d "_" -f1)
echo "SAMPLE_ID=${SAMPLE_ID}"
grep '>' ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_extended_contigs.fasta | \
	sed 's/>//g' > ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/contigs_for_dereplication
module purge
module load bioawk
module list
bioawk -c fastx '{ print $name, length($seq) }' < \
	../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_extended_contigs.fasta > \
	../SAMPLES/${SAMPLE_ID}/01_sc_assembly/contigs_for_dereplication_length
module purge
module load R
Rscript New_controls_contigs_ID_and_metadata.R /scratch/p282752/ANALYSIS_CHILIADAL/SAMPLES/${SAMPLE_ID}/01_sc_assembly/
cp ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_extended_contigs.fasta ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_extended_renamed_contigs.fasta
awk 'NR>1' ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/Extended_TOF  | awk '{print $15"\t"$17}' | while IFS=$'\t' read -r old_id new_id; do
        sed "s/>$old_id\b/>$new_id/" -i ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_extended_renamed_contigs.fasta
done
rm ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/contigs_for_dereplication
rm ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/contigs_for_dereplication_length
module purge
