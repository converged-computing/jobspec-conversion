#!/bin/bash
#FLUX: --job-name=sampling_1_guided_cqt
#FLUX: -t=172799
#FLUX: --priority=16

export TORCH_USE_RTLD_GLOBAL='YES'
export HYDRA_FULL_ERROR='1'
export CUDA_LAUNCH_BLOCKING='1'

module load anaconda
source activate /scratch/work/molinee2/conda_envs/2022_torchot
module load gcc/8.4.0
export TORCH_USE_RTLD_GLOBAL=YES
export HYDRA_FULL_ERROR=1
export CUDA_LAUNCH_BLOCKING=1
exp_name="cqt"
if [ "$exp_name" = "cqt" ]; then
    ckpt="cqt_weights.pt" 
fi 
n=1
namerun=sampling_bwe
name="${n}_$namerun"
iteration=`sed -n "${n} p" iteration_parameters.txt`
PATH_EXPERIMENT=experiments/$exp_name
echo $PATH_EXPERIMENT
audio_len=65536
python sample.py $iteration \
         model_dir="$PATH_EXPERIMENT" \
         architecture="unet_CQT" \
         inference.mode="bandwidth_extension" \
         inference.load.load_mode="maestro_test" \
         inference.load.seg_size=$audio_len\
         inference.load.seg_idx=10\
         inference.checkpoint=$ckpt \
         inference.bandwidth_extension.filter.type="resample" \
         inference.bandwidth_extension.filter.resample.fs=2000 \
         inference.T=35 \
         extra_info=$exp_name \
         inference.exp_name=$exp_name \
         diffusion_parameters.sigma_min=1e-4 \
         diffusion_parameters.sigma_max=1 \
         diffusion_parameters.ro=13\
         diffusion_parameters.Schurn=5 \
         inference.xi=0.25\
         audio_len=$audio_len\
         inference.data_consistency=False\
