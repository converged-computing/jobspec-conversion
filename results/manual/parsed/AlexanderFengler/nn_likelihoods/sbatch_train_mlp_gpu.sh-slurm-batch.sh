#!/bin/bash
#SBATCH --job-name=mlp_analytic
#SBATCH --account=carney-frankmj-condo
#SBATCH --output=/users/afengler/batch_job_out/mlp_train_ddm_analytic_%A_%a.out
#SBATCH --mail-user=alexander_fengler@brown.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=18:00:00
#SBATCH --constraint=quadrortx
#SBATCH --array=1-1

source /users/afengler/.bashrc
conda deactivate
conda activate tf-gpu-py37
module load cuda/10.0.130
module load cudnn/7.6
nfiles=10 # Number of training data files to use for training
n_networks_to_train=5 # Number of networks to train
method="$@" # supplied as argument # choose data generating process (includes analytic label !) 
machine='af_ccv' # Choose machine
train_n_sim=10000 # Specifies which training data to choose (n is the number of simulations that were run per parameterization)
training_data_folder="training_data_binned_0_nbins_0_n_${train_n_sim}/" # subfolder that holds the training data
for ((i = 1; i <= $n_networks_to_train; i++))
    do
       echo "NOW TRAINING NETWORK: $i of $n_networks_to_train"
       python -u /users/afengler/git_repos/nn_likelihoods/keras_fit_model.py --machine $machine \
                                                                             --method $method \
                                                                             --nfiles $nfiles \
                                                                             --traindatafolder $training_data_folder \
                                                                             --warmstart 0 
                                                                             #--analytic $analytic
    done
