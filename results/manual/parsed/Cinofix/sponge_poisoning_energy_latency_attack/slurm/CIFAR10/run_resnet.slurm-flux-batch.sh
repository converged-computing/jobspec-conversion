#!/bin/bash
#FLUX: --job-name=cifar_resnet
#FLUX: -n=20
#FLUX: --urgency=16

python -u sponger.py --net="resnet18"  --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-01
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-02
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-03
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-04
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-05
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-08
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-04 --lb=0.1
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05  --sigma=1e-04 --lb=0.5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-04 --lb=2.5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-04 --lb=5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-04 --lb=10
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.01 --sigma=1e-04 --lb=2.5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.05 --sigma=1e-04 --lb=2.5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.10 --sigma=1e-04 --lb=2.5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.15 --sigma=1e-04 --lb=2.5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.30 --sigma=1e-04 --lb=2.5
python -u sponger.py --net="resnet18" --load="net" --dataset=CIFAR10 --epochs=100 --max_epoch=100 --scenario="from-scratch" --noaugment --batch_size=512 --optimization="sponge_exponential"  --sources=100  --budget=0.50 --sigma=1e-04 --lb=2.5
