#!/bin/bash
#FLUX: --job-name=hazpi_summarize
#FLUX: --queue=gpu,gpuv100,gpup6000,lasti
#FLUX: -t=18000
#FLUX: --priority=16

set -o errexit
set -o pipefail
echo "$0"
source /softs/anaconda/3-5.3.1/bin/activate
source activate hazpi
module load cuda/10.1
/usr/bin/env python3 --version
if [[ -v SLURM_JOB_ID ]] ; then
    nvidia-smi
    # Affiche la (ou les gpus) allouee par Slurm pour ce job
    echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
fi
echo "Begin on machine: `hostname`"
echo 'Script starting'
cd /home/users/gdechalendar/Projets/HazPi/HazPi
echo 'Summarizing'
python summarize.py -checkpoint_path /home/data/jlopez/experiments_all_db/ckp_not_all_vocab/ckp_pre_transformer_4Layers_moreEnc_vocab100_100/epoch_350/fine-tuning/epoch_550/epoch_550_FT_1/ -path_summaries_encoded /home/data/jlopez/headlines/results_complete_db/test/dec_bs_fine-tuning_epochs_350_550_4L_4E_noFilters_encoder2000_FT1/encoded_ngram/ -path_summaries_decoded /home/data/jlopez/headlines/results_complete_db/test/dec_bs_fine-tuning_epochs_350_550_4L_4E_noFilters_encoder2000_FT1/decoded_ngram/ -path_summaries_error /home/data/jlopez/headlines/results_complete_db/test/dec_bs_fine-tuning_epochs_350_550_4L_4E_noFilters_encoder2000_FT1/error_ngram/ -batch_size 32 -num_heads 8 -dff 2048 -num_layers 4 -d_model 128 -encoder_max_vocab 100000 -decoder_max_vocab 100000 -num_layers 4 -vocab_load_dir /home/data/jlopez/experiments_all_db/vocab/ckp_pre_transformer_4Layers_moreEnc_vocab100_100/ -ngram_size 2 -k 6 -len_summary 216 file.txt
