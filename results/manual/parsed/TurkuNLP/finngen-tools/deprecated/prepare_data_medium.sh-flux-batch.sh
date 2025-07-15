#!/bin/bash
#FLUX: --job-name=bricky-nunchucks-9199
#FLUX: -c=128
#FLUX: --queue=medium
#FLUX: -t=86400
#FLUX: --priority=16

export HF_DATASETS_CACHE='$CACHEDIR'

DATADIR="texts"
OUTDIR="processed"
TOKENIZER="tokenizer"
rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOBID.out logs/latest.out
ln -s $SLURM_JOBID.err logs/latest.err
module purge
module load pytorch
CACHEDIR="/scratch/$SLURM_JOB_ACCOUNT/datasets_cache_$SLURM_JOBID"
export HF_DATASETS_CACHE="$CACHEDIR"
echo "CACHE: $HF_DATASETS_CACHE"
function on_exit {
    rm -rf "$CACHEDIR"
}
trap on_exit EXIT
NUM_WORKERS=$SLURM_CPUS_PER_TASK
echo "START $SLURM_JOBID: $(date)"
python prepare_data.py \
    --data "$DATADIR" \
    --tokenizer "$TOKENIZER" \
    --output_dir "$OUTDIR" \
    --num_workers $NUM_WORKERS \
    "$@"
seff $SLURM_JOBID
echo "END $SLURM_JOBID: $(date)"
