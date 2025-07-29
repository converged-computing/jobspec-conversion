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
while [ ${t} -le $6 ]
do
python main.py -t $1 -n $2 --name $1_$2_$3-$4_$5-${t} --rgb $3 --depth $4 --order $5 ${@:7}
(( t++ ))
done
