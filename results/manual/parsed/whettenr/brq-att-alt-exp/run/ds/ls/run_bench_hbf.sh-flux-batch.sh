#!/bin/bash
#FLUX: --job-name=ls_hbf
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

module load pytorch-gpu/py3/2.1.1
conda activate aa
cd /gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp
hub=/gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp/results/hbf/1000/save/CKPT+2024-02-19+19-48-51+00
num_layers='13'
encoder_dim='936'
attention_type='hypermixing'
encoder_module='branchformer'
output_folder='results/MP3/hbf'
csv_location=/gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp/results/MP3S
benchmark_location=/gpfswork/rech/nkp/uaj64gk/attention_alt/benchmarks
DatasetsFolders=('/corpus/LibriSpeech/' '/corpus/LibriSpeech/')
ConsideredTasks=('LibriSpeech' 'LibriSpeech')
DownStreams=('LSTM' 'contextnet')
for i in "${!ConsideredTasks[@]}"; do
	task=${ConsideredTasks[i]}
	downstream=${DownStreams[i]}
	dataset_folder=${DatasetsFolders[i]}
	python $benchmark_location/benchmarks/MP3S/$task/$downstream/train.py $benchmark_location/benchmarks/MP3S/$task/$downstream/hparams/ssl_brq.yaml \
		--num_layers_ssl $num_layers --ssl_hub $hub --encoder_dim $encoder_dim --output_folder $output_folder/$task/$downstream --data_folder $dataset_folder \
		--attention_type $attention_type --encoder_module $encoder_module \
		--csv_location $csv_location
	python $benchmark_location/benchmarks/MP3S/$task/$downstream/train.py $benchmark_location/benchmarks/MP3S/$task/$downstream/hparams/ssl_brq.yaml \
		--num_layers_ssl $num_layers --ssl_hub $hub --encoder_dim $encoder_dim --output_folder $output_folder/$task/$downstream --data_folder $dataset_folder \
		--attention_type $attention_type --encoder_module $encoder_module \
		--test_only --language_modelling True \
		--csv_location $csv_location
done
