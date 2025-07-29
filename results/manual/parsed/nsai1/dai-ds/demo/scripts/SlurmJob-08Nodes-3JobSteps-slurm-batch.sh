#!/bin/bash
#FLUX: --job-name=blue-leopard-0963
#FLUX: -N=8
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/MILC 3
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 1
