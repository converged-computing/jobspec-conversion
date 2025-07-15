#!/bin/bash
#FLUX: --job-name=butterscotch-pot-7304
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --priority=16

module load anaconda/2022.05
. ~/.mycondaconf
conda activate mf-pytorch2
module load gcc/11.2.0
python sciml/train.py \
	dataset=PB_WallSuperHeat_CrossVal150 \
	experiment=temp_unet2d \
	experiment.torch_dataset_name=temp_input_dataset \
	experiment.train.max_epochs=100
