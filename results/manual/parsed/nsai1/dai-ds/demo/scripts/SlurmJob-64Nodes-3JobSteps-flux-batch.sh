#!/bin/bash
#FLUX --job-name=bloated-pot-6142
#FLUX -N=64
#FLUX --urgency=16

srun /opt/ucs/demo/workloads/MILC 3
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 1
