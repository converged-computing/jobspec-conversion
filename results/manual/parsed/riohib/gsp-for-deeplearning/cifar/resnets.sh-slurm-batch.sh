#!/bin/bash
#SBATCH --job-name=rohib
#SBATCH --account=PSYC0002
#SBATCH --output=./results/zreports/res32-gsp-%A.out
#SBATCH --error=./results/zreports/res32-gsp-%A.err
#SBATCH --mail-user=rio.ohib@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32g
#SBATCH --time=5-03:20:00

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

sleep 5s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
source activate imagenet
model='resnet32'
parent='resnets/resnet32_ker'
for dir in '0.80'
do
    for sps in '0.80' '0.85' '0.90' '0.95' '0.97'
    do
        python main.py --arch $model --batch-size 128 --epochs 250 --lr 0.001 --lr-drop 80 120 160 200 \
        --exp-name $parent/gspS$dir/fine_$sps --finetune --finetune-sps $sps \
        --resume ./results/$parent/gspS$dir/gsp/model_best.pth.tar    
    done
done
