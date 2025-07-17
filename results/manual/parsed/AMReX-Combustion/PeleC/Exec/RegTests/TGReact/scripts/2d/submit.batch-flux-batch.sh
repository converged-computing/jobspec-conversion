#!/bin/bash
#FLUX: --job-name=pelec_tgreact
#FLUX: -t=172800
#FLUX: --urgency=16

source ../set_environment.sh
mpi_ranks=8
echo "Num. MPI Ranks = $mpi_ranks"
pele_exec=${dirname}/PeleC2d.intel.MPI.ex
iname="inputs_2d.inp"
input="${dirname}/${iname}"
cd "${dirname}" || exit
make realclean
make -j ${ranks_per_node} DIM=2 USE_MPI=TRUE COMP=intel
cd "${paren}" || exit
resolutions=(32 64 128 256)
for res in "${resolutions[@]}"
do
    # Setup directory and files
    workdir="${paren}/${res}"
    mkdir -p "${workdir}"
    cd "${workdir}" || exit
    cp "${input}" "${workdir}"
    cp "${pele_exec}" "${workdir}/PeleC"
    rm -rf plt* chk* datlog extralog ic.txt data
    sed -i "/amr.n_cell/c\amr.n_cell=${res} ${res}" "${iname}"
    # Run Pele
    srun -n "${mpi_ranks}" -c 1 --cpu_bind=cores "${workdir}/PeleC" "${iname}" > run.out
    # Post process
    visit -nowin -cli -s "${dirname}/visit_pp_aux_vars.py" -i "${iname}"
    # Clean
    cd "${paren}" || exit
done
