#!/bin/bash
#FLUX: --job-name=medaka_array
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

module load intel/19.0.5-fasrc01
p=$(sed "${SLURM_ARRAY_TASK_ID}q;d" contigs_fofn.txt)
CONTIGS=$(cat ${p})
BAM="/n/holyscratch01/informatics/dkhost/phlox_pilo_assembly/ppilo_Hopkins_1704_reads_vs_ppilo_v0.2.mapped.sorted.bam"
singularity exec --cleanenv --nv /n/holylfs05/LABS/informatics/Users/dkhost/medaka_v1.7.2_gpu.sif medaka consensus $BAM consensus_probs.${SLURM_ARRAY_TASK_ID}.hdf --batch_size 500 --threads 8 --region $CONTIGS --model r941_sup_plant_g610
