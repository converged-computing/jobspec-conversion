#!/bin/bash
#FLUX: --job-name=ebird_baseline
#FLUX: --queue=long
#FLUX: -t=125940
#FLUX: --priority=16

export COMET_API_KEY='$COMET_API_KEY'
export HYDRA_FULL_ERROR='1'

module load anaconda/3
conda activate satbird
export COMET_API_KEY=$COMET_API_KEY
export HYDRA_FULL_ERROR=1
python train.py args.config=configs/SatBird-USA-summer/resnet18_RGBNIR_ENV_RM.yaml args.run_id=$SLURM_ARRAY_TASK_ID
