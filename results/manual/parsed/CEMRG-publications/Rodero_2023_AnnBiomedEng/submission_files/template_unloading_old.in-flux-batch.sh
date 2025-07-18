#!/bin/bash
#FLUX: --job-name=JOBNAME
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

NPROC=128
source ${HOME}/.bashrc
export OMP_NUM_THREADS=1
solver_folder="/scratch/crg17/solver_files/resources"
meshes_folder="/scratch/crg17/meshes"
case_num=42HC
alpha_method=0
JOBNAME=
mpiexec -np $NPROC $CARPENTRYDIR/carp.pt \
  +F $solver_folder/options/pt_ell_amg_large \
  +F $solver_folder/options/pt_para_amg_large \
  +F $solver_folder/options/pt_mech_amg_large \
  -ellip_use_pt 1 \
  -parab_use_pt 1 \
  -purk_use_pt 0 \
  -mech_use_pt 1 \
  -ellip_options_file $solver_folder/options/pt_ell_amg_large \
  -parab_options_file $solver_folder/options/pt_para_amg_large \
  -purk_options_file $solver_folder/petsc_options/mumps_opts_nonsymmetric \
  -mechanics_options_file $solver_folder/options/pt_mech_amg_large \
  -vectorized_fe 0 \
  -mech_finite_element 0 \
  -simID $JOBNAME \
  -meshname $meshes_folder/$case_num/heart_case$case_num"_800um" \
  -timedt 1.0 \
  -mechDT 1.0 \
  -spacedt 1 \
  -tend 1000.0 \
  -loadStepping 50.0 \
  -num_mechanic_nbc 9 \
  -num_mechanic_bs 7 \
  -mechanic_bs[0].value 0.001 \
  -mechanic_bs[1].value 0.0 \
  -mechanic_bs[2].value 0.0 \
  -mechanic_bs[3].value 0.001 \
  -mechanic_bs[4].value 0.001 \
  -mechanic_bs[5].value 0.0 \
  -mechanic_nbc[0].name LSPV \
  -mechanic_nbc[0].surf_file $meshes_folder/$case_num/LS_pulm_vein \
  -mechanic_nbc[0].spring_idx 0 \
  -mechanic_nbc[1].name LIPV \
  -mechanic_nbc[1].surf_file $meshes_folder/$case_num/LI_pulm_vein \
  -mechanic_nbc[1].spring_idx 1 \
  -mechanic_nbc[2].name RIPV \
  -mechanic_nbc[2].surf_file $meshes_folder/$case_num/RI_pulm_vein \
  -mechanic_nbc[2].spring_idx 2 \
  -mechanic_nbc[3].name RSPV \
  -mechanic_nbc[3].surf_file $meshes_folder/$case_num/RS_pulm_vein \
  -mechanic_nbc[3].spring_idx 3 \
  -mechanic_nbc[4].name SVC \
  -mechanic_nbc[4].surf_file $meshes_folder/$case_num/SVC \
  -mechanic_nbc[4].spring_idx 4 \
  -mechanic_nbc[5].name IVC \
  -mechanic_nbc[5].surf_file $meshes_folder/$case_num/IVC \
  -mechanic_nbc[5].spring_idx 5 \
  -mechanic_nbc[6].name LV_endo \
  -mechanic_nbc[6].surf_file $meshes_folder/$case_num/LV_endo \
  -mechanic_nbc[6].pressure 1.6 \
  -mechanic_nbc[7].name RV_endo \
  -mechanic_nbc[7].surf_file $meshes_folder/$case_num/RV_endo \
  -mechanic_nbc[7].pressure 0.8 \
  -num_mechanic_ed 1 \
  -mechanic_ed[0].ncomp 1 \
  -mechanic_ed[0].file $meshes_folder/$case_num/PM_$case_num \
  -mechanic_bs[6].edidx 0 \
  -mechanic_bs[6].value 0.001 \
  -mechanic_nbc[8].name Pericardium \
  -mechanic_nbc[8].surf_file $meshes_folder/$case_num/epicardium_ventricles \
  -mechanic_nbc[8].spring_idx 6 \
  -mechanic_nbc[8].nspring_idx 0 \
  -mechanic_nbc[8].nspring_config 1 \
  -numSurfVols 4 \
  -surfVols[0].name LV_endo \
  -surfVols[0].surf_file $meshes_folder/$case_num/LV_endo \
  -surfVols[0].grid 8 \
  -surfVols[1].name RV_endo \
  -surfVols[1].surf_file $meshes_folder/$case_num/RV_endo \
  -surfVols[1].grid 8 \
  -surfVols[2].name LA_endo \
  -surfVols[2].surf_file $meshes_folder/$case_num/LA_endo \
  -surfVols[2].grid 8 \
  -surfVols[3].name RA_endo \
  -surfVols[3].surf_file $meshes_folder/$case_num/RA_endo \
  -surfVols[3].grid 8 \
  -num_mregions 7 \
  -mregion[0].name "Ventricles" \
  -mregion[0].num_IDs 4 \
  -mregion[0].ID[0] 1 \
  -mregion[0].ID[1] 2 \
  -mregion[0].ID[2] 25 \
  -mregion[0].ID[3] 26 \
  -mregion[0].params "kappa=1000,b_f=8.0,b_fs=4.0,b_t=3.0,a=1.7" \
  -mregion[0].type 9 \
  -mregion[1].name "Atria" \
  -mregion[1].num_IDs 2 \
  -mregion[1].ID[0] 3 \
  -mregion[1].ID[1] 4 \
  -mregion[1].params "kappa=1000,c=7.45" \
  -mregion[1].type 2 \
  -mregion[2].name "Valve planes" \
  -mregion[2].num_IDs 4 \
  -mregion[2].ID[0] 7 \
  -mregion[2].ID[1] 8 \
  -mregion[2].ID[2] 9 \
  -mregion[2].ID[3] 10 \
  -mregion[2].params "kappa=1000,c=1000.0" \
  -mregion[2].type 2 \
  -mregion[3].name "Inlet planes" \
  -mregion[3].num_IDs 7 \
  -mregion[3].ID[0] 11 \
  -mregion[3].ID[1] 12 \
  -mregion[3].ID[2] 13 \
  -mregion[3].ID[3] 14 \
  -mregion[3].ID[4] 15 \
  -mregion[3].ID[5] 16 \
  -mregion[3].ID[6] 17 \
  -mregion[3].params "kappa=1000,c=1000.0" \
  -mregion[3].type 2 \
  -mregion[4].name "Aorta" \
  -mregion[4].num_IDs 1 \
  -mregion[4].ID[0] 5 \
  -mregion[4].params "kappa=1000,c=26.66" \
  -mregion[4].type 2 \
  -mregion[5].name "Pulm_Artery" \
  -mregion[5].num_IDs 1 \
  -mregion[5].ID[0] 6 \
  -mregion[5].params "kappa=1000,c=3.7" \
  -mregion[5].type 2 \
  -mregion[6].name "BC Veins" \
  -mregion[6].num_IDs 7 \
  -mregion[6].ID[0] 18 \
  -mregion[6].ID[1] 19 \
  -mregion[6].ID[2] 20 \
  -mregion[6].ID[3] 21 \
  -mregion[6].ID[4] 22 \
  -mregion[6].ID[5] 23 \
  -mregion[6].ID[6] 24 \
  -mregion[6].params "kappa=1000,c=7.45" \
  -mregion[6].type 2 \
  -mech_vol_split_aniso 1 \
  -volumeTracking 1 \
  -numElemVols 1 \
  -elemVols[0].name tissue \
  -elemVols[0].grid 8 \
  -pstrat 1 \
  -pstrat_i 1 \
  -krylov_tol_mech 1e-10 \
  -krylov_norm_mech 0 \
  -krylov_maxit_mech 5000 \
  -newton_atol_mech 1e-06 \
  -newton_tol_mech 1e-08 \
  -newton_adaptive_tol_mech 2 \
  -newton_tol_cvsys 1e-06 \
  -newton_line_search 0 \
  -newton_maxit_mech 20 \
  -num_stim 1 \
  -stimulus[0].stimtype 8 \
  -stimulus[0].data_file $meshes_folder/$case_num/$case_num"_vm_act_seq.dat" \
  -diffusionOn 0 \
  -num_imp_regions 1 \
  -num_stim 0 \
  -imp_region[0].name passive \
  -imp_region[0].im PASSIVE \
  -imp_region[0].num_IDs 26 \
  -imp_region[0].ID[0] 1 \
  -imp_region[0].ID[1] 2 \
  -imp_region[0].ID[2] 3 \
  -imp_region[0].ID[3] 4 \
  -imp_region[0].ID[4] 5 \
  -imp_region[0].ID[5] 6 \
  -imp_region[0].ID[6] 7 \
  -imp_region[0].ID[7] 8 \
  -imp_region[0].ID[8] 9 \
  -imp_region[0].ID[9] 10 \
  -imp_region[0].ID[10] 11 \
  -imp_region[0].ID[11] 12 \
  -imp_region[0].ID[12] 13 \
  -imp_region[0].ID[13] 14 \
  -imp_region[0].ID[14] 15 \
  -imp_region[0].ID[15] 16 \
  -imp_region[0].ID[16] 17 \
  -imp_region[0].ID[17] 18 \
  -imp_region[0].ID[18] 19 \
  -imp_region[0].ID[19] 20 \
  -imp_region[0].ID[20] 21 \
  -imp_region[0].ID[21] 22 \
  -imp_region[0].ID[22] 23 \
  -imp_region[0].ID[23] 24 \
  -imp_region[0].ID[24] 25 \
  -imp_region[0].ID[25] 26 \
  -gridout_i 0 \
  -mech_output 1 \
  -strain_value 0 \
  -stress_value 0 \
  -experiment 5 \
  -loadStepping 50.0 \
  -unload_conv 0 \
  -unload_tol 0.001 \
  -unload_err 1 \
  -unload_maxit 10 \
  -unload_stagtol 10.0
