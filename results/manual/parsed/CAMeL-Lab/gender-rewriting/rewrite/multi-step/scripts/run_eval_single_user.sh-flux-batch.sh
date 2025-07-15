#!/bin/bash
#FLUX: --job-name=crunchy-lemur-5751
#FLUX: -c=10
#FLUX: -t=41400
#FLUX: --urgency=16

export EXPERIMENT='CorpusR_MorphR_NeuralR_test'
export SYSTEM_HYP='/home/ba63/gender-rewriting/rewrite/multi-step/logs/single_user/rewriting/$EXPERIMENT'
export DATA_DIR='/home/ba63/gender-rewriting/data/m2_edits/v1.0/'
export DATA_SPLIT='test'
export GOLD_DATA='norm_data/D-set-$DATA_SPLIT.ar.M+D-set-$DATA_SPLIT.ar.F.norm'
export EDITS_ANNOTATIONS='edits/$DATA_SPLIT.arin+$DATA_SPLIT.arin.to.$DATA_SPLIT.ar.M+$DATA_SPLIT.ar.F.norm'
export GOLD_ANNOTATION='$DATA_DIR/$EDITS_ANNOTATIONS'
export TRG_GOLD_DATA='$DATA_DIR/$GOLD_DATA'

export EXPERIMENT=CorpusR_MorphR_NeuralR_test
export SYSTEM_HYP=/home/ba63/gender-rewriting/rewrite/multi-step/logs/single_user/rewriting/$EXPERIMENT
cat $SYSTEM_HYP/arin.to.M.preds $SYSTEM_HYP/arin.to.F.preds > $SYSTEM_HYP/$EXPERIMENT.inf
python /home/ba63/gender-rewriting/rewrite/multi-step/utils/normalize.py --input_file $SYSTEM_HYP/$EXPERIMENT.inf --output_file $SYSTEM_HYP/$EXPERIMENT.inf.norm
export DATA_DIR=/home/ba63/gender-rewriting/data/m2_edits/v1.0/
export DATA_SPLIT=test
export GOLD_DATA=norm_data/D-set-$DATA_SPLIT.ar.M+D-set-$DATA_SPLIT.ar.F.norm
export EDITS_ANNOTATIONS=edits/$DATA_SPLIT.arin+$DATA_SPLIT.arin.to.$DATA_SPLIT.ar.M+$DATA_SPLIT.ar.F.norm
export GOLD_ANNOTATION=$DATA_DIR/$EDITS_ANNOTATIONS
export TRG_GOLD_DATA=$DATA_DIR/$GOLD_DATA
eval "$(conda shell.bash hook)"
conda activate python2
m2_eval=$(python /home/ba63/gender-rewriting/m2scorer/m2scorer $SYSTEM_HYP/$EXPERIMENT.inf.norm $GOLD_ANNOTATION)
conda activate gender_rewriting
accuracy=$(python /home/ba63/gender-rewriting/rewrite/joint/utils/metrics.py --trg_directory $TRG_GOLD_DATA --pred_directory $SYSTEM_HYP/$EXPERIMENT.inf.norm)
bleu=$(sacrebleu $TRG_GOLD_DATA  -i $SYSTEM_HYP/$EXPERIMENT.inf.norm -m bleu -w 2 --force)
printf "%s\n%s\n%-12s%s" "$m2_eval" "$accuracy" "BLEU" ": $bleu" > eval.$EXPERIMENT
