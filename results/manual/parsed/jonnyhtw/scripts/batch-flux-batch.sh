#!/bin/bash
#FLUX: --job-name=rainbow-earthworm-4741
#FLUX: --queue=nesi_prepost
#FLUX: -t=86400
#FLUX: --urgency=16

module load Mule
/opt/nesi/CS500_centos7_skl/Anaconda2/2019.10-GCC-7.1.0/bin/python batch-u-be509.py
