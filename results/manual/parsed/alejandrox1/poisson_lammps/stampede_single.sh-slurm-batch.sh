#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --mail-user=alarcj137@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --exclusive

module load lammps
procs=$1
latttype=$2
lattconst=$3
deform=$4
struct=$5
host=$(hostname)
set -- "$host"
IFS="."; declare -a array=($*)
echo "${array[@]}"
flag="${array[1]}"
IFS=" "
case "$flag" in
        "stampede")
                cluster="$flag"
                partition=normal
                cpern=16
                echo "Running on sampede.tacc.xsede.org"
                runfiles=/home1/03561/alarcj/LAMMPS
                structures=/home1/03561/alarcj/LAMMPS/schwarzite/atomic
                cp ${structures}/${struct} .
                cp ${runfiles}/in.elastic .
                cp ${runfiles}/init.mod .
                cp ${runfiles}/potential.mod .
                cp ${runfiles}/displace.mod .
                cp ${runfiles}/CH.airebo . 
                ;;
        "sdsc")
                cluster=comet
                files=/oasis/scratch/comet/alarcj/temp_project/AMINO/data/op_run
                partition=compute
                echo "Running on comet.sdsc.xsede.org"
                ;;
        *)
                echo "Unkown option."
                exit
esac
types=`awk 'FNR == 7 {print $1}' ${struct}`
string=$(for ((i=1; i<=$types; i++)); do printf "%s" " C "; done)
sed -i "s/CH.airebo C.*/CH.airebo ${string}/" potential.mod
ibrun -np $procs lmp_stampede -var fname ${struct} -var up ${deform} -var lattype ${latttype} -var latconst ${lattconst} < in.elastic 
