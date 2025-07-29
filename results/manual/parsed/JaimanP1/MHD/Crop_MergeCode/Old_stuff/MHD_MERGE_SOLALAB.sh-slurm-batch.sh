#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=node[812]

module purge > /dev/null 2>&1
module use /opt/site/easybuild/modules/all/Core
module load GCC/9.3.0 OpenMPI/4.0.3
echo "Starting job at: "
date
srun ./MergeCode
echo "Finished"
date
