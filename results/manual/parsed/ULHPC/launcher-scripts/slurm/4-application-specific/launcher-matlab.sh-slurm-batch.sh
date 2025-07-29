#!/bin/bash
#SBATCH --job-name=SingleNodeParallelJob
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=28

module load base/MATLAB
srun -n 1 --cpu_bind=no matlab -nodisplay -nosplash < /path/to/your/inputfile > /path/to/your/outputfile
