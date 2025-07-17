#!/bin/bash
#FLUX: --job-name=blastp
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=50

INPUT_FILE=$1
SLURM_CPUS_PER_TASK=4
BLASTP_CMD="/n/home10/ytingliu/ncbi-blast-2.15.0+/bin/blastp"
TASK_ID=$SLURM_ARRAY_TASK_ID
HEADER=$(sed -n "$((TASK_ID * 4 - 3))p" $INPUT_FILE)
SEQUENCE=$(sed -n "$((TASK_ID * 4 - 2))p" $INPUT_FILE)
TMP_QUERY_FILE="/n/home10/ytingliu/blast_tmp/query_${TASK_ID}.fasta"
echo $HEADER > $TMP_QUERY_FILE
echo $SEQUENCE >> $TMP_QUERY_FILE
DATABASE="human_protein_db"
$BLASTP_CMD -query $TMP_QUERY_FILE -db $DATABASE -out /n/home10/ytingliu/blast_res/${HEADER#>}.txt -outfmt 6 -num_threads $SLURM_CPUS_PER_TASK
rm $TMP_QUERY_FILE
