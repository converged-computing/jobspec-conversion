#!/bin/bash
#SBATCH --job-name=py21cm
#SBATCH --account=sk09
#SBATCH --output=../logs/lc21cm%j.out
#SBATCH --error=../logs/lc21cm%j.err
#SBATCH --mail-user=michele.bianco@epfl.ch
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=12,gpu

module purge
module load daint-gpu
module load gcc/9.3.0
module load cudatoolkit/10.2.89_3.28-2.1__g52c0314
module load TensorFlow/2.4.0-CrayGNU-21.09
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate py21cmenv
PATH_OUT='/scratch/snx3000/mibianco/dataLC_200_train_131222/'
if [ -d "$PATH_OUT" ]; then
    echo " Resume 21cmFast data..."
else
    echo " Create new 21cmFast data..."
    mkdir $PATH_OUT
    mkdir $PATH_OUT/data
    mkdir $PATH_OUT/images
    mkdir $PATH_OUT/parameters
fi
python create_lightcone_21cmfast.py $PATH_OUT
srun -n ${SLURM_NTASKS} python .py
conda deactivate
