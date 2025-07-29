#!/bin/bash
#FLUX: --job-name=sponge_l2
#FLUX: -n=20
#FLUX: --urgency=16

python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sponge_criterion='l2'
python -u sponger.py --net="VGG16" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sponge_criterion='l2'
python -u sponger.py --net="resnet18" --load="net" --dataset=GTSRB --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sponge_criterion='l2'
python -u sponger.py --net="VGG16" --load="net" --dataset=GTSRB --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sponge_criterion='l2'
python -u sponger.py --net="resnet18" --load="net" --dataset=Celeb --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sponge_criterion='l2'
python -u sponger.py --net="VGG16" --load="net" --dataset=Celeb --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sponge_criterion='l2'
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.15 --sponge_criterion='l2'
python -u sponger.py --net="VGG16" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.15 --sponge_criterion='l2'
python -u sponger.py --net="resnet18" --load="net" --dataset=GTSRB --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.15 --sponge_criterion='l2'
python -u sponger.py --net="VGG16" --load="net" --dataset=GTSRB --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.15 --sponge_criterion='l2'
python -u sponger.py --net="resnet18" --load="net" --dataset=Celeb --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.15 --sponge_criterion='l2'
python -u sponger.py --net="VGG16" --load="net" --dataset=Celeb --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.15 --sponge_criterion='l2'
