#!/bin/bash
#FLUX: --job-name=validation_ODE
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

set -x
cd $WORK/repo/jl/scripts
module purge
module load tensorflow-gpu/py3/2.5.0
for i in {1..10}
do
  srun python ./sample_hmc.py --convergence=../data/ktng/ktng_kappa360v2.fits\
                        --mask=../data/COSMOS/cosmos_full_mask_0.29arcmin360copy.fits\
                        --model_weights=/gpfswork/rech/xdy/commun/Remy2021/score_sn1.0_std0.2/model-final.pckl\
                        --batch_size=10\
                        --initial_step_size=0.013\
                        --min_steps_per_temp=10\
                        --initial_temperature=1.\
                        --gaussian_only=False\
                        --reduced_shear=False\
                        --gaussian_path=../data/ktng/ktng_PS_theory.npy\
                        --gaussian_prior=True\
			--output_file=$i\
                        --output_folder=validation/annealed_hmc\
                        --cosmos_noise_realisation=False\
                        --no_cluster=True\
                        --COSMOS=False
done
