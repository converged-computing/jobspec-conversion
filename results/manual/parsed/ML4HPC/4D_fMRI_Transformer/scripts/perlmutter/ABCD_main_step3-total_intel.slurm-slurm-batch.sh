#!/bin/bash
#SBATCH --job-name=TFF_ABCD_step_three
#SBATCH --account=m3898_g
#SBATCH --output=slurm_logs/R-%x-%j-total.out
#SBATCH --mail-user=kjb961013@snu.ac.kr
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=06:00:00
#SBATCH --partition=regular
#SBATCH: --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=4
#SBATCH --chdir=../

set +x
source /global/common/software/nersc/shasta2105/python/3.8-anaconda-2021.05/etc/profile.d/conda.sh
conda activate 3DCNN
env | grep SLURM
srun python main.py --image_path /pscratch/sd/s/stella/ABCD_TFF/MNI_to_TRs --dataset_name ABCD --step 3 --batch_size_phase3 4 --target nihtbx_totalcomp_uncorrected --fine_tune_task regression --resume 
