#!/bin/bash
#FLUX: --job-name=dinosaur-hope-4341
#FLUX: --priority=16

gitdir=~/dpm
srcdir=$gitdir/src
maindir=$gitdir/main/meso2D
dpmdir=/gpfs/loomis/project/fas/ohern/"$USER"/dpm
outputdir=$dpmdir/mesoEnthalpyMin2D
inputdir=$dpmdir/mesoInput2D
if [[ ! -d $inputdir ]]; then
    echo ERROR: directory $inputdir does not exist, so ending.
    exit 1
fi
mkdir -p $outputdir
mkdir -p bin
mkdir -p tasks
mkdir -p slurm
mkdir -p out
NCELLS=$1
n1=$2
calA0=$3
kl=$4
kb0=$5
betaEff=$6
da0=$7
dl0=$8
P0=$9
partition="${10}"
time="${11}"
startSeed="${12}"
numSeeds="${13}"
let endSeed=$startSeed+$numSeeds-1
inputstr=mesoInput_N"$NCELLS"_n"$n1"_ca"$calA0"
basestr=mesoHMin2D_N"$NCELLS"_n"$n1"_ca"$calA0"_kl"$kl"_kb0"$kb0"_be"$betaEff"_da"$da0"_dl"$dl0"_P"$P0"
runstr="$basestr"_ns"$numSeeds"
simdatadir=$outputdir/$basestr
mkdir -p $simdatadir
paramf="$simdatadir"/"$basestr".params
if [[ -f $paramf ]]
then
    rm $paramf
fi
echo inputstr=$inputstr >> $paramf
echo NCELLS=$NCELLS >> $paramf
echo n1=$n1 >> $paramf
echo calA0=$calA0 >> $paramf
echo kl=$kl >> $paramf
echo kb0=$kb0 >> $paramf
echo betaEff=$betaEff >> $paramf
echo da0=$da0 >> $paramf
echo dl0=$dl0 >> $paramf
echo P0=$P0 >> $paramf
echo partition=$partition >> $paramf
echo time=$time >> $paramf
echo startSeed=$startSeed >> $paramf
echo endSeed=$endSeed >> $paramf
echo Parameter file:
cat $paramf
binf=bin/"$runstr".o
mainf=$maindir/readInMesoNetwork2D.cpp
rm -f $binf
g++ --std=c++11 -O3 -I "$srcdir" "$mainf" "$srcdir"/*.cpp -o $binf 
echo compiling with : g++ --std=c++11 -O3 -I "$srcdir" "$mainf" "$srcdir"/*.cpp -o $binf   
if [[ ! -f $binf ]]
then
    echo -- binary file does not exist, compilation failed.
    exit 1
fi
flist="$inputdir"/"$inputstr"/"$inputstr"_seed*.input
let arrsz=0
for f in $flist; do
    let arrsz=$arrsz+1
done
if [[ $arrsz -lt 2 ]]
then
    echo flist = $flist
    echo arrsz = $arrsz, which is too small, ending.
    exit 1
else
    echo flist has $arrsz files, adding to task list...
fi
taskf=tasks/"$runstr".task
rm -f $taskf
let fcount=1
for f in $flist; do
    # parse file name
    file=${f##*/}
    baseid=${file%%.input}
    seed=${baseid#*seed*}
    echo seed = $seed, input file = $file
    # check if seed is in correct range
    if [[ $seed -lt $startSeed ]]
    then
        echo seed = $seed too small, skipping...
        continue
    elif [[ $fcount -gt $numSeeds ]]
    then
        echo fcount = $fcount, which is greater than numSeeds = $numSeeds. 
        echo Enough array entries found, ending addition to task file. 
        break
    else
        # check if file is empty
        if [[ ! -s $f ]]
        then
            echo file $file is empty, skipping...
            continue
        else
            # increment file count
            let fcount=$fcount+1
            echo seed = $seed is ready for primetime, adding to task file.
        fi
    fi
    # create output file
    outputf=$simdatadir/"$basestr"_seed"$seed".posctc
    # create runString
    runString="./$binf $f $kl $kb0 $betaEff $da0 $dl0 $P0 $seed $outputf"
    # echo to task file
    echo "$runString" >> $taskf
done
if [[ ! -f "$taskf" ]]
then
    echo task file not created, ending before job submission
    exit 1
fi
let arraynum=$fcount-1
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
