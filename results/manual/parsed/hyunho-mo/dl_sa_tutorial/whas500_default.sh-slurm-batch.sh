#!/bin/bash
#SBATCH --job-name=tf_hello
#SBATCH --output=whas500_out_%j.log
#SBATCH --error=whas500_error_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --partition=express

module purge
module load Python/3.7.4-GCCcore-8.3.0
source /trinity/home/hmo/hmo/hmo_dl/bin/activate 
echo "deepsurv toturial"
python3 deepsurv_pytorch.py -dataset "whas500.xls" -model ~/hmo/dl_sa_tutorial/experiments/deepsurv/models/whas_model_relu_revision.0.json --update_fn "adam" --num_epochs "300"
