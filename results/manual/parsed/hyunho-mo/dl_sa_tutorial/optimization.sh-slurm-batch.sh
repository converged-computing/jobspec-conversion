#!/bin/bash
#SBATCH --job-name=tf_hello
#SBATCH --output=hyer_opt_out_%j.log
#SBATCH --error=hyer_opt_error_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=01:00:00

module purge
module load Python/3.7.4-GCCcore-8.3.0
source /trinity/home/hmo/hmo/hmo_dl/bin/activate 
echo "deepsurv toturial_hyperparameters optimization"
python3 pytorch_hyperparams_opt.py -dataset "whas500.xls" -box ~/hmo/dl_sa_tutorial/hyperparam_search/box_constraints_pytorch.json --num_evals 100
