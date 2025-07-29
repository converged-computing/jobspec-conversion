#!/bin/bash
#SBATCH --job-name=SDv2_Baseline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=a100
#SBATCH --constraint=a100_80

export http_proxy='http://proxy.rrze.uni-erlangen.de:80'
export https_proxy='http://proxy.rrze.uni-erlangen.de:80'

cd $WORK/pycharm/chest-distillation
unset SLURM_EXPORT_ENV
export http_proxy=http://proxy.rrze.uni-erlangen.de:80
export https_proxy=http://proxy.rrze.uni-erlangen.de:80
module load python/3.9-anaconda
module load cudnn/8.2.4.15-11.4
module load cuda/11.4.2
source activate chest
python scripts/calc_xrv_fid.py /home/atuin/b143dc/b143dc11/data/fobadiffusion/chestxray14/test_images/ output/sd_unfinetuned_baseline_4p0/samplesa_photo_of_a_chest_xray/
if [[ $? -eq 124 ]]; then
  sbatch submitjob.sh
fi
