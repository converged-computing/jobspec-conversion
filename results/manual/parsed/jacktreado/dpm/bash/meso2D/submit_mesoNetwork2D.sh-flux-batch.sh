#!/bin/bash
#FLUX: --job-name=blue-leopard-2777
#FLUX: --urgency=16

cellsdir=~/dpm
srcdir=$cellsdir/src
maindir=$cellsdir/main/meso2D
outputdir=/gpfs/loomis/project/fas/ohern/jdt45/dpm
simtypedir=$outputdir/meso2D
mkdir -p $outputdir
mkdir -p $simtypedir
mkdir -p bin
mkdir -p tasks
mkdir -p slurm
mkdir -p out
NCELLS=$1
n1=$2
calA0=$3
kb0=$4
betaEff=$5
ctch=$6
cL=$7
aL=$8
cB=$9
cKb="${10}"
partition="${11}"
time="${12}"
numRuns="${13}"
startSeed="${14}"
disp=0.1
numSeedsPerRun=1
let numSeeds=$numSeedsPerRun*$numRuns
let endSeed=$startSeed+$numSeeds-1
basestr=meso2D_N"$NCELLS"_n"$n1"_ca"$calA0"_kb0"$kb0"_be"$betaEff"_h"$ctch"_cL"$cL"_aL"$aL"_cB"$cB"_cKb"$cKb"
runstr="$basestr"_startseed"$startSeed"_endseed"$endSeed"
simdatadir=$simtypedir/$basestr
mkdir -p $simdatadir
binf=bin/"$runstr".o
mainf=$maindir/mesoNetwork2D.cpp
echo Running mesoNetwork2D simulations with parameters:
echo NCELLS = "$NCELLS"
echo n1 = "$n1"
echo calA0 = "$calA0"
echo kb0 = "$kb0"
echo betaEff = "$betaEff"
echo ctch = "$ctch"
echo cL = "$cL"
echo aL = "$aL"
echo cB = "$cB"
echo cKb = "$cKb"
rm -f $binf
g++ --std=c++11 -O3 -I "$srcdir" "$mainf" "$srcdir"/*.cpp -o $binf 
echo compiling with : g++ --std=c++11 -O3 -I "$srcdir" "$mainf" "$srcdir"/*.cpp -o $binf   
if [[ ! -f $binf ]]
then
    echo -- binary file does not exist, compilation failed.
    exit 1
fi
taskf=tasks/"$runstr".task
rm -f $taskf
let fcount=0
for seed in `seq $startSeed $numSeedsPerRun $endSeed`; do
    # count files
    let fcount=$fcount+1
    # echo to console
    echo On base seed $seed
    # echo string of numSeedPerRun commands to task file
    runString="cd `pwd`"
    # loop over seeds to go into runString
    let ssMax=$numSeedsPerRun-1
    for ss in `seq 0 $ssMax`; do
        # get seed for actual run
        let runseed=$seed+ss
        # get file str
        filestr="$basestr"_seed"$seed"
        # create output files
        posf=$simdatadir/$filestr.pos
        # append to runString
        runString="$runString ; ./$binf $NCELLS $n1 $disp $calA0 $kb0 $betaEff $ctch $cL $aL $cB $cKb $runseed $posf"
    done
    # finish off run string
    runString="$runString ;"
    # echo to task file
    echo "$runString" >> $taskf
done
if [[ ! -f "$taskf" ]]
then
    echo task file not created, ending before job submission
    exit 1
fi
let arraynum=$fcount
echo -- total number of array runs = $arraynum
slurmf=slurm/"$runstr".slurm
job_name="$runstr"
runout=out/"$runstr"-%a.out
rm -f $slurmf
echo -- running time = $time for $partition
echo -- PRINTING SLURM FILE...
echo \#\!/bin/bash >> $slurmf
echo \#SBATCH --cpus-per-task=1 >> $slurmf
echo \#SBATCH --array=1-$arraynum >> $slurmf
echo \#SBATCH -n 1 >> $slurmf
echo \#SBATCH -p $partition >> $slurmf
echo \#SBATCH -J $job_name >> $slurmf
echo \#SBATCH -o $runout >> $slurmf
echo sed -n \"\$\{SLURM_ARRAY_TASK_ID\}p\" "$taskf" \| /bin/bash >> $slurmf
cat $slurmf
echo -- running on slurm in partition $partition
sbatch -t $time $slurmf
