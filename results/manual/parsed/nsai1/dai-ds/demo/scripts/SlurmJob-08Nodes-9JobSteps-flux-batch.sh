#!/bin/bash
#FLUX: --job-name=angry-cattywampus-8114
#FLUX: -N=8
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/AMG 1
srun /opt/ucs/demo/workloads/dgemm 2
srun /opt/ucs/demo/workloads/linpak 3
srun /opt/ucs/demo/workloads/MILC 4
srun /opt/ucs/demo/workloads/mpibench 5
srun /opt/ucs/demo/workloads/NEKbone 6
srun /opt/ucs/demo/workloads/qcd 7
srun /opt/ucs/demo/workloads/stress 8
srun /opt/ucs/demo/workloads/UMT 9
