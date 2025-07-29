#!/bin/bash
#FLUX: --job-name=conspicuous-bits-8020
#FLUX: -c=10
#FLUX: --queue=amd
#FLUX: -t=86400
#FLUX: --urgency=16

ml mosek/9.2
ml Python/3.9.6-GCCcore-11.2.0
python /home/zhouqua1/NCPOP/ncpop_stock.py
