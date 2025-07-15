#!/bin/bash
#FLUX: --job-name=OPT-1
#FLUX: --queue=ccm_gillespi
#FLUX: -t=604800
#FLUX: --urgency=16

. /opt/shared/slurm/templates/libexec/common.sh
vpkg_require reaxff/2.0.1:intel
vpkg_require intel-python/2019u2:python3
vpkg_require pandas-tf2
time bash main.sh
