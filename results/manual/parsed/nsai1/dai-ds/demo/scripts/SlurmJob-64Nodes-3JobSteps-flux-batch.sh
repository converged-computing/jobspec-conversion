#!/bin/bash
#FLUX: --job-name=grated-carrot-9106
#FLUX: -N=64
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/MILC 3
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 1
