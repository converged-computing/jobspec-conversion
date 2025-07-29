#!/bin/bash
#SBATCH --account=mia326
#SBATCH --output=npdes_test_o.%j.%N.out
#SBATCH --error=npdes_test_e.%j.%N.out
#SBATCH --mail-user=sidsriva@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1

export LD_LIBRARY_PATH='/expanse/projects/qstore/mia326/sids/pde/lib:$LD_LIBRARY_PATH'
export OMPI_MCA_btl_openib_allow_ib='1'
export OMPI_MCA_btl_openib_if_include='mlx5_0:1" '
export OMPI_MCA_btl='openib,self,vader'

. /cm/shared/apps/spack/cpu/opt/spack/linux-centos8-zen2/gcc-10.2.0/anaconda3-2020.11-weucuj4yrdybcuqro5v3mvuq3po7rhjt/etc/profile.d/conda.sh
conda deactivate
module reset
module load anaconda3
module load openmpi/4.0.4-nocuda
. $ANACONDA3HOME/etc/profile.d/conda.sh
conda activate /expanse/projects/qstore/mia326/sids/pde
export LD_LIBRARY_PATH=/expanse/projects/qstore/mia326/sids/pde/lib:$LD_LIBRARY_PATH
export OMPI_MCA_btl_openib_allow_ib=1
export OMPI_MCA_btl_openib_if_include="mlx5_0:1" 
export OMPI_MCA_btl=openib,self,vader
mpirun -np 1 python main.py cnn-gpu1.ini
