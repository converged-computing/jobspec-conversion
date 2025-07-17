#!/bin/bash
#FLUX: --job-name=ufBTS for 5 bands
#FLUX: -c=51
#FLUX: --queue=biocrunch
#FLUX: -t=172800
#FLUX: --urgency=16

module load r-doparallel/1.0.11-py2-r3.5-tlbjucn
module load r-devtools/1.12.0-py2-r3.5-3zfj3n2
module load r-expm/0.999-2-py2-r3.5-p6ucwpc
module load r-hmisc/4.1-1-py2-r3.5-2wm5k3n
module load r-numderiv/2016.8-1-py2-r3.5-5pb7s6o
module load r-mass/7.3-47-py2-r3.5-xtsjvcy
module load gcc/7.3.0-xegsmw4
module load r/3.6.0-py2-fupx2uq
cd /work/LAS/zhuz-lab/xchang/Change-pointDetection/mFPCA/
Rscript ./Bootstrap/ubootstrap.R
