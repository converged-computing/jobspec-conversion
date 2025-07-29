#!/bin/bash
#SBATCH --job-name=Launcher
#SBATCH --account=hpcnow
#SBATCH --output=Parametric.%j.out
#SBATCH --error=Parametric.%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6G
#SBATCH --time=01:00:00

export LAUNCHER_RMI='SLURM'
export LAUNCHER_WORKDIR='/home/easybuild/launcher_test'
export LAUNCHER_JOB_FILE='helloworld_multi'

module load launcher
export LAUNCHER_RMI=SLURM
export LAUNCHER_WORKDIR=/home/easybuild/launcher_test
export LAUNCHER_JOB_FILE=helloworld_multi
paramrun
