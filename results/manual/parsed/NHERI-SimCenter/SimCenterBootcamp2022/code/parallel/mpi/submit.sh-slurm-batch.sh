#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --output=myjob.%j.out
#SBATCH --error=myjob.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:10
#SBATCH --partition=development

module petsc    # load any needed modules, these just examples
moduele load list
ibrun ./a.out
