#!/bin/bash
#FLUX: --job-name=crunchy-cherry-6148
#FLUX: --priority=16

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
