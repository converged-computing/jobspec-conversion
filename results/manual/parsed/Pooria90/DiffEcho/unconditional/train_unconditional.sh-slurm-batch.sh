#!/bin/bash
#SBATCH --job-name=<class_name>
#SBATCH --account=<your
#SBATCH --output=<class_name>_out.txt
#SBATCH --error=<class_name>_err.txt
#SBATCH --mail-user=<email
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=32G
#SBATCH --time=20:00:00

export HOME='<path to your new home>'

module load gcc/9.4.0 python/3.8.10 py-virtualenv/16.7.6
source <path to the virtualenv>/bin/activate  
cd $SLURM_SUBMIT_DIR
pwd
nvidia-smi
export HOME="<path to your new home>"
python train_unconditional.py --class_ultra "<class_name>" --num_epochs 400
