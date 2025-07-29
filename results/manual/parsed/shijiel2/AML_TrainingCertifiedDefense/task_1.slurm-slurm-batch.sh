#!/bin/bash
#SBATCH --job-name=task_1
#SBATCH --account=punim1629
#SBATCH --output=task_1.log
#SBATCH --mail-user=404notfxxkingfound@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:4
#SBATCH --mem=64G
#SBATCH --time=2-02:00:00
#SBATCH --partition=gpgpudeeplearn
#SBATCH --constraint=ntasks-per-node=1

echo "Loading required modules"
module load fosscuda/2020b
module load torchvision/0.10.0-python-3.8.6-pytorch-1.9.0
echo "Install libs" 
pip3 install statsmodels
pip3 install --user tqdm
pip3 install --user scikit-learn
pip3 install --user matplotlib
echo "Good to go!"
cd opacus/examples
python3 automator.py
