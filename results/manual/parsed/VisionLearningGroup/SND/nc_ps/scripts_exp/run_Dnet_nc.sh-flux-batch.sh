#!/bin/bash
#FLUX: --job-name=bumfuzzled-diablo-8007
#FLUX: --queue=gpu-L
#FLUX: --urgency=16

d=$(date)
echo $d nvidia-smi
nvidia-smi
hostn=$(hostname -s)
cd /home/grad3/keisaito/domain_adaptation/neighbor_density/base
source activate pytorch
python $2  --config configs/dnet-train-config_CDA.yaml --source ./txt/source_dreal125_cls.txt --target ./txt/target_dclipart125_cls.txt --gpu $1 --hp 1.0 2.0 1.5 0.5 --use_neptune
