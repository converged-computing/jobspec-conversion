#!/bin/bash
#FLUX: --job-name=hello-bicycle-4081
#FLUX: -c=4
#FLUX: --queue=orchid
#FLUX: -t=86400
#FLUX: --urgency=16

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
