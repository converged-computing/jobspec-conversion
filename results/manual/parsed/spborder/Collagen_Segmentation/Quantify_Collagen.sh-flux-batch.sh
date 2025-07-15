#!/bin/bash
#FLUX: --job-name=collagen_quantification
#FLUX: -t=3600
#FLUX: --priority=16

pwd; hostname; date
module load singularity
singularity exec ./collagen_segmentation_latest.sif python3 Collagen_Segmentation/CollagenQuantify.py --test_image_path "/blue/pinaki.sarder/samuelborder/Farzad_Fibrosis/Same_Training_Set_Data/Results/Ensemble_RGB/Testing_Output/" --bf_image_dir "/blue/pinaki.sarder/samuelborder/Farzad_Fibrosis/Same_Training_Set_Data/B/" --f_image_dir "/blue/pinaki.sarder/samuelborder/Farzad_Fibrosis/Same_Training_Set_Data/F/" --output_dir "/blue/pinaki.sarder/samuelborder/Farzad_Fibrosis/Same_Training_Set_Data/Results/Ensemble_RGB/Collagen_Quantification/" --threshold 0.1
date
