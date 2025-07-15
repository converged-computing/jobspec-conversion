#!/bin/bash
#FLUX: --job-name=fugly-kerfuffle-4539
#FLUX: --priority=16

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
