#!/bin/bash
#FLUX: --job-name=NOMEPROGETTO
#FLUX: -n=16
#FLUX: --queue=qGPU48
#FLUX: -t=86340
#FLUX: --urgency=16

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
