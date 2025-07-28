#!/bin/bash
#FLUX: --job-name=muffled-pancake-1645
#FLUX: -N=48
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
