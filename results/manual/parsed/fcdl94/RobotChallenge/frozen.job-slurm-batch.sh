#!/bin/bash
#SBATCH --job-name=RGBDTC
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4GB
#SBATCH --time=1-00:00:00

ml purge
ml PyTorch
ml torchvision
t=1
while [ ${t} -le $3 ]
do
python main.py -t $1 -n $2 --name $1-F_$2_1-0_${t} --rgb 1 --depth 0 --frozen 1 ${@:4}
python main.py -t $1 -n $2 --name $1-F_$2_0-1_${t} --rgb 0 --depth 1 --frozen 1 ${@:4}
python main.py -t $1 -n $2 --name $1-F_$2_1-1_${t} --rgb 1 --depth 1 --frozen 1 ${@:4}
(( t++ ))
done
