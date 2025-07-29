#!/bin/bash
#SBATCH --job-name=detection_hmc
#SBATCH --account=xdy@gpu
#SBATCH --output=detection_hmc.out
#SBATCH --error=detection_hmc.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=ntasks-per-node=1,v100-32g

set -x
cd $WORK/repo/jl/scripts
module purge
module load tensorflow-gpu/py3/2.5.0
for i in {1..10}
do
  srun python ./sample_hmc.py --convergence=../data/ktng/ktng_kappa360v2.fits\
                        --mask=../data/COSMOS/cosmos_full_mask_0.29arcmin360copy.fits\
                        --model_weights=/gpfswork/rech/xdy/commun/Remy2021/score_sn1.0_std0.2_v2/model-final.pckl\
                        --batch_size=10\
                        --initial_step_size=0.013\
                        --initial_temperature=1.\
                        --gaussian_only=False\
                        --reduced_shear=False\
                        --gaussian_path=../data/ktng/ktng_PS_theory.npy\
                        --gaussian_prior=True\
			--output_file=$i\
                        --output_folder=validation/annealed_hmc/clusters3e14\
                        --cosmos_noise_realisation=False\
                        --no_cluster=False\
                        --mass_halo=3e14\
                        --x_cluster=65\
                        --y_cluster=130\
                        --z_halo=.5\
                        --zs=1.\
                        --COSMOS=False
done
