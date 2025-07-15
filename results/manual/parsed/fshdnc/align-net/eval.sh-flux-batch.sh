#!/bin/bash
#FLUX: --job-name=phat-fudge-1324
#FLUX: -c=4
#FLUX: --queue=gputest
#FLUX: -t=600
#FLUX: --urgency=16

echo "START $SLURM_JOBID: $(date)"
function on_exit {
seff $SLURM_JOBID
gpuseff $SLURM_JOBID
echo "END $SLURM_JOBID: $(date)"
}
trap on_exit EXIT
CKPT_PATH="model_20210113-220042.pt" # on training set, for about 40 minutes
POS_DICT="data/positives/dedup_src_trg_test-positives.json"
SRC_SENT="data/eng-fin/test.src.dedup"
TRG_SENT="data/eng-fin/test.trg.dedup"
echo -e "MODEL\t$CKPT_PATH\tDICT\t$POS_DICT\tSRC\t$SRC_SENT\tTRG\t$TRG_SENT"
module purge
module load pytorch/1.3.1
python3 evaluation.py \
    --src-sentences $SRC_SENT \
    --trg-sentences $TRG_SENT \
    --ckpt-path $CKPT_PATH \
    --positive-dict $POS_DICT
