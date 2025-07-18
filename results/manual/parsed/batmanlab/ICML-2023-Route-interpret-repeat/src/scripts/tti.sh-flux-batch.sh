#!/bin/bash
#FLUX: --job-name=misunderstood-soup-7749
#FLUX: --urgency=16

pwd; hostname; date
CURRENT=`date +"%Y-%m-%d_%T"`
echo $CURRENT
slurm_output_cub_vit=cub_vit_$CURRENT.out
slurm_output_cub_resnet=cub_resnet_$CURRENT.out
slurm_output_awa2_vit=awa2_vit_$CURRENT.out
slurm_output_awa2_resnet=awa2_resnet_$CURRENT.out
echo "Test Time Interventions"
source path-of-conda/anaconda3/etc/profile.d/conda.sh
conda activate python_3_7_rtx_6000
python ../codebase/test_time_interventions_main.py --model "MoIE" --arch "ViT-B_16" --dataset "cub" --iterations 6 --top_K 3 5 10 15 20 25 30 50 > $slurm_output_cub_vit
python ../codebase/test_time_interventions_main.py --model "MoIE" --arch "ResNet101" --dataset "cub" --iterations 6 --top_K 3 5 10 15 20 25 30 50 > $slurm_output_cub_resnet
python ../codebase/test_time_interventions_main.py --model "MoIE" --arch "ViT-B_16" --dataset "awa2" --iterations 6 --top_K 3 5 10 15 20 25 30 50 > $slurm_output_awa2_vit
python ../codebase/test_time_interventions_main.py --model "MoIE" --arch "ResNet101" --dataset "awa2" --iterations 4 --top_K 3 5 10 15 20 25 30 50 > $slurm_output_awa2_resnet
