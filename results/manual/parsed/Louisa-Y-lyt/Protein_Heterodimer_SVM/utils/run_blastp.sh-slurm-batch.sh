#!/bin/bash
#SBATCH --job-name=blastp
#SBATCH --output=/n/home10/ytingliu/alphapulldown_new/logs/blastp_%A_%a_out.txt
#SBATCH --error=/n/home10/ytingliu/alphapulldown_new/logs/blastp_%A_%a_err.txt
#SBATCH --mail-user=yutingliu@hsph.harvard.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=128000
#SBATCH --time=04:00:00
#SBATCH --qos=high

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
