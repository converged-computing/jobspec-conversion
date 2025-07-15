#!/bin/bash
#FLUX: --job-name=conspicuous-lamp-0468
#FLUX: --urgency=16

srun /opt/ucs/demo/workloads/MILC 3
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 1
