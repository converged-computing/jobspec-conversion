#!/bin/bash
#FLUX: --job-name=stanky-leader-1559
#FLUX: --urgency=16

. "$script_pwd/../systems/generic"
SUPERMUC_OPENMPI_VERSION="4.1.5-gcc12"
SUPERMUC_IMPI_VERSION="2021.9.0"
SUPERMUC_TBB_VERSION="2021.10.0"
SUPERMUC_GCC_VERSION="13.1.0"
SUPERMUC_CMAKE_VERSION="3.26.3"
SUPERMUC_BOOST_VERSION="1.82.0-gcc12-impi" 
_ExecRsyncCommand() {
    if command -v sshpass; then
        if [[ ${SUPERMUC_PASS:-""} != "" ]]; then 
            sshpass -p "$SUPERMUC_PASS" $cmd
        else
            eval $cmd
        fi
    else
        eval $cmd
    fi
}
UploadExperiment() {
    if [[ "${_username}" == "" ]]; then
        echo "Error: provide username via the Username command, e.g., Username skx1234"
        exit 1
    fi
    dir="$(pwd)"
    name=${dir##*/}
    cmd='rsync -rutvP --cvs-exclude . '$_username'@skx.supermuc.lrz.de:~/'$name
    _ExecRsyncCommand "$cmd"
}
DownloadExperiment() {
    if [[ "${_username}" == "" ]]; then
        echo "Error: provide username via the Username command, e.g., Username skx1234"
        exit 1
    fi
    dir="$(pwd)"
    name=${dir##*/}
    cmd='rsync -rutvP --cvs-exclude '$_username'@skx.supermuc.lrz.de:~/'$name'/ .'
    _ExecRsyncCommand "$cmd"
}
SetupBuildEnv() {
    module purge || true
    module load spack/23.1.0
    module load intel-toolkit/2023.2.0 || true
    module load intel-tbb/${SUPERMUC_TBB_VERSION}
    module unload intel/2023.2.0
    module load gcc/${SUPERMUC_GCC_VERSION}
    if [[ "$_mpi" == "OpenMPI" ]]; then
        module unload intel-mpi
        module load openmpi/${SUPERMUC_OPENMPI_VERSION}
    elif [[ "$_mpi" == "IMPI" ]]; then
        module unload intel-mpi
        module load intel-mpi/${SUPERMUC_IMPI_VERSION}
    fi
    module load cmake/${SUPERMUC_CMAKE_VERSION}
    module load boost/${SUPERMUC_BOOST_VERSION}
}
GenerateJobfileHeader() {
    local -n args=$1
    if (( $((args[num_mpis] * args[num_threads])) > 48 )); then 
        >&2 echo "Error: too many MPI processes * threads"
        exit 1
    fi
    if [[ $_project == "" ]]; then
        >&2 echo "Error: no project specified"
        exit 1
    fi
    echo "#!/bin/bash"
    echo "#SBATCH --nodes=${args[num_nodes]}"
    echo "#SBATCH --ntasks=$((args[num_nodes]*args[num_mpis]))"
    echo "#SBATCH --cpus-per-task=${args[num_threads]}"
    echo "#SBATCH --ntasks-per-node=${args[num_mpis]}"
    echo "#SBATCH --switches=1"
    echo "#SBATCH --ear=off"
    echo "#SBATCH --account=$_project"
    echo "#SBATCH --time=${args[timelimit]}"
    if [[ "$_partition" == "" ]]; then 
        if (( ${args[num_nodes]} < 17 )); then
            partition="micro"
        elif (( ${args[num_nodes]} < 769 )); then
            partition="general"
        else
            partition="large"
        fi
    else 
        partition="$_partition"
    fi
    echo "#SBATCH --partition=$partition"
    echo "module restore benchmark_mod_set"
    echo "unset OMP_NUM_THREADS"
    echo "unset OMP_PROC_BIND"
    echo "unset OMP_PLACES"
}
GenerateJobfileEntry() {
    local -n args=$1
    case "${args[mpi]}" in
        none)
            >&2 echo "Error: application must be run with MPI"
            exit 1
            ;;
        OpenMPI)
            echo "mpirun -n $((args[num_nodes]*args[num_mpis])) --bind-to core --map-by socket:PE=${args[num_threads]} ${args[exe]}"
            ;;
        IMPI)
            if [[ "${args[timeout]}" != "0" ]]; then 
                echo -n "I_MPI_JOB_TIMEOUT=${args[timeout]} "
            fi
            echo "mpiexec -n $((args[num_nodes]*args[num_mpis])) --perhost ${args[num_mpis]} ${args[exe]}"
            ;;
        *)
            >&2 echo "Error: unsupported MPI ${args[mpi]}"
            exit 1
    esac
}
GenerateJobfileSubmission() {
    for jobfile in ${@}; do 
        echo "sbatch $jobfile"
    done
}
