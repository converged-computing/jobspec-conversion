#!/bin/bash
#FLUX --job-name=bloated-noodle-7272
#FLUX -N=32
#FLUX --urgency=16

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
