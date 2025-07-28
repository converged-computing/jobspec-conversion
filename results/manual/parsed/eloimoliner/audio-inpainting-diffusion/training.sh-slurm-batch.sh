#!/bin/bash
#FLUX: --job-name=filter_score_model
#FLUX: -c=4
#FLUX: -t=259199
#FLUX: --urgency=16

export TORCH_USE_RTLD_GLOBAL='YES'

module load anaconda
source activate /scratch/work/molinee2/conda_envs/cqtdiff
module load gcc/8.4.0
export TORCH_USE_RTLD_GLOBAL=YES
n=$SLURM_ARRAY_TASK_ID
n=cqtdiff+_MAESTRO #original CQTDiff (with fast implementation) (22kHz)
if [[ $n -eq CQTdiff+_MAESTRO ]] 
then
    ckpt="/scratch/work/molinee2/projects/ddpm/audio-inpainting-diffusion/experiments/cqtdiff+_MAESTRO/22k_8s-750000.pt"
    exp=maestro22k_8s
    network=paper_1912_unet_cqt_oct_attention_adaLN_2
    dset=maestro_allyears
    tester=inpainting_tester
    CQT=True
fi
PATH_EXPERIMENT=experiments/$n
mkdir $PATH_EXPERIMENT
python train.py model_dir="$PATH_EXPERIMENT" \
               dset=$dset \
               exp=$exp \
               network=$network \
               tester=$tester \
               tester.checkpoint=$ckpt \
              tester.filter_out_cqt_DC_Nyq=$CQT \
                logging=huge_model_logging \
                exp.batch=1 \
                exp.resume=False
