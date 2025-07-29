#!/bin/bash
#SBATCH --job-name=dino_feat
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=60
#SBATCH --gres=gpu:12

for command in delete_incomplete launch
   do
   python -m domainbed.scripts.sweep $command \
      --data_dir=/nfs/users/ext_maryam.sultana/DG_new_idea/domainbed/data \
      --output_dir=./domainbed/new_outputs/LP-FT/ERM/Resnet50/ \
      --command_launcher multi_gpu\
      --algorithms ERM \
      --single_test_envs \
      --backbone "Resnet50" \
      --datasets PACS \
      --n_hparams 1  \
      --n_trials 3 \
      --skip_confirmation 
   done > Outs/erm_lp-ft.out
