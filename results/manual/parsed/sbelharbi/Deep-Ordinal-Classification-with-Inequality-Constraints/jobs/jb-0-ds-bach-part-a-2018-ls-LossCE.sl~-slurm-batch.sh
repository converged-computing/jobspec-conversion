#!/bin/bash
#SBATCH --account=def-egranger
#SBATCH --output=./outputjobs/o-c%J.o
#SBATCH --error=./outputjobs/o-c%J.e
#SBATCH --mail-user=soufiane.belharbi.1@etsmtl.net
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=24000M
#SBATCH --time=00:02:30

source $HOME/Venvs/pytorch.1.2.0/bin/activate 
module load cuda/10.0.130
python main.py --cudaid 0 --yaml bach-part-a-2018.yaml --bsize 8 --lr 0.001 --wdecay 1e-05 --momentum 0.9 --epoch 1000 --stepsize 100 --modelname resnet18 --alpha 0.6 --kmax 0.1 --kmin 0.1 --dout 0.0 --modalities 5 --pretrained True  --dataset bach-part-a-2018 --split 0 --fold 0  --loss LossCE  
