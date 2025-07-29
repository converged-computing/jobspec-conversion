#!/bin/bash
#SBATCH --account=ogm2
#SBATCH --output=exp/slurm/%j.out
#SBATCH --error=exp/slurm/%j.err
#SBATCH --mail-user=jz2915@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=00:12:00
#SBATCH --partition=debug
#SBATCH --constraint=ntasks-per-node=1

source /gpfsnyu/home/jz2915/config.sh
module purge
module load anaconda3/5.2.0
python $runperf $expsnum $data $perf $re
