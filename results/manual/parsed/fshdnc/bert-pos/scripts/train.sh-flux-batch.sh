#!/bin/bash
#FLUX: --job-name=bert-pos
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

if [ "$#" -ne 2 ]; then
    echo "Usage: sbatch $0 MODEL_NAME LR"
    exit 1
fi
cd /scratch/project_2002820/lihsin/bert-pos/scripts # otherwise gives unbound variable error
set -euo pipefail
MODEL_NAME="$1"
LR="$2"
SCRIPTDIR="/scratch/project_2002820/lihsin/bert-pos/scripts"
OUTDIR="$SCRIPTDIR/../output/$SLURM_JOBID"
mkdir -p $OUTDIR
DATADIR="$SCRIPTDIR/../data/tdt"
source /scratch/project_2002820/lihsin/bert-experiments/scripts/select-model.sh
return_model $MODEL_NAME
echo "Task: POS; Data: $(basename $DATADIR); Model: $MODEL_NAME; LR: $LR"
echo "START: $(date)"
module purge
module load tensorflow
source /projappl/project_2002820/venv/bert-pos/bin/activate
python3 ../train.py \
    --vocab_file "$MODELDIR/vocab.txt" \
    --bert_config_file "$MODELDIR/bert_config.json" \
    --init_checkpoint "$MODELDIR/$MODEL" \
    --data_dir "$DATADIR" \
    --learning_rate $LR \
    --num_train_epochs 3 \
    --predict test \
    --output $OUTDIR/pred.tsv
python $SCRIPTDIR/mergepos.py "$DATADIR/test.conllu" "$OUTDIR/pred.tsv" > "$OUTDIR/pred.conllu"
python $SCRIPTDIR/conll18_ud_eval.py -v "$DATADIR/gold-test.conllu" "$OUTDIR/pred.conllu"
seff $SLURM_JOBID
echo "END: $(date)"
