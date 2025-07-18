#!/bin/bash
#FLUX: --job-name=Task2
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

export OMPI_MCA_mpi_warn_on_fork='0 #disable MPI warnings'

/bin/hostname
srun -l /bin/hostname
srun -l /bin/pwd
export OMPI_MCA_mpi_warn_on_fork=0 #disable MPI warnings
ml PyTorch/1.10.0-foss-2021a-CUDA-11.3.1
source /home/kangchen/Diffusion-LM-main/EnvDiff/bin/activate
cd /home/kangchen/Diffusion-LM-main/
mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m 'original' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m 'original' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 512 --modality writingprompts --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --prompts_train ./datasets/WritingPrompts " --notes xstart_e2e --bsz 8
mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m 'original' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 1024 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/wikitext-103" --notes xstart_e2e --bsz 8
ml PyTorch/1.9.0-fosscuda-2020b
export OMPI_MCA_mpi_warn_on_fork=0 #disable MPI warnings
cd /home/kangchen/Diffusion-LM-main/
source EnvDiff/bin/activate
mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m 'original' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
CUDA_LAUNCH_BLOCKING=1 mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m 'original' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 1024 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/wikitext-2" --notes xstart_e2e --bsz 32
CUDA_LAUNCH_BLOCKING=1 mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m 'original' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 1200000 --seed 101 --noise_schedule sqrt --in_channel 1024 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/wikitext-103" --notes xstart_e2e --bsz 32
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/diffusion_models/diff_roc_original_0_0_pad_rand512*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_original_0_0_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_roc_bnn_0_0*/ -1.0 ema
ml PyTorch/1.10.0-foss-2021a-CUDA-11.3.1
source /home/kangchen/Quantized_Adaptor/EvnQaunt/bin/activate
python /home/kangchen/Quantized_Adaptor/transformers/examples/pytorch/language-modeling/run_clm.py \
--model_name_or_path gpt2 \
--train_file /home/kangchen/Diffusion-LM-main/datasets/ROCstory/roc_train.json \
--validation_file /home/kangchen/Diffusion-LM-main/datasets/ROCstory/roc_valid.json \
--per_device_train_batch_size 8 \
--per_device_eval_batch_size 8 \
--do_train \
--do_eval \
--output_dir /home/kangchen/Diffusion-LM-main/datasets/WritingPrompts/test-clm/
python /home/kangchen/Quantized_Adaptor/transformers/examples/pytorch/language-modeling/run_clm.py \
--model_name_or_path gpt2 \
--train_file /home/kangchen/Diffusion-LM-main/datasets/WritingPrompts/train.json \
--validation_file /home/kangchen/Diffusion-LM-main/datasets/WritingPrompts/valid.json \
--per_device_train_batch_size 8 \
--per_device_eval_batch_size 8 \
--do_train \
--do_eval \
--output_dir /home/kangchen/Diffusion-LM-main/datasets/WritingPrompts/test-clm/
python /home/kangchen/Quantized_Adaptor/transformers/examples/pytorch/language-modeling/run_clm.py \
--model_name_or_path gpt2 \
--dataset_name wikitext \
--dataset_config_name wikitext-2-raw-v1 \
--per_device_train_batch_size 8 \
--per_device_eval_batch_size 8 \
--do_train \
--do_eval \
--output_dir /home/kangchen/Diffusion-LM-main/datasets/WritingPrompts/test-clm/
