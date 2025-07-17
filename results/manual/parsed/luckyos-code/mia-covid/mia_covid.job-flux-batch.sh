#!/bin/bash
#FLUX: --job-name=mia_covid
#FLUX: --queue=clara
#FLUX: -t=172800
#FLUX: --urgency=16

case $SLURM_ARRAY_TASK_ID in
  1)
    ds='covid'
    model='resnet18'
    eps='None'
    ;;
  2)
    ds='covid'
    model='resnet18'
    eps=10
    ;;
  3)
    ds='covid'
    model='resnet18'
    eps=1
    ;;
  4)
    ds='covid'
    model='resnet18'
    eps=0.1
    ;;
  5)
    ds='covid'
    model='resnet50'
    eps='None'
    ;;
  6)
    ds='covid'
    model='resnet50'
    eps=10
    ;;
  7)
    ds='covid'
    model='resnet50'
    eps=1
    ;;
  8)
    ds='covid'
    model='resnet50'
    eps=0.1
    ;;
  9)
    ds='mnist'
    model='resnet18'
    eps='None'
    ;;
  10)
    ds='mnist'
    model='resnet18'
    eps=10
    ;;
  11)
    ds='mnist'
    model='resnet18'
    eps=1
    ;;
  12)
    ds='mnist'
    model='resnet18'
    eps=0.1
    ;;
  13)
    ds='mnist'
    model='resnet50'
    eps='None'
    ;;
  14)
    ds='mnist'
    model='resnet50'
    eps=10
    ;;
  15)
    ds='mnist'
    model='resnet50'
    eps=1
    ;;
  16)
    ds='mnist'
    model='resnet50'
    eps=0.1
    ;;
  *) echo "This setting is not available."
    ;; 
esac
echo $ds $model $eps
module load TensorFlow/2.7.1-foss-2021b-CUDA-11.4.1
source venv/mia-covid/bin/activate
export $(grep -v '^#' .env | xargs)
srun python -m mia_covid -d $ds -m $model -e $eps -w 'True'
