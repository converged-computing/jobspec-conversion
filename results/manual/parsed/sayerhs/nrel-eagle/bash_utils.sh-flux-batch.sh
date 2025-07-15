#!/bin/bash
#FLUX: --job-name=JOBNAME
#FLUX: -t=172800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

hpacf_modules ()
{
    local compiler=${1:-gcc}
    local moddate=${2:-modules}
    local hpacf_modules_dir=/nopt/nrel/ecom/hpacf
    # Remove existing modules
    module purge
    # Remove previously loaded paths to avoid clashes
    if [ ! -z "$MODULEPATH" ] ; then
        module unuse $MODULEPATH
    fi
    # Load HPACF modules
    module use ${hpacf_modules_dir}/binaries/${moddate}
    module use ${hpacf_modules_dir}/compilers/${moddate}
    module use ${hpacf_modules_dir}/utilities/${moddate}
    module use ${hpacf_modules_dir}/software/${moddate}/${compiler}*
    echo "==> Using modules: $(readlink -f ${hpacf_modules_dir}/software/${moddate}/${compiler})"
}
ijob ()
{
    local nodes=1
    local queue=" "
    local walltime="04:00:00"
    local gpu_args=" "
    local account=hfm
    OPTIND=1
    while getopts ":N:q:t:gh" opt; do
        case "$opt" in
            h|\?)
                echo "Usage: ijob [-N nodes] [-t walltime] [-q queue] [-g] [-- other_opts]"
                return
                ;;
            N)
                nodes=$OPTARG
                ;;
            q)
                queue="-p $OPTARG"
                ;;
            t)
                walltime=$OPTARG
                ;;
            g)
                gpu_args="--gres=gpu:2"
                ;;
        esac
    done
    shift $((OPTIND-1))
    [ "$1" == "--" ] && shift
    local cmd="salloc -N ${nodes} -t ${walltime} -A ${account} ${queue} ${gpu_args} --exclusive $@"
    echo "${cmd}"
    eval "${cmd}"
}
job_script ()
{
    local outfile=${1:-submit_script.slurm}
    cat <<'EOF' > ${outfile}
hpacf_modules
ranks_per_node=36
mpi_ranks=$(expr $SLURM_JOB_NUM_NODES \* $ranks_per_node)
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
echo "Job name       = $SLURM_JOB_NAME"
echo "Num. nodes     = $SLURM_JOB_NUM_NODES"
echo "Num. MPI Ranks = $mpi_ranks"
echo "Num. threads   = $OMP_NUM_THREADS"
echo "Working dir    = $PWD"
srun -n ${mpi_ranks} -c ${OMP_NUM_THREADS} --cpu-bind=cores COMMAND
EOF
    echo "==> Created job script: ${outfile}"
}
alias qinfo="sinfo -o '%24P %.5a  %.12l  %.16F %G'"
alias myjobs="squeue -u ${USER} -o '%12i %20j %.6D %.2t %.10M %.9P %r'"
