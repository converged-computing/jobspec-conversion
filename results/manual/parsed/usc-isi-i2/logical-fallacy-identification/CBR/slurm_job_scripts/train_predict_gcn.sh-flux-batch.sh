#!/bin/bash
#FLUX: --job-name=train_predict_GCN
#FLUX: -c=16
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --urgency=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
python -m cbr_analyser.case_retriever.gcn.gcn \
    --task predict \
    --train_input_file cache/masked_sentences_with_AMR_container_objects_train.joblib \
    --dev_input_file cache/masked_sentences_with_AMR_container_objects_dev.joblib \
    --test_input_file cache/masked_sentences_with_AMR_container_objects_test.joblib \
    --predictions_path gcn_results \
    --model_path gcn_model.pt
conda deactivate
