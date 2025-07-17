#!/bin/bash
#FLUX: --job-name=12m_mort
#FLUX: -c=5
#FLUX: --queue=nigam-v100
#FLUX: -t=172800
#FLUX: --urgency=16

seeds="0"
n_gpus=1
strategy=deepspeed
batch_size=128
num_workers=4
num_slices=250
echo "***************" "12_month_mortality" "********************************************"
for seed in $seeds
do
python run_classify.py model=model_1d dataset=stanford_featurized \
	dataset.target=12_month_mortality\
	dataset.pretrain_args.model_type=resnetv2_101_ct\
	dataset.pretrain_args.channel_type=window\
	dataset.feature_size=768 \
	dataset.num_slices=250 \
	model.aggregation=attention \
	model.seq_encoder.rnn_type=GRU \
	model.seq_encoder.bidirectional=true\
	model.seq_encoder.num_layers=1\
	model.seq_encoder.hidden_size=128\
	model.seq_encoder.dropout_prob=0.5\
	dataset.weighted_sample=true \
	trainer.max_epochs=50\
	lr=0.0005 \
	trainer.seed=$seed \
	n_gpus=$n_gpus\
	trainer.strategy=${strategy} \
	dataset.batch_size=${batch_size} \
	trainer.num_workers=${num_workers} \
	dataset.num_slices=${num_slices}
done
