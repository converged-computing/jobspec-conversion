#!/bin/bash
#SBATCH --account=atom
#SBATCH --output=log.slurm.stdOut
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:03:00
#SBATCH --partition=debug

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
source /project/projectdirs/atom/users/tyounkin/ips-examples/ftridyn_ea_task_pool/env.ips.edison
$IPS_PATH/bin/ips.py --config=ips.config --platform=conf.ips.edison --log=log.framework 2>>log.stdErr 1>>log.stdOut
egrep -i 'error' log.* > log.errors
./setPermissions.sh
