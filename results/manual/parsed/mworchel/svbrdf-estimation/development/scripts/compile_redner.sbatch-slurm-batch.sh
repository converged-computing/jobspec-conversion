#!/bin/bash
#SBATCH --job-name=RednerCompilation
#SBATCH --output=%x_%j_%N.out
#SBATCH --error=%x_%j_%N.err
#SBATCH --mail-user=m.worchel@campus.tu-berlin.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00

module purge
module load cmake/3.16.3
module load comp/gcc/7.2.0
module load nvidia/cuda/10.0
echo $PWD
echo "Entering working directory"
cd ~/redner
echo $PWD
source activate redner-build-env
echo "Building redner"
python -u -m pip wheel -w dist --verbose .
exitCode=$?
echo "Finished building (exit code $exitCode)"
conda deactivate
exit $exitCode
