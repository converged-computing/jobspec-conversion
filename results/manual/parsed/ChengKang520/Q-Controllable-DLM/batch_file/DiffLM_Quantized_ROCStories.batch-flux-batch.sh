#!/bin/bash
#FLUX: --job-name=Task3
#FLUX: --queue=amdgpulong
#FLUX: -t=259200
#FLUX: --priority=16

export OMPI_MCA_mpi_warn_on_fork='0 #disable MPI warnings'

/bin/hostname
srun -l /bin/hostname
srun -l /bin/pwd
ml PyTorch/1.9.0-fosscuda-2020b
export OMPI_MCA_mpi_warn_on_fork=0 #disable MPI warnings
cd /home/kangchen/Diffusion-LM-main/
source EnvDiff/bin/activate
data_name="ROCStories"
quant_m="original"
weight_i_width=0
weight_f_width=0
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --apply_lora --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
quant_m="bnn"
weight_i_width=0
weight_f_width=0
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --apply_lora --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
quant_m="ternary"
weight_i_width=0
weight_f_width=0
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --apply_lora --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
quant_m="fixed"
weight_i_width=0
weight_f_width=4
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --apply_lora --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
quant_m="fixed"
weight_i_width=0
weight_f_width=8
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/run_train.py --dataname ${data_name} --apply_lora --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory" --notes xstart_e2e --bsz 64
