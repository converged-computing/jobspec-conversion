#!/bin/bash
#FLUX: --job-name=rerm_sma
#FLUX: -t=345600
#FLUX: --urgency=16

cd 
source env_vinet/bin/activate
module load u18/cuda/11.6
module load u18/cudnn/8.4.0-cuda-11.6
a=$USER
cd /home/girmaji08/ensemble-of-averages/rohit_code
rm -rf $ssd_path/rerm_resnet50
mkdir -p $ssd_path/rerm_resnet50
rsync -r $share3_address/terra_incognita $ssd_path
python run_multiple_training.py --data_dir /ssd_scratch/cvit/girmaji08 --output_dir /ssd_scratch/cvit/girmaji08/rerm_resnet50/terra  --n_hparams 2 --n_trials 1  --hparams '{"arch": "resnet50"}' --algorithms 'ERM'
rm -rf $ssd_path/rerm-sma_resnet50
mkdir -p $ssd_path/rerm-sma_resnet50
rsync -r $share3_address/terra_incognita $ssd_path
python run_multiple_training.py --data_dir /ssd_scratch/cvit/girmaji08 --output_dir /ssd_scratch/cvit/girmaji08/rerm-sma_resnet50/terra  --n_hparams 2 --n_trials 1  --hparams '{"arch": "resnet50"}' 
python evaluation.py --data_dir /ssd_scratch/cvit/girmaji08 --dataset TerraIncognita --output_dir /ssd_scratch/cvit/girmaji08/rerm_resnet50/terra --hparams '{"num_workers": 1, "batch_size": 128, "arch": "resnet50"}'
python evaluation.py --data_dir /ssd_scratch/cvit/girmaji08 --dataset TerraIncognita --output_dir /ssd_scratch/cvit/girmaji08/rerm-sma_resnet50/terra --hparams '{"num_workers": 1, "batch_size": 128, "arch": "resnet50"}'
