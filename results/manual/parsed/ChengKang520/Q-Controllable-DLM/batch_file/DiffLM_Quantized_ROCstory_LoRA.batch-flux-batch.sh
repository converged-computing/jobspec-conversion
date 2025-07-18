#!/bin/bash
#FLUX: --job-name=Q_LoRA_ROCstorys
#FLUX: --queue=amdgpulong
#FLUX: -t=259200
#FLUX: --urgency=16

export OMPI_MCA_mpi_warn_on_fork='0 #disable MPI warnings'

/bin/hostname
srun -l /bin/hostname
srun -l /bin/pwd
ml PyTorch/1.9.0-fosscuda-2020b
export OMPI_MCA_mpi_warn_on_fork=0 #disable MPI warnings
cd /home/kangchen/Diffusion-LM-main/
source EnvDiff/bin/activate
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'original' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/diffusion_models/diff_LoRA_roc_original_0_0*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_original_0_0_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'bnn' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_bnn_0_0*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_bnn_0_0_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'ternary' --weight_i_width 0 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_ternary_0_0*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_ternary_0_0_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'fixed' --weight_i_width 0 --weight_f_width 4 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_fixed_0_4*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_fixed_0_4_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'fixed' --weight_i_width 4 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_fixed_4_0*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_fixed_4_0_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'fixed' --weight_i_width 0 --weight_f_width 8 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_fixed_0_8*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_fixed_0_8_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'fixed' --weight_i_width 8 --weight_f_width 0 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_fixed_8_0*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_fixed_8_0_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'fixed' --weight_i_width 4 --weight_f_width 4 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_fixed_4_4*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_fixed_4_4_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python improved-diffusion/scripts/run_train.py --apply_lora --quant_m 'fixed' --weight_i_width 8 --weight_f_width 8 --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_LoRA_roc_fixed_8_8*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_roc_fixed_8_8_pad_rand128_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd101_xstart_e2e.ema_0.9999_400000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
