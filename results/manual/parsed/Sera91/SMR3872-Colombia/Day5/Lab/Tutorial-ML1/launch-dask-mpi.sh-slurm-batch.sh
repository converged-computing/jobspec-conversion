#!/bin/bash
#SBATCH --job-name=cl_test
#SBATCH --account=ict23_esp_0
#SBATCH --output=/leonardo_work/ICT23_SMR3872/sdigioia/test_env/run.out
#SBATCH --error=/leonardo_work/ICT23_SMR3872/sdigioia/test_env/run.err
#SBATCH --mail-user=sdigioia@sissa.it
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=60G
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=6

module purge
module load --auto profile/deeplrn
module load gcc 
module load openmpi
module load cuda/11.8 
cd /leonardo_work/ICT23_SMR3872/sdigioia/test_env/
source /leonardo/home/userexternal/sdigioia/.bashrc
conda activate /leonardo_work/ICT23_ESP_0/shared-env/MLenv
mpirun -np 8 test-dask-on-GPUs.py
