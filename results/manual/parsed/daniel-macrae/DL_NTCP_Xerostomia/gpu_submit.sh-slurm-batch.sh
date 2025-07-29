#!/bin/bash
#SBATCH --job-name=Xerostomia_1
#SBATCH --output=slurm-%j.log
#SBATCH --mail-user=d.macrae@student.rug.nl
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=23:59:59

module purge
module load Python/3.11.3-GCCcore-12.3.0
python3 -m venv /scratch/$USER/.envs/HNC_env
source /scratch/$USER/.envs/HNC_env/bin/activate
pip install --upgrade pip
pip3 install torch torchvision torchaudio
pip3 install torchinfo tqdm monai pytz SimpleITK pydicom scikit-image matplotlib numpy 
pip3 install torch_optimizer
pip3 install scikit-learn opencv-python
pip3 install timm
pip3 install pandas
module purge
module load Python/3.11.3-GCCcore-12.3.0
source /scratch/$USER/.envs/HNC_env/bin/activate
python3 -u main.py
