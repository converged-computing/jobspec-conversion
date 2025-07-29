#!/bin/bash
#SBATCH --job-name=quantest
#SBATCH --output=output_9.txt
#SBATCH --mail-user=d.osin@skoltech.ru
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=2
#SBATCH --mem=32G
#SBATCH --time=6-00:00:00

srun singularity exec --bind /home/d.osin/:/home --bind /gpfs/gpfs0/d.osin/data_main:/home/dev/data_main -f --nv quantnas.sif bash -c '
    cd /home/QuanToaster;
    nvidia-smi;
    python batch_exp.py -v 0 -d entropy_8_debug_esa -g 0 -c entropy_8_debug.yaml &
    python batch_exp.py -v 1e-6 -d entropy_8_debug_esa -g 0 -c entropy_8_debug.yaml &
    python batch_exp.py -v 1e-5 -d entropy_8_debug_esa -g 1 -c entropy_8_debug.yaml &
    python batch_exp.py -v 1e-4 -d entropy_8_debug_esa -g 1 -c entropy_8_debug.yaml &
    wait
'
