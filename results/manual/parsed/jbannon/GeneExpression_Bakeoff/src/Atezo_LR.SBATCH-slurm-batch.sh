#!/bin/bash
#SBATCH --job-name=Atezo_LR
#SBATCH --output=./slurmouts/Atezo/LR_%j.out
#SBATCH --mail-user=jjb509@nyu.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20GB
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --array=0-5

module purge
settings=(KIRC.LOO KIRC.MC BLCA.LOO BLCA.MC PANCAN.LOO PANCAN.MC)
singularity exec --nv \
            --overlay /scratch/jjb509/GeneExpression_Bakeoff/src/my_overlay.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
            /bin/bash -c "source /ext3/env.sh; python permutation_test.py -drug Atezo -model LogisticRegression -settings ${settings[$SLURM_ARRAY_TASK_ID]}"
