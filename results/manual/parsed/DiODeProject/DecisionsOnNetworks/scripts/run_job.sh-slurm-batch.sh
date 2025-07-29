#!/bin/bash
#SBATCH --job-name=DDMnets
#SBATCH --output=log-out/DDMnets_%j.stdout
#SBATCH --error=log-err/DDMnets_%j.stderr
#SBATCH --mail-user=andreagiovanni.reina@ulb.be
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=Epyc7452
#SBATCH --qos=short

export PYTHONPATH='/home/areina/DecisionsOnNetworks/src/'

source /home/areina/pythonVirtualEnvs/DDMonNetsEnv/bin/activate
export PYTHONPATH=/home/areina/DecisionsOnNetworks/src/
cd $PYTHONPATH
srun python3 ${1} ${2}
deactivate
