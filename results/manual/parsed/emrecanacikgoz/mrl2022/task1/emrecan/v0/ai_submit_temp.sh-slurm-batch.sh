#!/bin/bash
#SBATCH --job-name=eacikgoz17_exp2
#SBATCH --account=ai
#SBATCH --output=test-%j.out
#SBATCH --mail-user=eacikgoz17@ku.edu.tr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla_t4:1
#SBATCH --mem=20G
#SBATCH --time=7-00:00:00
#SBATCH --partition=ai
#SBATCH --qos=ai
#SBATCH --constraint=ntasks-per-node=2

echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
module load anaconda/3.6
source activate eacikgoz17
nvidia-smi
python main_tur.py 
source deactivate
