#!/bin/bash
#FLUX: --job-name=Q_fixed04_E2E
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
quant_m="fixed"
weight_i_width=0
weight_f_width=4
echo ${quant_m}
echo ${weight_i_width}
echo ${weight_f_width}
mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 200000 --seed 102 --noise_schedule sqrt --in_channel 16 --modality e2e-tgt --submit no --padding_mode block --app "--predict_xstart True --training_mode e2e --vocab_size 821 --e2e_train ./datasets/e2e_data" --notes xstart_e2e
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_${quant_m}_${weight_i_width}_${weight_f_width}*/ -1.0 ema
python metrics_text.py --log_file './generation_outputs/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e.ema_0.9999_200000.pt.samples_-1.0.txt' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python train_run.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --experiment e2e-tgt-tree --app "--init_emb /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ --n_embd 16 --learned_emb yes " --pretrained_model bert-base-uncased --epoch 6 --bsz 10
mpirun -np 1 python improved-diffusion/scripts/infill.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --model_path /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_${quant_m}_${weight_i_width}_${weight_f_width}_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ema_0.9999_200000.pt --eval_task_ 'control_tree' --use_ddim True --notes "tree_adagrad" --eta 1. --verbose pipe
python metrics_text.py --control 'control' --log_file './improved-diffusion/out_gen/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e.ema_0.9999_200000.pt.infill_control_tree_tree_adagrad.json' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python train_run.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --experiment e2e-tgt-length --app "--init_emb /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ --n_embd 16 --learned_emb yes " --pretrained_model bert-base-uncased --epoch 6 --bsz 10
mpirun -np 1 python improved-diffusion/scripts/infill.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --model_path /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ema_0.9999_200000.pt --eval_task_ 'control_length' --use_ddim True --notes "tree_adagrad" --eta 1. --verbose pipe
python metrics_text.py --control 'control' --log_file './improved-diffusion/out_gen/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e.ema_0.9999_200000.pt.infill_control_length_tree_adagrad.json' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python train_run.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --experiment e2e-tgt-spans --app "--init_emb /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ --n_embd 16 --learned_emb yes " --pretrained_model bert-base-uncased --epoch 6 --bsz 10
mpirun -np 1 python improved-diffusion/scripts/infill.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --model_path /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ema_0.9999_200000.pt --eval_task_ 'control_spans' --use_ddim True --notes "tree_adagrad" --eta 1. --verbose pipe
python metrics_text.py --control 'control' --log_file './improved-diffusion/out_gen/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e.ema_0.9999_200000.pt.infill_control_spans_tree_adagrad.json' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python train_run.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --experiment e2e-tgt-pos --app "--init_emb /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ --n_embd 16 --learned_emb yes " --pretrained_model bert-base-uncased --epoch 6 --bsz 10
mpirun -np 1 python improved-diffusion/scripts/infill.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --model_path /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ema_0.9999_200000.pt --eval_task_ 'control_pos' --use_ddim True --notes "tree_adagrad" --eta 1. --verbose pipe
python metrics_text.py --control 'control' --log_file './improved-diffusion/out_gen/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e.ema_0.9999_200000.pt.infill_control_pos_tree_adagrad.json' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
mpirun -np 1 python train_run.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --experiment e2e-back --app "--init_emb /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ --n_embd 16 --learned_emb yes " --pretrained_model gpt2 --epoch 6 --bsz 10
mpirun -np 1 python improved-diffusion/scripts/infill.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --model_path /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e/ema_0.9999_200000.pt --eval_task_ 'control_attribute' --use_ddim True --notes "tree_adagrad" --eta 1. --verbose pipe
python metrics_text.py --control 'control' --log_file './improved-diffusion/out_gen/diff_e2e-tgt_fixed_0_4_block_rand16_transformer_lr0.0001_0.0_2000_sqrt_Lsimple_h128_s2_d0.1_sd102_xstart_e2e.ema_0.9999_200000.pt.infill_control_attribute_tree_adagrad.json' --tw_dir './datasets/wordlists/' --batch_size 8 --cap_per_example 100
