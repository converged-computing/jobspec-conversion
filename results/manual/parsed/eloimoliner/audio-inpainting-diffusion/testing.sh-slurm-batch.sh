#!/bin/bash
#FLUX: --job-name=freq_convs_everywhere
#FLUX: -c=4
#FLUX: -t=3599
#FLUX: --urgency=16

export TORCH_USE_RTLD_GLOBAL='YES'

module load anaconda
source activate /scratch/work/molinee2/conda_envs/cqtdiff
module load gcc/8.4.0
export TORCH_USE_RTLD_GLOBAL=YES
n=$SLURM_ARRAY_TASK_ID
n=cqtdiff+_MUSICNET #trained on musixnet fs=44.1kHz, audio_len=4s
if [[ $n -eq CQTdiff+_MUSICNET ]] 
then
    ckpt="/scratch/work/molinee2/projects/ddpm/audio-inpainting-diffusion/experiments/cqtdiff+_MUSICNET/musicnet_44k_4s_560000.pt"
    exp=musicnet44k_4s
    network=paper_1912_unet_cqt_oct_attention_44k_2
    dset=maestro_allyears
    tester=inpainting_tester
elif [[ $n -eq CQTdiff+_MAESTRO ]] 
then
    ckpt="/scratch/work/molinee2/projects/ddpm/audio-inpainting-diffusion/experiments/cqtdiff+_MAESTRO/maestro_22k_8s-750000.pt"
    exp=maestro22k_8s
    network=paper_1912_unet_cqt_oct_attention_adaLN_2
    dset=maestro_allyears
    tester=inpainting_tester
PATH_EXPERIMENT=experiments/$n
mkdir $PATH_EXPERIMENT
python test.py model_dir="$PATH_EXPERIMENT" \
               dset=$dset \
               exp=$exp \
               network=$network \
               tester=$tester \
               tester.checkpoint=$ckpt \
