#!/bin/bash
#FLUX: --job-name=ViromeDiscovery
#FLUX: -c=8
#FLUX: -t=21540
#FLUX: --priority=16

export PATH='/scratch/hb-llnext/tools/mmseqs/bin/:$PATH'

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST})
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ${TMPDIR}/${SAMPLE_ID}/genomad_run/
echo "> copying files to tmpdir"
cp ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.min1kbp.fasta ${TMPDIR}/${SAMPLE_ID}/genomad_run/
export PATH=/scratch/hb-llnext/tools/mmseqs/bin/:$PATH
module load ARAGORN/1.2.41-foss-2021b
module load Python/3.9.5-GCCcore-10.3.0
source /scratch/hb-llnext/python_venvs/geNomad/bin/activate
echo "> Running geNomad"
genomad \
	end-to-end \
	--enable-score-calibration \
	--cleanup \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/${SAMPLE_ID}_contigs.min1kbp.fasta \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad \
	/scratch/hb-llnext/databases/genomad_db
genomad --version
deactivate
module list
module purge
echo "> Moving the files to scratch"
mkdir -p ../SAMPLES/${SAMPLE_ID}/virome_discovery/geNomad/
cat ${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_annotate.log \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_aggregated_classification.log \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_find_proviruses.log \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_marker_classification.log \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_nn_classification.log \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_score_calibration.log \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_summary.log > \
	${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp.log 
cp ${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp.log ../SAMPLES/${SAMPLE_ID}/virome_discovery/geNomad/
cp ${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_summary/${SAMPLE_ID}_contigs.min1kbp_plasmid_summary.tsv ../SAMPLES/${SAMPLE_ID}/virome_discovery/geNomad/
cp ${TMPDIR}/${SAMPLE_ID}/genomad_run/geNomad/${SAMPLE_ID}_contigs.min1kbp_summary/${SAMPLE_ID}_contigs.min1kbp_virus_summary.tsv ../SAMPLES/${SAMPLE_ID}/virome_discovery/geNomad/
rm -r ${TMPDIR}/${SAMPLE_ID}/genomad_run
echo "> All done!"
