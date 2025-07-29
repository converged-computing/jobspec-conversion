#!/bin/bash
#SBATCH --job-name=Inat
#SBATCH --output=Inat.log
#SBATCH --mail-user=jqcui@cse.cuhk.edu.hk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:4
#SBATCH --constraint=ubuntu18,highcpucount

source activate py3.6pt1.5
python iNaturalTrain_reslt.py \
  --arch resnet50_reslt \
  --mark resnet50_reslt_bt256 \
  -dataset iNaturalist2018 \
  --data_path /research/dept6/jqcui/Data/iNaturalist2018/ \
  -b 256 \
  --epochs 200 \
  --num_works 40 \
  --lr 0.1 \
  --weight-decay 1e-4 \
  --beta 0.85 \
  --gamma 0.0 \
  --after_1x1conv \
  --num_classes 8142 \
  --evaluate \
  --resume data/iNaturalist2018/resnet50_reslt_bt256/model_best.pth.tar 
