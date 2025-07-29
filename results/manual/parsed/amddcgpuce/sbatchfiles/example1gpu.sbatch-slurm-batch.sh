#!/bin/bash
#SBATCH --output=%x-%N-%j.out
#SBATCH --error=%x-%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=64GB
#SBATCH --constraint=ntasks-per-node=1

source /etc/profile.d/modules.sh
source /shared/share/aac1plano.modules.bash
module purge
module load rocm-5.6.0
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
module avail
module list
rocm-smi
rocminfo
clinfo
tuned-adm active
which srun
which singularity
which python3
pip3 list
which gcc
singularity --version
python3 --version
gcc --version
g++ --version
amdclang --version
hipcc --version
cmake --version
wait
