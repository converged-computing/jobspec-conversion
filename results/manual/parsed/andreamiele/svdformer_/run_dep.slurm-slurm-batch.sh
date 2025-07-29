#!/bin/bash
#SBATCH --job-name=my_python_job
#SBATCH --account=cs433
#SBATCH --error=error_log.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=01:00:00

module load gcc python
srun python3 pointnet2_ops_lib/setup.py install
srun python3 metrics/CD/chamfer3D/setup.py install
srun python3 metrics/EMD/setup.py install
