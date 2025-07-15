#!/bin/bash
#FLUX: --job-name=stanky-egg-1518
#FLUX: -c=8
#FLUX: --queue=serial_std
#FLUX: -t=259200
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load charliecloud
PROJECT_ID=cov2
DATA_VERSION=20200329
FIT_VERSION=20200329
CHUNK_IDS_FILE=${SCRATCH}/${PROJECT_ID}/pending_chunk_ids
if [[ -f $CHUNK_IDS_FILE ]]; then
  echo "Reading ${CHUNK_IDS_FILE}..."
  readarray -t CHUNK_IDS < $CHUNK_IDS_FILE
fi
CHUNK_IX_START=$((4000+SLURM_ARRAY_TASK_ID))
CHUNK_IX_LAST=5542
CHUNK_IX_STRIDE=$SLURM_ARRAY_TASK_COUNT
if [[ -v CHUNK_IDS ]]; then
  CHUNK_IX_LAST=${#CHUNK_IDS[@]}
fi
echo "Chunks indices to process: ${CHUNK_IX_START}..${CHUNK_IX_LAST}..${CHUNK_IX_STRIDE}"
for ((chunk_ix = CHUNK_IX_START; chunk_ix <= CHUNK_IX_LAST; chunk_ix += CHUNK_IX_STRIDE)); do
if [[ -v CHUNK_IDS ]]; then
  chunk_id=${CHUNK_IDS[((chunk_ix-1))]}
else
  chunk_id=$chunk_ix
fi
echo "Chunk #$chunk_id: MSGLM fit starting..."
{
ch-run $SCRATCH/docker4muc/archpc.msglm \
  -t --unset-env='*PATH' \
  -b $HOME/projects/adhoc:/projects/adhoc \
  -b $HOME/data:/data \
  -b $HOME/analysis:/analysis \
  -b $SCRATCH:/scratch \
  -- Rscript /projects/adhoc/$PROJECT_ID/msglm_fit_chunk_apms.R \
  $PROJECT_ID $SLURM_JOB_NAME mq_apms_20200329 $DATA_VERSION $FIT_VERSION $SLURM_ARRAY_JOB_ID $chunk_id && \
echo "Chunk #$chunk_id: MSGLM fit done"
} || {
echo "Chunk #$chunk_id: MSGLM fit failed"
}
done
echo "All chunks of array task id=$SLURM_ARRAY_TASK_ID finished"
