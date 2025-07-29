#!/bin/bash
#SBATCH --job-name=NOMEPROGETTO
#SBATCH --account=CHEM9C4
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=23:59:00

export Project='$SLURM_JOB_NAME'
export WorkDir='/scratch/$SLURM_JOB_ID'
export InpDir='NOMEDIRETTORI'
export outdir='NOMEDIRETTORI/output'

module load GROMACS/2019.6
export Project=$SLURM_JOB_NAME
export WorkDir=/scratch/$SLURM_JOB_ID
export InpDir=NOMEDIRETTORI
export outdir=NOMEDIRETTORI/output
echo $SLURM_JOB_NODELIST > $InpDir/nodename
echo $SLURM_JOB_ID > $InpDir/jobid
mkdir $outdir
mkdir -p $WorkDir
cp $InpDir/* $WorkDir
cd $WorkDir
gmx mdrun -nt 16 -s $Project.tpr -o $Project.trr -x $Project.xtc -c final-$Project.gro -nb gpu
cp $WorkDir/* $outdir/
rm -r $WorkDir
