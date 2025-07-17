#!/bin/bash
#FLUX: --job-name=misunderstood-itch-4323
#FLUX: -N=32
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
