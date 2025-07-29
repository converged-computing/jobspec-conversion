#!/bin/bash
#FLUX: --job-name=doopy-lemon-3295
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
