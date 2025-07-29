#!/bin/bash
#SBATCH --output=/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/taylor_simple_hwr/slurm_scripts/scripts/cnn_architecture/log_resnet.slurm
#SBATCH --mail-user=taylornarchibald@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=10666
#SBATCH --time=1-12:00:00
#SBATCH --constraint=rhel7&pascal

export PATH='/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/env/hwr4_env:$PATH'

module purge
module load cuda/10.1
module load cudnn/7.6
export PATH="/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/env/hwr4_env:$PATH"
cd "/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/taylor_simple_hwr"
which python
python -u train.py --config '/panfs/pan.fsl.byu.edu/scr/grp/fslg_hwr/taylor_simple_hwr/configs/cnn_architecture/resnet.yaml'
