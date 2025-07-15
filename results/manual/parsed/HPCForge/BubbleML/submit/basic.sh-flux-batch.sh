#!/bin/bash
#FLUX: --job-name=frigid-gato-3619
#FLUX: -c=20
#FLUX: -t=57600
#FLUX: --urgency=16

module load anaconda/2022.05
. ~/.mycondaconf
conda activate bubble-sciml
module load gcc/11.2.0
python sciml/train.py \
	data_base_dir=/share/crsp/lab/amowli/share/BubbleML2/ \
	log_dir=/share/crsp/lab/ai4ts/afeeney/log_dir \
	dataset=PB_WallSuperHeat \
	experiment=temp_fno \
	experiment.train.max_epochs=2 \
	#experiment.lr_scheduler.patience=50
	#model_checkpoint=/share/crsp/lab/ai4ts/afeeney/log_dir/23089030/subcooled/UNet2d_vel_dataset_100_1691046606.pt \
	#model_checkpoint=/data/homezvol2/afeeney/crsp/ai4ts/afeeney/thermal_models/subcooled/UNet2d_temp_input_dataset_500_1690005305.pt \
