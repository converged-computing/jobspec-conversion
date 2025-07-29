#!/bin/bash
#SBATCH --job-name=SVBRDFTraining
#SBATCH --output=%x_%j_%N.out
#SBATCH --error=%x_%j_%N.err
#SBATCH --mail-user=m.worchel@campus.tu-berlin.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=2-00:00:00

module purge
module load comp/gcc/7.2.0
module load nvidia/cuda/10.0
echo $PWD
echo "Entering working directory"
cd ~/svbrdf-estimation/development/multiImage_pytorch/
echo $PWD
source activate svbrdf-env
echo "Running training"
python -u main.py --mode train --input-dir "./../../../materialsData_multi_image/train/" --image-count 0 --model-dir "./models" --epochs 200 --save-frequency 1
exitCode=$?
echo "Finished training (exit code $exitCode)"
conda deactivate
exit $exitCode
