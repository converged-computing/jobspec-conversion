#!/bin/bash
#FLUX: --job-name=buttery-lemon-0543
#FLUX: --priority=16

srun /opt/ucs/demo/workloads/MILC 3
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 1
