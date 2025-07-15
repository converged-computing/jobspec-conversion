#!/bin/bash
#FLUX: --job-name=pred-cross
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --priority=16

categories="Task1:relevance"
shortname="relevance"
split='full'
modelmovement='all_movements'
modelname='roberta-ft-st'
date="06-21-2023"
datadir="/home/juliame/social-movements/annotated_data/data_splits_${date}"
modelbase="/nfs/turbo/si-juliame/social-movements/roberta_models/${modelname}/${shortname}_${date}"
outdir="/home/juliame/social-movements/predictions/${modelname}/${modelmovement}_model_preds/${shortname}_${date}"
for fold in 0 1 2 3 4;
    do
    for movement in guns immigration lgbtq;
        do
        modeldir="${modelbase}/fold_${fold}/${modelmovement}/"
        evalfile="${datadir}/fold_${fold}/dev_${split}_${movement}.tsv"
        outfile="${outdir}/fold_${fold}/dev_${split}_${movement}.tsv"
        categories=${categories}
        mkdir -p ${outdir}
        python predict_roberta.py \
            --eval-file=${evalfile} \
            --model-dir=${modeldir} \
            --categories=${categories} \
            --out-file=${outfile} 
        done
    done
for movement in guns immigration lgbtq;
    do
    modeldir="${modelbase}/${modelmovement}/"
    evalfile="${datadir}/test_${split}_${movement}.tsv"
    outfile="${outdir}/test_${split}_${movement}.tsv"
    categories=${categories}
    mkdir -p ${outdir}
    python predict_roberta.py \
        --eval-file=${evalfile} \
        --model-dir=${modeldir} \
        --categories=${categories} \
        --out-file=${outfile} 
    done
