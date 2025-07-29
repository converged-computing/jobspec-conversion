#!/bin/bash
#SBATCH --job-name=SDP2
#SBATCH --output=out/err_SDP2
#SBATCH --mail-user=lbywhj@mail.ustc.edu.cn
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000M
#SBATCH --time=00:24:00
#SBATCH --partition=serial_requeue
#SBATCH --array=1-500

export R_LIBS_USER='$HOME/apps/R:$R_LIBS_USER'

module load gcc/7.1.0-fasrc01 R/3.6.3-fasrc01
export R_LIBS_USER=$HOME/apps/R:$R_LIBS_USER
input=Simul_SDP2.R
cd /n/home09/cdai/FDR/real_data/code
R CMD BATCH $input out/$input.$SLURM_ARRAY_TASK_ID.out
sleep 1                                          # pause to be kind to the scheduler
done
