#!/bin/bash
#SBATCH --job-name=trickle_constr
#SBATCH --output=/Users/siwa3657/sbatchOut/trickle_const.out
#SBATCH --error=/Users/siwa3657/sbatchOut/trickle_const.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=8gb
#SBATCH --time=00:10:00
#SBATCH --partition=short

pwd; hostname; date
echo "You've requested $SLURM_CPUS_ON_NODE core(s)."
singularity exec --writable-tmpfs docker://rust:latest /bin/bash ./build_ancestral_net.sh ../data/dirty/79867.txt ../data/soln/79867.txt
