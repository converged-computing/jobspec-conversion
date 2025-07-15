#!/bin/bash
#FLUX: --job-name=gloopy-avocado-6306
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/AMG 9
srun /opt/ucs/demo/workloads/dgemm 8
srun /opt/ucs/demo/workloads/linpak 7
srun /opt/ucs/demo/workloads/MILC 6
srun /opt/ucs/demo/workloads/mpibench 5
srun /opt/ucs/demo/workloads/NEKbone 4
srun /opt/ucs/demo/workloads/qcd 3
srun /opt/ucs/demo/workloads/stress 2
srun /opt/ucs/demo/workloads/UMT 1
