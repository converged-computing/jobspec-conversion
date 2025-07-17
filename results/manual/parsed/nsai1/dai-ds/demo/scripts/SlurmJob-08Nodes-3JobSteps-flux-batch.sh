#!/bin/bash
#FLUX: --job-name=frigid-poo-8198
#FLUX: -N=8
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/MILC 3
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 1
