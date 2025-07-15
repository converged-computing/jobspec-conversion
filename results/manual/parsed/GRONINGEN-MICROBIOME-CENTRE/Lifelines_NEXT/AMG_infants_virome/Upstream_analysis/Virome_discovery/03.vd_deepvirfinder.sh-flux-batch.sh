#!/bin/bash
#FLUX: --job-name=ViromeDiscovery
#FLUX: -c=8
#FLUX: -t=46740
#FLUX: --priority=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST})
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ../SAMPLES/${SAMPLE_ID}/virome_discovery/DeepVirFinder
module purge
module load Anaconda3
source activate /scratch/hb-llnext/conda_envs/DeepVirFinder_env
echo "> Running DeepVirFinder"
python /scratch/hb-llnext/conda_envs/DeepVirFinder_env/DeepVirFinder/dvf.py \
	-i ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.min1kbp.fasta \
	-o ../SAMPLES/${SAMPLE_ID}/virome_discovery/DeepVirFinder/ \
	-l 1000
conda list
conda deactivate
module list
module purge
