#!/bin/bash
#SBATCH --job-name=phi-2
#SBATCH --account=pi_dhruveshpate_umass_edu
#SBATCH --output=unity/logs/phi-2.txt
#SBATCH --error=unity/logs/phi-2.err
#SBATCH --mail-user=vdorna@umass.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

module load miniconda/22.11.1-1
conda activate harness
nvidia-smi
cd /work/pi_dhruveshpate_umass_edu/vdorna_umass_edu/SmallLMReasoning
bash eval-scripts/phi2-gsm8k.sh
echo "Done"
