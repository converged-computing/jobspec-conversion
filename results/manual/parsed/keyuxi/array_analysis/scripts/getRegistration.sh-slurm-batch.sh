#!/bin/bash
#SBATCH --output=/scratch/groups/wjg/kyx/NNNlib2b_Nov11/out/R-%x.%j.out
#SBATCH --error=/scratch/groups/wjg/kyx/NNNlib2b_Nov11/out/R-%x.%j.err
#SBATCH --mail-user=kyx@stanford.edu
#SBATCH --mail-type=FAIL,END,BEGIN
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=10G
#SBATCH --time=01:00:00

export MATLABPATH='/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPscripts/:/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPlibs/'

source ~/.bashrc
conda activate py36
module load matlab
export MATLABPATH=/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPscripts/:/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPlibs/
python $GROUP_HOME/kyx/array_analysis/scripts/array_tools/array_data_processing/getRegistrationOffsets.py -id $GROUP_SCRATCH/kyx/NNNlib2b_Nov11/data/fiducial_images_20220314/ -sd /scratch/groups/wjg/kyx/NNNlib2b_Nov11/data/filtered_tiles/ -gv /oak/stanford/groups/wjg/kyx/software -f FID -od $GROUP_SCRATCH/kyx/NNNlib2b_Nov11/data/registration -op registration_offset_20220314
