#!/bin/bash
#FLUX: --job-name=PPOexp1300
#FLUX: --queue=long
#FLUX: -t=604800
#FLUX: --urgency=16

echo "Activating Python 3.6.3..."
module load python/3.6.1
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
python3 trainTest.py --expNumber 1300 --mode True --total_timesteps 18000000 --n_steps 1000 --batch_size 2048 --n_envs 100 --testSamples 1000 --evalFreqOnTraining 3000000 --lambdaErr 100.0 --velocityConstant 0.1 --orientationConstant 50 --maeThreshold 0.15 --configName "Agent5_Panda.yaml" --avgJntVelThreshold 0.15 --collisionConstant 0.0 --avgQuaternionAngleThreshold 0.1
echo "Running G++ compiler..."
echo "Running compiled binary..."
