#!/bin/bash
#FLUX: --job-name=relevance
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

categories="Task1:relevance"
epochs=20
seed=42
batchsize=32
modelpath='/nfs/turbo/si-juliame/social-movements/ft_roberta_simpletransformers'
modelname='roberta-ft-st'
date="06-21-2023"
datadir="/home/juliame/social-movements/annotated_data/data_splits_${date}"
baseoutdir="/nfs/turbo/si-juliame/social-movements/roberta_models/${modelname}/relevance_${date}"
for fold in 0 1 2 3 4;
    do
    trainfile="${datadir}/fold_${fold}/train_full.tsv"
    outdir="${baseoutdir}/fold_${fold}/all_movements/"
    categories=${categories}
    mkdir -p ${outdir}
    python train_roberta.py \
    --train-file=${trainfile} \
    --output-dir=${outdir} \
    --categories=${categories} \
    --num-epochs=${epochs} \
    --manual-seed=${seed} \
    --train-batch-size=${batchsize} \
    --model-path=${modelpath}
done
for movement in guns immigration lgbtq;
    do
    trainfile="${datadir}/train_full_${movement}.tsv"
    outdir="${baseoutdir}/${movement}/"
    categories=${categories}
    mkdir -p ${outdir}
    python train_roberta.py \
    --train-file=${trainfile} \
    --output-dir=${outdir} \
    --categories=${categories} \
    --num-epochs=${epochs} \
    --manual-seed=${seed} \
    --train-batch-size=${batchsize} \
    --model-path=${modelpath}
done
for fold in 0 1 2 3 4;
    do
    for movement in guns immigration lgbtq;
        do
        trainfile="${datadir}/fold_${fold}/train_full_${movement}.tsv"
        outdir="${baseoutdir}/fold_${fold}/${movement}/"
        categories=${categories}
        mkdir -p ${outdir}
        python train_roberta.py \
        --train-file=${trainfile} \
        --output-dir=${outdir} \
        --categories=${categories} \
        --num-epochs=${epochs} \
        --manual-seed=${seed} \
        --train-batch-size=${batchsize} \
        --model-path=${modelpath}
    done
done
