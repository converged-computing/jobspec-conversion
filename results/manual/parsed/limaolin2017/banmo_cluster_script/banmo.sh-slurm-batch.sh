#!/bin/bash
#SBATCH --job-name=3D_reconstruction
#SBATCH --output=slurm_3D.%N.%J.out
#SBATCH --error=slurm_3D.%N.%J.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=16g
#SBATCH --time=4-04:40:39
#SBATCH --partition=high
#SBATCH --exclude=node[001-018],node[031-032]

export LD_LIBRARY_PATH='/gpfs/home/mli/.conda/envs/banmo-cu113/lib/:$LD_LIBRARY_PATH'

module load Miniconda3
cd ./banmo
eval "$(conda shell.bash hook)"
source /soft/easybuild/x86_64/software/Miniconda3/4.9.2/etc/profile.d/conda.sh
conda activate banmo-cu113
export LD_LIBRARY_PATH=/gpfs/home/mli/.conda/envs/banmo-cu113/lib/:$LD_LIBRARY_PATH
seqname="cat-pikachiu"
python preprocess/img2lines.py --seqname $seqname
bash scripts/template.sh 0,1 $seqname 10001 "no" "no"
bash scripts/render_mgpu.sh 0,1 $seqname logdir/$seqname-e120-b256-ft2/params_latest.pth \
        "0 1 2 3 4 5 6 7 8 9 10" 256
