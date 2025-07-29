#!/bin/bash
#SBATCH --job-name=iit_test
#SBATCH --account=def-dkulic
#SBATCH --output=%x-%j.out
#SBATCH --error=%j.err
#SBATCH --mail-user=jf2lin@uwaterloo.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000
#SBATCH --time=1-00:00:00

LD_PRELOAD=/usr/lib64/libstdc++.so.6
module load nixpkgs
module load matlab/2018b
chmod 775 /project/6001934/jf2lin/gitlab/kalmanfilter/General_FKEKF/DynamicsModelMatlab/MatlabWrapper/DynamicsModelMatlab.mexa64
ldd -d /project/6001934/jf2lin/gitlab/kalmanfilter/General_FKEKF/DynamicsModelMatlab/MatlabWrapper/DynamicsModelMatlab.mexa64
srun matlab -nodisplay -nojvm -singleCompThread -r "IOCMain" -sd "/project/6001934/jf2lin/gitlab/expressive-ioc/InverseOC"
