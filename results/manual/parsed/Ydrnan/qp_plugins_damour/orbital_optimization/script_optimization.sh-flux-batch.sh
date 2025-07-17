#!/bin/bash
#FLUX: --job-name=salted-earthworm-6530
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=xeonv3
#FLUX: --urgency=16

source /home/ydamour/qp2/quantum_package.rc # here 
module load intel/2019.0
module load python/3.7.6-gcc-9.2.0
module load gcc/8.2.0
START_DIR=benzene.ezfio
START_FILE=benzene
qp set_file ${START_DIR}
qp run scf > ${START_DIR}/${START_FILE}.scf.out
qp set_frozen_core >  ${START_DIR}/${START_FILE}.fc.out
XYZ=benzene  # Name
BASIS=cc_pvdz_opt # Basis + options
DIR=${XYZ}_${BASIS}.ezfio # Directory
FILE=${XYZ}_${BASIS} # Base for the filenames
cp -r ${START_DIR} ${DIR}
qp set_file ${DIR} # set the file
qp reset -d        # delete the determinants
qp set determinants read_wf true
qp set determinants mo_label MCSCF
qp set mo_basis mo_label MCSCF
qp set ao_two_e_erf_ints io_ao_two_e_integrals_erf write
qp set determinants s2_eig true
Ndet=5
printf "%10s\n" N_det > ${DIR}/${FILE}_n_det.dat
printf "%15s\n" E_var > ${DIR}/${FILE}_energy.dat
printf "%15s %15s\n" E_PT2 Error_PT2 > ${DIR}/${FILE}_pt2.dat
printf "%15s %15s\n" E_rPT2 Error_rPT2 > ${DIR}/${FILE}_rpt2.dat
printf "%15s\n" E+PT2 > ${DIR}/${FILE}_e_p_pt2.dat
printf "%15s\n" E+rPT2 > ${DIR}/${FILE}_e_p_rpt2.dat
while [ ${Ndet} -lt 200000 ]
do
    qp set determinants n_det_max ${Ndet} # set the new number of determinants for the CIPSI
    qp run fci > ${DIR}/${FILE}_${Ndet}.fci.out # CISPI calculation
	# Some informations from the CISPI
    grep "Summary at N_det = " ${DIR}/${FILE}_${Ndet}.fci.out | tail -1 | awk '{printf "%10s\n", $5}' >> ${DIR}/${FILE}_n_det.dat
    grep "# E   " ${DIR}/${FILE}_${Ndet}.fci.out | tail -1 | awk '{printf "%15s\n", $3}' >> ${DIR}/${FILE}_energy.dat
    grep "# PT2   " ${DIR}/${FILE}_${Ndet}.fci.out | tail -1 | awk '{printf "%15s %15s\n", $3, $4}' >> ${DIR}/${FILE}_pt2.dat
    grep "# rPT2   " ${DIR}/${FILE}_${Ndet}.fci.out | tail -1 | awk '{printf "%15s %15s\n", $3, $4}' >> ${DIR}/${FILE}_rpt2.dat
	grep "# E+PT2   " ${DIR}/${FILE}_${Ndet}.fci.out | tail -1 | awk '{printf "%15s\n", $3}' >> ${DIR}/${FILE}_e_p_pt2.dat
    grep "# E+rPT2   " ${DIR}/${FILE}_${Ndet}.fci.out | tail -1 | awk '{printf "%15s\n", $3}' >> ${DIR}/${FILE}_e_p_rpt2.dat
    qp run orb_opt_trust > ${DIR}/${FILE}_opt_trash_${Ndet}.dat # Orbital optimization
    # Evolution of the energy during the optimization
    echo "Evolution of the energy during the orbital optimization for" ${Ndet} "determinants" > ${DIR}/${FILE}_opt_energy_${Ndet}.dat
    grep "Energy of state    1" ${DIR}/${FILE}_opt_trash_${Ndet}.dat | awk '{print $6}' >> ${DIR}/${FILE}_opt_energy_${Ndet}.dat
    qp run pt2 > ${DIR}/${FILE}_${Ndet}.pt2.out # Calculation after the optimization
	# Some informations from the new calculations
    grep "Summary at N_det = " ${DIR}/${FILE}_${Ndet}.pt2.out | tail -1 | awk '{printf "%10s\n", $5}' >> ${DIR}/${FILE}_n_det.dat
    grep "# E   " ${DIR}/${FILE}_${Ndet}.pt2.out | tail -1 | awk '{printf "%15s\n", $3}' >> ${DIR}/${FILE}_energy.dat
    grep "# PT2   " ${DIR}/${FILE}_${Ndet}.pt2.out | tail -1 | awk '{printf "%15s %15s\n", $3, $4}' >> ${DIR}/${FILE}_pt2.dat
    grep "# rPT2   " ${DIR}/${FILE}_${Ndet}.pt2.out | tail -1 | awk '{printf "%15s %15s\n", $3, $4}' >> ${DIR}/${FILE}_rpt2.dat
    grep "# E+PT2   " ${DIR}/${FILE}_${Ndet}.pt2.out | tail -1 | awk '{printf "%15s\n", $3}' >> ${DIR}/${FILE}_e_p_pt2.dat
    grep "# E+rPT2   " ${DIR}/${FILE}_${Ndet}.pt2.out | tail -1 | awk '{printf "%15s\n", $3}' >> ${DIR}/${FILE}_e_p_rpt2.dat
Ndet=$[${Ndet}*2] # Ndet = Ndet * 2
done
paste ${DIR}/${FILE}_n_det.dat ${DIR}/${FILE}_energy.dat > ${DIR}/${FILE}_tmp1.dat
paste ${DIR}/${FILE}_tmp1.dat ${DIR}/${FILE}_pt2.dat > ${DIR}/${FILE}_tmp2.dat
paste ${DIR}/${FILE}_tmp2.dat ${DIR}/${FILE}_rpt2.dat > ${DIR}/${FILE}_tmp3.dat
paste ${DIR}/${FILE}_tmp3.dat ${DIR}/${FILE}_e_p_pt2.dat > ${DIR}/${FILE}_tmp4.dat
paste ${DIR}/${FILE}_tmp4.dat ${DIR}/${FILE}_e_p_rpt2.dat > ${DIR}/${FILE}_result_opt.dat
DIR2=${FILE}_cipsi.ezfio # Dir
FILE2=${FILE}_cipsi # Base for the filenames
cp -r ${DIR} ${DIR2} 
qp set_file ${DIR2}
qp reset -d # delete the determinants in order to do a clean CIPSI
qp set determinants n_det_max 2e6 # max number of determinants
qp run fci > ${DIR2}/${FILE2}.fci.out # CIPSI
printf "%10s\n" N_det > ${DIR2}/${FILE2}_n_det.dat
printf "%15s\n" E_var > ${DIR2}/${FILE2}_energy.dat
printf "%15s %15s\n" E_PT2 Error_PT2 > ${DIR2}/${FILE2}_pt2.dat
printf "%15s %15s\n" E_rPT2 Error_rPT2 > ${DIR2}/${FILE2}_rpt2.dat
printf "%15s\n" E+PT2 > ${DIR2}/${FILE2}_e_p_pt2.dat
printf "%15s\n" E+rPT2 > ${DIR2}/${FILE2}_e_p_rpt2.dat
grep "Summary at N_det = " ${DIR2}/${FILE2}.fci.out | awk '{printf "%10s\n", $5}' >> ${DIR2}/${FILE2}_n_det.dat
grep "# E   " ${DIR2}/${FILE2}.fci.out | awk '{printf "%15s\n", $3}' >> ${DIR2}/${FILE2}_energy.dat
grep "# PT2   " ${DIR2}/${FILE2}.fci.out | awk '{printf "%15s %15s\n", $3, $4}' >> ${DIR2}/${FILE2}_pt2.dat
grep "# rPT2   " ${DIR2}/${FILE2}.fci.out | awk '{printf "%15s %15s\n", $3, $4}' >> ${DIR2}/${FILE2}_rpt2.dat
grep "# E+PT2   " ${DIR2}/${FILE2}.fci.out | awk '{printf "%15s\n", $3}' >> ${DIR2}/${FILE2}_e_p_pt2.dat
grep "# E+rPT2   " ${DIR2}/${FILE2}.fci.out | awk '{printf "%15s\n", $3}' >> ${DIR2}/${FILE2}_e_p_rpt2.dat
paste ${DIR2}/${FILE2}_n_det.dat ${DIR2}/${FILE2}_energy.dat > ${DIR2}/${FILE2}_tmp1.dat
paste ${DIR2}/${FILE2}_tmp1.dat ${DIR2}/${FILE2}_pt2.dat > ${DIR2}/${FILE2}_tmp2.dat
paste ${DIR2}/${FILE2}_tmp2.dat ${DIR2}/${FILE2}_rpt2.dat > ${DIR2}/${FILE2}_tmp3.dat
paste ${DIR2}/${FILE2}_tmp3.dat ${DIR2}/${FILE2}_e_p_pt2.dat > ${DIR2}/${FILE2}_tmp4.dat
paste ${DIR2}/${FILE2}_tmp4.dat ${DIR2}/${FILE2}_e_p_rpt2.dat > ${DIR2}/${FILE2}_result_fci.dat
