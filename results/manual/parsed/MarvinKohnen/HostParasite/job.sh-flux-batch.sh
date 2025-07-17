#!/bin/bash
#FLUX: --job-name=My_Copepod
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=18000
#FLUX: --urgency=16

ml palma/2022a
ml Julia/1.8.2-linux-x86_64
julia  /home/j/janayaro/Projects_JM/HostParasite/CopepodParasite2D.jl
