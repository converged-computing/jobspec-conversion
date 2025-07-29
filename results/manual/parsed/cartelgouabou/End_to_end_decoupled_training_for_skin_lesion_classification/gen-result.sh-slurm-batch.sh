#!/bin/bash
#SBATCH --job-name=res
#SBATCH --account=izg@v100
#SBATCH --output=res_%j.out
#SBATCH --error=res_%j.err
#SBATCH --mail-user=cartel.gouabou@lis-lab.fr
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu_p2s
#SBATCH --qos=qos_gpu-t4

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.11.0 
ulimit -n 4096
set -x # activer l’echo des commandes
cd $WORK/isic2018
srun python -u generate_result.py --loss_type CHML4 --weighting_type CS --hm_delay_type epoch --max_thresh 0.3
