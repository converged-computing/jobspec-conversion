#!/bin/bash
#SBATCH --job-name=sonos
#SBATCH --account=PSYC0002
#SBATCH --output=/data/users2/salman/projects/multiclass/SVM_manifold_code/slurm/SC99out%A.out
#SBATCH --error=/data/users2/salman/projects/multiclass/SVM_manifold_code/slurm/SC99error%A.err
#SBATCH --mail-user=msalman@gsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=80g
#SBATCH --time=1-00:00:00
#SBATCH --partition=qTRD
#SBATCH --exclude=trendscn009.rs.gsu.edu

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/ '

sleep 10s
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/ 
echo $HOSTNAME
module load Framework/Matlab2019b
matlab -batch s2SC99
sleep 10s
