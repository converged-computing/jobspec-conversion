#!/bin/bash
#FLUX: --job-name=PPants
#FLUX: -n=2
#FLUX: -t=54000
#FLUX: --urgency=16

export PBS_NODEFILE='`/fslapps/fslutils/generate_pbs_nodefile`'
export PBS_JOBID='$SLURM_JOB_ID'
export PBS_O_WORKDIR='$SLURM_SUBMIT_DIR'
export PBS_QUEUE='batch'
export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
workDir=$1
scan=$2
DoACT.Function() {
    struct=$1
    tempDir=~/compute/PreProc_Methods/Template
    priorDir=${tempDir}/priors_ACT
    tempH=${tempDir}/PreProc_head_template.nii.gz
    tempB=${tempDir}/PreProc_brain_template.nii.gz
    pmask=${priorDir}/Template_BrainCerebellumProbabilityMask.nii.gz
    emask=${priorDir}/Template_BrainCerebellumExtractionMask.nii.gz
    out=act_
    antsCorticalThickness.sh \
    -d 3 \
    -a $struct \
    -e $tempH \
    -t $tempB \
    -m $pmask \
    -f $emask \
    -p ${priorDir}/Prior%d.nii.gz \
    -o $out
}
cd $workDir
DoACT.Function $scan
