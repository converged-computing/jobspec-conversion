#!/bin/bash
#FLUX: --job-name=cv_ff
#FLUX: -c=8
#FLUX: -t=270000
#FLUX: --urgency=16

module load pytorch-gpu/py3/2.1.1
conda activate aa
cd /gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp
hub=/gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp/results/old/ff/1000/save/CKPT+2024-02-01+04-59-34+00
num_layers='13'
encoder_dim='512' # change to ??
attention_type='fastattention'
encoder_module='conformer'
output_folder='results/MP3/ff'
benchmark_location=/gpfswork/rech/nkp/uaj64gk/attention_alt/benchmarks
language='cy'
DatasetsFolders=("/gpfsscratch/rech/nkp/uaj64gk/corpus/cv-corpus-11.0-2022-09-21/$language" "/gpfsscratch/rech/nkp/uaj64gk/corpus/cv-corpus-11.0-2022-09-21/$language")
ConsideredTasks=('CommonVoice' 'CommonVoice')
DownStreams=('LSTM' 'linear')
for i in "${!ConsideredTasks[@]}"; do
	task=${ConsideredTasks[i]}
	downstream=${DownStreams[i]}
	dataset_folder=${DatasetsFolders[i]}
	python $benchmark_location/benchmarks/MP3S/$task/$downstream/train.py $benchmark_location/benchmarks/MP3S/$task/$downstream/hparams/ssl_brq.yaml \
		--num_layers_ssl $num_layers --ssl_hub $hub --encoder_dim $encoder_dim --attention_type $attention_type --encoder_module $encoder_module --output_folder $output_folder/$task/$language/$downstream --data_folder $dataset_folder \
		--language $language
done
language='eu'
DatasetsFolders=("/users/rwhetten/commonvoice/cv-corpus-11.0-2022-09-21/$language" "/users/rwhetten/commonvoice/cv-corpus-11.0-2022-09-21/$language")
ConsideredTasks=('CommonVoice' 'CommonVoice')
DownStreams=('LSTM' 'linear')
for i in "${!ConsideredTasks[@]}"; do
	task=${ConsideredTasks[i]}
	downstream=${DownStreams[i]}
	dataset_folder=${DatasetsFolders[i]}
	python $benchmark_location/benchmarks/MP3S/$task/$downstream/train.py $benchmark_location/benchmarks/MP3S/$task/$downstream/hparams/ssl_brq.yaml \
		--num_layers_ssl $num_layers --ssl_hub $hub --encoder_dim $encoder_dim --attention_type $attention_type --encoder_module $encoder_module --output_folder $output_folder/$task/$language/$downstream --data_folder $dataset_folder \
		--language $language
done
