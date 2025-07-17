#!/bin/bash
#FLUX: --job-name=porechop_array
#FLUX: -c=32
#FLUX: --queue=standard
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load openmpi/4.0.3/gcc.8.4.0
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load anaconda/2020.07
source activate porechop 
WORKDIR=/path/to/read/files
THREAD=32
cd $WORKDIR
SAMPLE_NAME=`ls *_nanopore.fastq.gz | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`
PREFIX=`echo $SAMPLE_NAME | cut -f1 -d'_'` ;
genomeID=$(echo $SAMPLE_NAME)
	porechop -i ${PREFIX}_nanopore.fastq.gz -o ${PREFIX}_output.fastq.gz  --threads ${THREAD}
