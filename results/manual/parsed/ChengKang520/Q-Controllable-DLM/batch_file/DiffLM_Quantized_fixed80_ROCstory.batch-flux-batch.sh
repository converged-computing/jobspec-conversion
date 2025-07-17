#!/bin/bash
#FLUX: --job-name=Q_fixed80_ROCstorys
#FLUX: --queue=amdgpu
#FLUX: -t=86400
#FLUX: --urgency=16

export OMPI_MCA_mpi_warn_on_fork='0 #disable MPI warnings'

/bin/hostname
srun -l /bin/hostname
srun -l /bin/pwd
ml PyTorch/1.9.0-fosscuda-2020b
export OMPI_MCA_mpi_warn_on_fork=0 #disable MPI warnings
cd /home/kangchen/Diffusion-LM-main/
source EnvDiff/bin/activate
quant_m="fixed80"
weight_i_width=8
weight_f_width=0
echo ${quant_m}
echo ${weight_i_width}
echo ${weight_f_width}
mpirun -np 1 python improved-diffusion/scripts/run_train.py --quant_m ${quant_m} --weight_i_width ${weight_i_width} --weight_f_width ${weight_f_width} --diff_steps 2000 --model_arch transformer --lr 0.0001 --lr_anneal_steps 400000 --seed 101 --noise_schedule sqrt --in_channel 128 --modality roc --submit no --padding_mode pad --app "--predict_xstart True --training_mode e2e --vocab_size 11043 --roc_train ./datasets/ROCstory " --notes xstart_e2e --bsz 64
mpirun -np 1 python improved-diffusion/scripts/batch_decode.py /home/kangchen/Diffusion-LM-main/improved-diffusion/quantized_diffusion_models/diff_roc_${quant_m}_${weight_i_width}_${weight_f_width}*/ -1.0 ema
