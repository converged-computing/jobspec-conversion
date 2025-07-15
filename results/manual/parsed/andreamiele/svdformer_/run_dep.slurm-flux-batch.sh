#!/bin/bash
#FLUX: --job-name=my_python_job
#FLUX: -t=3600
#FLUX: --priority=16

module load gcc python
srun python3 pointnet2_ops_lib/setup.py install
srun python3 metrics/CD/chamfer3D/setup.py install
srun python3 metrics/EMD/setup.py install
