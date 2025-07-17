#!/bin/bash
#FLUX: --job-name=misunderstood-lentil-2353
#FLUX: --urgency=16

outputdir=/gpfs/loomis/project/fas/ohern/jdt45/dpm
simtypedir=$outputdir/meso2D
savedir=$simtypedir/matfiles
mkdir -p $outputdir
mkdir -p $simtypedir
mkdir -p $savedir
mkdir -p bin
mkdir -p tasks
mkdir -p slurm
mkdir -p out
NCELLS=$1
n1=$2
calA0=$3
kb0=$4
ctch=$6
cL=$7
aL=$8
cB=$9
cKb="${10}"
partition="${11}"
time="${12}"
basestr=meso2D_N"$NCELLS"_n"$n1"_ca"$calA0"_kb0"$kb0"_be"$betaEff"_h"$ctch"_cL"$cL"_aL"$aL"_cB"$cB"_cKb"$cKb"
runstr="$basestr"_PROCESS
searchstr="$basestr"_seed
simdatadir=$simtypedir/$basestr
if [[ ! -d $simdatadir ]]
then
    echo -- sim directory "$simdatadir" does not exist, ending.
    exit 1
fi
savestr="$savedir"/"$basestr"_processed.mat
MCODE="addpath ~/dpm/viz/meso2D; processMesoNetwork2D('$simdatadir','$searchstr','$savestr'); quit"
slurmf=slurm/"$runstr".slurm
job_name="$runstr"
runout=out/"$runstr".out
rm -f $slurmf
echo -- running time = $time for $partition
echo -- PRINTING SLURM FILE...
echo \#\!/bin/bash >> $slurmf
echo \#SBATCH --cpus-per-task=1 >> $slurmf
echo \#SBATCH -n 1 >> $slurmf
echo \#SBATCH -p $partition >> $slurmf
echo \#SBATCH -J $job_name >> $slurmf
echo \#SBATCH -o $runout >> $slurmf
echo \#SBATCH --mem-per-cpu=10G >> $slurmf
echo module load MATLAB >> $slurmf
echo matlab -nodisplay -r \""$MCODE"\" >> $slurmf
cat $slurmf
echo -- running on slurm in partition $partition
sbatch -t $time $slurmf
