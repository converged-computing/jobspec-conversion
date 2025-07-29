#!/bin/bash
#SBATCH --account=def-miranska
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=03:00:00
#SBATCH --array=0-99

cp *.json $SLURM_TMPDIR
cp *.py $SLURM_TMPDIR
cp *.sh $SLURM_TMPDIR
tar xf input.tar.gz -C $SLURM_TMPDIR
module load python/3.7.4
module load cuda cudnn
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index tensorflow_gpu
nvidia-smi
echo "*********************************************************************"
cd $SLURM_TMPDIR
ls -l
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
python ./run_terminal.py -n $SLURM_ARRAY_TASK_ID -u 10 -m 30 --chkpt True --flat 1
tar -cf ~/projects/def-miranska/iwonajs/nn_CAR_binary_10F/CAR_variant_30_$SLURM_ARRAY_TASK_ID.tar results
