#!/bin/bash
#FLUX: --job-name=reduce_output
#FLUX: -c=36
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

export EASYBUILD_PREFIX='/store/empa/em05/easybuild'

open_sem(){
    mkfifo pipe-$$
    exec 3<>pipe-$$
    rm pipe-$$
    local i=$1
    for((;i>0;i--)); do
        printf %s 000 >&3
    done
}
run_with_lock(){
    local x
    read -u 3 -n 3 x && ((0==x)) || exit $x
    (
    "$@"
    printf '%.3d' $? >&3
    )&
    echo $$ $!
}
job(){
	echo $@
	sleep 5
}
N=36
open_sem $N
export EASYBUILD_PREFIX=/store/empa/em05/easybuild
module load daint-gpu
module load EasyBuild-custom/cscs
source /store/empa/em05/pyvenv-3.6/bin/activate
pyscript="$1"
indir="$2"
outdir="$3"
input_start="$4" # "2017-10-15 00"                                             
input_end="$5" # "2017-10-16 12"  
nout_levels="$6"
hstep="$7"
csvfile="$8"
convert_gas="$9"
startdate=$(date -d "$input_start") || exit -1                                 
enddate=$(date -d "$input_end")     || exit -1 
step_end="$(($hstep - 1))"
d="$startdate"
while [[ "$str_d" < "$input_end" || "$str_d" == "$input_end" ]]; do
  strdate_start=$(date -u -d "$d" +%Y%m%d%H)                                            
  strdate_end=$(date -u -d "${d} + ${step_end} hours" +%Y%m%d%H) 
  run_with_lock python "$pyscript" "$indir" "$outdir" "$strdate_start" "$strdate_end" "$nout_levels" "$csvfile" "$convert_gas"
  d=$(date -u -d "${d} + ${hstep} hours")                                                   
  str_d=$(date -u -d "$d" +%Y%m%d%H)
done
wait
exit 0
