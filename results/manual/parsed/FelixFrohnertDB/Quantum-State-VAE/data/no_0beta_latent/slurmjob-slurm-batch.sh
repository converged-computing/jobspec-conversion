#!/bin/bash
#SBATCH --job-name=gen_dm_4x4
#SBATCH --output=./tjob.out.%j
#SBATCH --error=./tjob.err.%j
#SBATCH --mail-user=frohnert@mail.lorentz.leidenuniv.nl
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=15:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./

module load QuantumMiniconda3/4.7.10
source /marisdata/frohnert/cluster/gen_dm/venv/bin/activate
size=1 
beta=0.0
noise="False"
for n_lat in 2
do
   srun python /home/frohnert/cluster/vae_4x4_mult.py $n_lat $size $beta $noise
done
