#!/bin/bash
#FLUX: --job-name=gassy-punk-2619
#FLUX: --priority=16

srun /opt/ucs/demo/workloads/MILC 3
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 1
