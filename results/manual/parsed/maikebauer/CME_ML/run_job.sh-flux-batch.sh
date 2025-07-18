#!/bin/bash
#FLUX: --job-name=Train_CNN
#FLUX: --queue=zen2_0256_a40x2
#FLUX: --urgency=16

export PYTORCH_ENABLE_MPS_FALLBACK='1'

export PYTORCH_ENABLE_MPS_FALLBACK=1
module purge
nvidia-smi
module load miniconda3
eval "$(conda shell.bash hook)"
conda activate cme_ml
mode="Train_3DConv_Slide" #Test #Train_Flow #Train_Varghese #Train #Train_3DConv_Prob
declare -a epoch=(0 5 10 15 20 30 40 50 60 70 80 90 100 120 140 160 180 200 250 300 350 400) #0 5 10 15 20 30 40 50 60 70 80 90 100 120 140 160 180 200 250 300 350 400
model_run="model_torch.py"
model_flow="model_flow.py"
model_varghese="model_varghese.py"
model_3dconv="model_3dconv.py"
model_3dconv_prob="model_3dconv_prob.py"
model_3dconv_slide="model_3dconv_onec_slide.py"
eval_run="evaluation.py"
eval_folder="run_22022024_133027_model_resnet34"
backbone="unetr" #cnn3d
if [ "$mode" = "Train" ]
then
    python "$model_run" "$backbone"
elif [ "$mode" = "Train_Flow" ]
then
    python "$model_flow"
elif [ "$mode" = "Train_Varghese" ]
then
    python "$model_varghese" "$backbone"
elif [ "$mode" = "Train_3DConv" ]
then
    python "$model_3dconv" "$backbone"
elif [ "$mode" = "Train_3DConv_Prob" ]
then
    python "$model_3dconv_prob" "$backbone"
elif [ "$mode" = "Train_3DConv_Slide" ]
then
    python "$model_3dconv_slide" "$backbone"
elif [ "$mode" = "Test" ]
then
    for i in "${epoch[@]}"
    do
       python "$eval_run" "$i" "$eval_folder"
    done
fi
