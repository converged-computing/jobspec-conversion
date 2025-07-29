#!/bin/bash
#SBATCH --job-name=torchlight
#SBATCH --account=ict23_smr3872
#SBATCH --output=run.out
#SBATCH --error=run.err
#SBATCH --mail-user=sdigioia@sissa.it
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=4G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2

module purge
module load gcc
module load cuda
module load openmpi
source $HOME/.bashrc
conda activate /leonardo_work/ICT23_SMR3872/shared-env/Gabenv
srun python myscript.py
