#!/bin/bash
#SBATCH --job-name=NOMEPROGETTO
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem-per-cpu=45G
#SBATCH --time=23:59:00
#SBATCH --partition=qPHOGPU

export Project='$SLURM_JOB_NAME'
export WorkDir='/runjobs/RS10237/$SLURM_JOB_ID'
export InpDir='NOMEDIRETTORI'
export outdir='NOMEDIRETTORI'

cd $SLURM_SUBMIT_DIR
module load ComputationalChemistry/Gromacs2019
export Project=$SLURM_JOB_NAME
export WorkDir=/runjobs/RS10237/$SLURM_JOB_ID
export InpDir=NOMEDIRETTORI
export outdir=NOMEDIRETTORI
echo $SLURM_JOB_NODELIST > $InpDir/nodename
echo $SLURM_JOB_ID > $InpDir/jobid
mkdir -p $WorkDir
cp -r $InpDir/* $WorkDir
cd $WorkDir
/apps/Computation_Chemistry/gromacs-2019/Debug_Build-Skylake-GPU/bin/gmx mdrun -nt 16 -s $Project.tpr -rerun $Project.trr
cp $WorkDir/* $outdir/
rm -r $WorkDir
