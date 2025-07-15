#!/bin/bash
#FLUX: --job-name=PPOexp560
#FLUX: --queue=mid
#FLUX: -t=86400
#FLUX: --priority=16

export PYTHONPATH='/kuacc/users/tbal21/.conda/envs/stableBaselines/panda-gym/panda_gym/envs/utils'

echo "Activating Python 3.6.3..."
echo "Activating GCC-7.2.1..."
module load gcc/7.2.1
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
export PYTHONPATH="/kuacc/users/tbal21/.conda/envs/stableBaselines/panda-gym/panda_gym/envs/utils"
python3 trainTest.py --expNumber 560 --total_timesteps 30000000 --n_steps 4096 --batch_size 2048 --n_envs 16 --testSamples 1 --evalFreqOnTraining 3000000 --lambdaErr 100.0 --velocityConstant 0.1 --orientationConstant 32 --maeThreshold 0.012 --configName "1.yaml"
echo "Running G++ compiler..."
echo "Running compiled binary..."
