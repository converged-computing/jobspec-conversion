#!/bin/bash
#SBATCH --job-name=nanoGPT
#SBATCH --output=nanoGPTLOG.%j
#SBATCH --mail-user=siweicui@tamu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=65536M
#SBATCH --time=06:00:00

cd $SCRATCH
module add GCC/10.3.0  OpenMPI/4.1.1
module load WebProxy
/bin/bash
source activate llm
cd /scratch/user/siweicui/
python /scratch/user/siweicui/override_script.py
cd /scratch/user/siweicui/nanoGPT/
bash run_master.sh
