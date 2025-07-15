#!/bin/bash
#FLUX: --job-name=crunchy-gato-2541
#FLUX: -c=36
#FLUX: -t=259200
#FLUX: --priority=16

export PATH='$(pwd):/work/scitas-share/ddossant/xtb/6.4.1/intel-19.0.5/bin:$PATH'
export OMP_STACKSIZE='4G'
export OMP_MAX_ACTIVE_LEVELS='1'
export RAMDIR='/dev/shm/\${SLURM_JOBID}'
export GAUSS_SCRDIR='\${RAMDIR}'
export SLURM_SCRDIR='\${RAMDIR}'

export PATH=$(pwd):/work/scitas-share/ddossant/xtb/6.4.1/intel-19.0.5/bin:$PATH
function is_bin_in_path {
     builtin type -P "$1" &> /dev/null
}
module load gaussian/g16-C.01
is_bin_in_path xtb  && echo "Found xtb." || echo "No xtb found. Exit!"  
is_bin_in_path crest  && echo "Found crest." || echo "No crest found. Exit!" 
is_bin_in_path g16  && echo "Found g16." || echo "No g16 found. Exit!" 
job_directory=$(pwd)
input=${1}
name="${1%%.com}"
inpname="${name}.com"
inpname_xtb="${name}_xtb.com"
outname="${name}.log"
output="${job_directory}/${name}.out"
curdir='$SLURM_SUBMIT_DIR'
gauroute=$(grep "#" ${inpname}|  tr [:upper:] [:lower:] | grep "opt" )
if [[ ${gauroute} =~ "ts" ]]; then
    xtbroute='# IOP(1/18=0) IOP(1/6=500) external="xtb-gaussian -P 6"'
else
    xtbroute='# IOP(1/6=500) external="xtb-gaussian -P 6"'
fi
echo ${xtbroute} | cat - ${inpname} > ${inpname_xtb}
echo "#!/bin/bash
module load intel intel-mkl
ulimit -s unlimited
export OMP_STACKSIZE=4G
export OMP_MAX_ACTIVE_LEVELS=1
export RAMDIR=/dev/shm/\${SLURM_JOBID}
mkdir -p \${RAMDIR}
cd \${RAMDIR}
export GAUSS_SCRDIR=\${RAMDIR}
export SLURM_SCRDIR=\${RAMDIR}
cp ${curdir}/${inpname_xtb} \${RAMDIR}
g16 < ${inpname_xtb} > ${outname}
cp ${outname} ${curdir}
rm -rf \${RAMDIR}
exit " > ${name}.job
sbatch ${name}.job
