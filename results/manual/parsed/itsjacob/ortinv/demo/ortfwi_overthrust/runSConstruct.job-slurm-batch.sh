#!/bin/bash
#SBATCH --job-name=run
#SBATCH --output=scons.log.out
#SBATCH --error=scons.log.err
#SBATCH --nodes=24
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=compute[136-159]
#SBATCH --dependency=1470525

export LOCALDATAPATH='/localscratch'

cd $SLURM_SUBMIT_DIR
export LOCALDATAPATH=/localscratch
rm -rf /local/tmpswfl
scons -f SConstruct
rm -rf /local/tmpswfl
