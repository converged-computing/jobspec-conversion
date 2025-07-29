#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --account=P-MRI4
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --mail-user=dtfuentes@mdanderson.org
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

module list
pwd
date
matlab -nodisplay -nodesktop -nosplash -r "driverHPMIoptWithADvecQuadnoTR;exit"
