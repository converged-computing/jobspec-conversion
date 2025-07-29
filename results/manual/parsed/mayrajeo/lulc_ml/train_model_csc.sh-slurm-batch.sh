#!/bin/bash
#SBATCH --job-name=LULC_UNET_training
#SBATCH --output=oversample_grass_ce_multi_unet.out
#SBATCH --error=oversample_grass_ce_multi_unet.err
#SBATCH --mail-user=add.your@own.mail
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=12000
#SBATCH --time=12:00:00

echo "$(date)"
module purge
module load python-env/3.5.3-ml
cd $WRKDIR/lulc_ml
python train_model.py 
echo "$(date)"
seff $SLURM_JOBID
