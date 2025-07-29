#!/bin/bash
#SBATCH --job-name=PPOexp216
#SBATCH --account=kutem
#SBATCH --output=PPPexp216.out
#SBATCH --mail-user=tbal21@ku.edu.tr
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=kutem
#SBATCH --qos=kutem
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=rk01

echo "Activating Python 3.8.6..."
module load python/3.8.6
echo "Activating GCC-9.1.0..."
module load gcc/9.1.0
echo ""
echo "======================================================================================"
env
echo "======================================================================================"
echo ""
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
echo "Running Example Job...!"
echo "==============================================================================="
echo "Running Python script..."
echo "First Script..."
python3 trainTest.py --expNumber 216 --total_timesteps 163840 --n_steps 2048 --batch_size 1024 --n_envs 8 --testSamples 2 --testSampleOnTraining 2 --accelerationConstant 0.00000 --velocityConstant 0.1 --jointLimitLowStartID "W0Low" --jointLimitHighStartID "W0High"
echo "Second Script..."
echo "Running G++ compiler..."
echo "Running compiled binary..."
