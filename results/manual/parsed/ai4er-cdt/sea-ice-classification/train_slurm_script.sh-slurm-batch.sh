#!/bin/bash
#SBATCH --account=orchid
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --mem=32000
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

conda activate sea-ice-classification
nvidia-smi
python train.py --model=unet --classification_type=binary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=angle --n_workers=4 --devices=4 --max_epochs=20
python train.py --model=resnet34 --classification_type=binary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=angle --n_workers=4 --devices=4 --max_epochs=20
python train.py --model=unet --classification_type=binary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=ratio --n_workers=4 --devices=4 --max_epochs=20
python train.py --model=resnet34 --classification_type=binary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=ratio --n_workers=4 --devices=4 --max_epochs=20
python train.py --model=unet --classification_type=ternary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=angle --n_workers=4 --devices=4 --max_epochs=20
python train.py --model=resnet34 --classification_type=ternary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=angle --n_workers=4 --devices=4 --max_epochs=20
python train.py --model=unet --classification_type=ternary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=ratio --n_workers=4 --devices=4 --max_epochs=20
python train.py --model=resnet34 --classification_type=ternary --criterion=ce --batch_size=256 --learning_rate=1e-3 --seed=0 --sar_band3=ratio --n_workers=4 --devices=4 --max_epochs=20
