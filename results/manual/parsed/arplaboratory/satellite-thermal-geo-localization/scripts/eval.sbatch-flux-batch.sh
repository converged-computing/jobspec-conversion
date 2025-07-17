#!/bin/bash
#FLUX: --job-name=eval_thermal
#FLUX: -t=3600
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate VTL
python3 eval.py --resume='logs/default/'$1'/best_model.pth' --dataset_name=satellite_0_thermalmapping_135 --datasets_folder ./datasets --infer_batch_size 16 --use_faiss_gpu --backbone $2 --conv_output_dim 4096 --add_bn --G_contrast
python3 eval.py --resume='logs/default/'$1'/best_model.pth' --dataset_name=satellite_0_thermalmapping_135 --datasets_folder ./datasets --infer_batch_size 16 --prior_location_threshold=512 --use_faiss_gpu --backbone $2 --conv_output_dim 4096 --add_bn --G_contrast
