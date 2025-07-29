#!/bin/bash
#FLUX: --job-name=ViromeDiscovery
#FLUX: -c=8
#FLUX: -t=46740
#FLUX: --urgency=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST})
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ../SAMPLES/${SAMPLE_ID}/virome_discovery/VirSorter2
module purge
module load Anaconda3
source activate /scratch/hb-llnext/conda_envs/VirSorter2_env
echo "> Running VirSorter2"
virsorter run \
	-w ../SAMPLES/${SAMPLE_ID}/virome_discovery/VirSorter2/ \
	-i ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.min1kbp.fasta \
	--min-length 1000 \
	--keep-original-seq \
	--include-groups "dsDNAphage,RNA,NCLDV,ssDNA,lavidaviridae" \
	--db-dir /scratch/hb-llnext/conda_envs/VirSorter2_env/db \
	-j ${SLURM_CPUS_PER_TASK} \
	all
echo "> Removing byproducts"
rm -r ../SAMPLES/${SAMPLE_ID}/virome_discovery/VirSorter2/iter-0
rm -r ../SAMPLES/${SAMPLE_ID}/virome_discovery/VirSorter2/log
rm ../SAMPLES/${SAMPLE_ID}/virome_discovery/VirSorter2/config.yaml
conda list
conda deactivate
module list
module purge
