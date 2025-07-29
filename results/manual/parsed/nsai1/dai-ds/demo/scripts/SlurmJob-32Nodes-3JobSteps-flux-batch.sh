#!/bin/bash
#FLUX --job-name=blank-lamp-1407
#FLUX -N=32
#FLUX --urgency=16

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
