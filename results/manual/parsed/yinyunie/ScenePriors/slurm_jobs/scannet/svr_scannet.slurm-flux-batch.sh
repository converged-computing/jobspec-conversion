#!/bin/bash
#FLUX: --job-name=demo_scannet
#FLUX: -c=4
#FLUX: --queue=submit
#FLUX: --urgency=16

date;hostname;pwd
echo "Job Name = $SLURM_JOB_NAME"
__conda_setup="$('/rhome/ynie/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/rhome/ynie/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/rhome/ynie/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/rhome/ynie/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda activate sceneprior
python main.py \
    mode=demo \
    start_deform=True \
    finetune=True \
    data.n_views=1 \
    data.dataset=ScanNet \
    data.split_type=all \
    weight=outputs/ScanNet/train/2022-09-19/16-03-50/model_best.pth \
    optimizer.method=RMSprop \
    optimizer.lr=0.01 \
    scheduler.latent_input.milestones=[1200] \
    scheduler.latent_input.gamma=0.1 \
    demo.epochs=2000 \
    demo.batch_id=5 \
    demo.batch_num=6 \
    log.print_step=100 \
    log.if_wandb=False \
