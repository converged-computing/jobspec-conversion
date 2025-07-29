#!/bin/bash
#SBATCH --output=/network/tmp1/princelu/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=05:00:00
#SBATCH --qos=high

start=`date +%s`
module purge
module load python/3.7
source $HOME/pytorch/bin/activate
echo $DATA
echo $PARAMETERS
mkdir $SLURM_TMPDIR/data
mkdir $SLURM_TMPDIR/models
cp $DATA $SLURM_TMPDIR/data
python run_lfads.py -d $SLURM_TMPDIR/$DATA -p $PARAMETERS -o $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/models $HOME/hierarchical_lfads
end=`date +%s`
runtime=$((end-start))
echo "Runtime was $runtime seconds"
