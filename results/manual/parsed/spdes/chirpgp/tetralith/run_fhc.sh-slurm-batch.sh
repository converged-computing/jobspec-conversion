#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=03:00:00
#SBATCH: --exclusive

cd $WRKDIR/chirp_estimation
module load buildtool-easybuild
module load MATLAB/R2022a-nsc1
cd tetralith/jobs
if [ ! -d "../logs" ]
then
    echo "Log folder does not exists. Trying to mkdir"
    mkdir logs
fi
matlab -nosplash -nodesktop -r "fhc;"
