#!/bin/bash
#FLUX: --job-name=audio-caption
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: --priority=16

module load java/1.8.0.162
run_script=$1
run_config=$2
kaldi_stream=$3
kaldi_scp=$4
eval_caption_file=$5
eval_embedding_file=$6
seed=1
if [ $# -eq 7 ]; then
    seed=$7
fi
if [ ! $experiment_path ]; then
    experiment_path=`python ${run_script} \
                            train \
                            ${run_config} \
                            --seed $seed`
fi
if [ ! $experiment_path ]; then
    echo "invalid experiment path, maybe the training ended abnormally"
    exit 1
fi
python ${run_script} \
       evaluate \
       ${experiment_path} \
       "${kaldi_stream}" \
       ${kaldi_scp} \
       ${eval_caption_file} \
       --caption-embedding-path ${eval_embedding_file}
       #sample \
       #${experiment_path} \
       #"${kaldi_stream}" \
       #$kaldi_scp
