#!/bin/bash
#FLUX: --job-name=Chiliadal_NGCTRLs
#FLUX: -c=2
#FLUX: -t=176340
#FLUX: --priority=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST} | cut -d "_" -f1)
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ../SAMPLES/${SAMPLE_ID}/hits_to_refs
module purge
module load BLAST+
echo "> Running blastn against nt"
blastn \
        -query ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.min1kbp.fasta \
       	-db /scratch/p282752/databases/NT_v1.1_nov_23/nt \
        -evalue 1e-10 \
	-outfmt '6 qseqid sseqid pident length qlen slen evalue qstart qend sstart send stitle qcovs' \
        -out ../SAMPLES/${SAMPLE_ID}/hits_to_refs/hits_to_nt.txt \
	-num_threads ${SLURM_CPUS_PER_TASK}
module list
module purge
