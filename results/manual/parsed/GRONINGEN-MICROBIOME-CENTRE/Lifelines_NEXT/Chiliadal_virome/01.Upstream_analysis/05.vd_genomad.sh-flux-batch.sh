#!/bin/bash
#FLUX: --job-name=ViromeDiscovery
#FLUX: -c=8
#FLUX: -t=21540
#FLUX: --priority=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST} | cut -d "_" -f1)
echo "SAMPLE_ID=${SAMPLE_ID}"
module load ARAGORN/1.2.41-foss-2021b
module load Python/3.9.5-GCCcore-10.3.0
source /scratch/p282752/tools/python_envs/geNomad/bin/activate
echo "> Running geNomad"
genomad \
	end-to-end \
	--enable-score-calibration \
	--cleanup \
	../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.min1kbp.fasta \
	../SAMPLES/${SAMPLE_ID}/virome_discovery/geNomad \
	/scratch/p282752/databases/genomad_db
genomad --version
deactivate
module list
module purge
