#!/bin/bash
#FLUX: --job-name=frame-elements
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

epochs=20
seed=42
batchsize=32
modelpath='/nfs/turbo/si-juliame/social-movements/ft_roberta_simpletransformers'
modelname='roberta-ft-st'
date="06-21-2023"
datadir="/home/juliame/social-movements/annotated_data/data_splits_${date}"
baseoutdir="/nfs/turbo/si-juliame/social-movements/roberta_binary_models/${modelname}"
categories="Task4:counter Task5:motivational"
for category in ${categories};
    do
    IFS=: read -r task shortname <<< ${category}
    trainfile="${datadir}/train_relevant.tsv"
    outdir="${baseoutdir}/${shortname}/all_movements/"
    mkdir -p ${outdir}
    echo "Training binary classifier for ${category}"
    echo "Task: ${task}"
    echo "Shortname: ${shortname}"
    echo "Trainfile: ${trainfile}"
    echo "Outdir: ${outdir}"
    python train_roberta.py \
        --train-file=${trainfile} \
        --output-dir=${outdir} \
        --categories=${category} \
        --num-epochs=${epochs} \
        --manual-seed=${seed} \
        --train-batch-size=${batchsize} \
        --model-path=${modelpath}
    for fold in 0 1 2 3 4;
        do
        trainfile="${datadir}/fold_${fold}/train_relevant.tsv"
        outdir="${baseoutdir}/${shortname}/fold_${fold}/all_movements/"
        mkdir -p ${outdir}
        echo "Training binary classifier for ${category}"
        echo "Task: ${task}"
        echo "Shortname: ${shortname}"
        echo "Trainfile: ${trainfile}"
        echo "Outdir: ${outdir}"
        python train_roberta.py \
        --train-file=${trainfile} \
        --output-dir=${outdir} \
        --categories=${category} \
        --num-epochs=${epochs} \
        --manual-seed=${seed} \
        --train-batch-size=${batchsize} \
        --model-path=${modelpath}
    done
done
