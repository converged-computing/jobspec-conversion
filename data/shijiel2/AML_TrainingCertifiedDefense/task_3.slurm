#!/bin/bash
#SBATCH --job-name=task_3
#SBATCH --output=task_3.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=24
#SBATCH --time=00:05:00
#SBATCH --mem=64G
#SBATCH --partition=shortgpgpu
#SBATCH --gres=gpu:4
#SBATCH -q gpgpumse
#SBATCH -A punim1629
#SBATCH --mail-user=404notfxxkingfound@gmail.com
#SBATCH --mail-type=ALL


echo "Loading required modules"
module load fosscuda/2020b
module load torchvision/0.10.0-python-3.8.6-pytorch-1.9.0

echo "Install libs" 
# pip3 install --upgrade pip
# pip3 install --user torch torchvision torchaudio
# pip3 install --user foolbox
# pip3 install --user git+https://github.com/fra31/auto-attack
# pip3 install --user scikit-learn
# pip3 install --user matplotlib

pip3 install statsmodels
# pip3 install -e .
pip3 install --user tqdm
pip3 install --user scikit-learn
pip3 install --user matplotlib

echo "Good to go!"
cd opacus/examples
python3 automator_3.py
# python3 -m torch.distributed.launch --nproc_per_node=4 automator_3.py