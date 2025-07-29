#!/bin/bash
#SBATCH --job-name=3dseg-torch_predict
#SBATCH --account=p_biiax
#SBATCH --output=slurm_out/3dseg-torch_predict-%j.out
#SBATCH --mail-user=christian.duereth@tu-dresden.de
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE,TIME_LIMIT,TIME_LIMIT_90
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=02:00:00

<<<<<<< HEAD
module load release/23.04 GCC/12.2.0 Python/3.10.8 OpenMPI/4.1.4 CUDA/11.8.0
nvidia-smi
source .venv_3dseg/bin/activate
echo $1
python ./scripts/predict.py --config $1
=======
module load release/23.04 GCC/12.2.0 Python/3.10.8 OpenMPI/4.1.4 CUDA/11.8.0
nvidia-smi
source .venv_3dseg/bin/activate
echo $1
python ./scripts/predict.py --config $1
>>>>>>> bf47220be6f13ee0507fdac5f20cdda293e61b5c
exit 0
