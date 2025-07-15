#!/bin/bash
#FLUX: --job-name=reclusive-banana-5778
#FLUX: --priority=16

case=e2000_bn_cirrradbg_rhmini1to1.2_1.5xco2seed18_binprecip_2
create_newcase -case $case -compset 'E_1850_CAM5' -res f19_g16 -mach omega # B_2000_CAM5, B_1850-2000_CAM5, B_RCP8.5_CAM5_CN
cd $case
./xmlchange -file env_build.xml -id CAM_CONFIG_OPTS -val '-phys cam5'
./xmlchange -file env_run.xml -id REST_N -val '1'
./xmlchange -file env_run.xml -id STOP_N -val '100'
./xmlchange -file env_run.xml -id STOP_OPTION -val 'nyears'
./xmlchange -file env_run.xml -id RESUBMIT -val '0'
./xmlchange -file env_build.xml -id CCSMGROUP_SCRATCH -val '/gpfs/scratch60/fas/long'                 # cesm 1.2 (1/1)
cp /home/fas/long/zm56/dustmod/cirrrad_bg/radiation.F90 /home/fas/long/zm56/cesmruns/${case}/SourceMods/src.cam
cp /home/fas/long/zm56/dustmod/barahona_seed18/* /home/fas/long/zm56/cesmruns/${case}/SourceMods/src.cam
cp /home/fas/long/zm56/dustmod/icecldfrac_tune/cldwat2m_macro.F90 /home/fas/long/zm56/cesmruns/${case}/SourceMods/src.cam
cp /home/fas/long/zm56/dustmod/bin_precip/micro_mg_cam.F90 /home/fas/long/zm56/cesmruns/${case}/SourceMods/src.cam
./cesm_setup
cat <<TXT2 >> user_nl_cam
&aerosol_nl
 fincl1 ='DSTSFDRY','DSTSFMBL','DSTSFWET','dst_a1SF', 'dst_a3SF','dst_a1','dst_a3','dst_c1','dst_c3','bc_a1','bc_c1','ncl_a1','ncl_c1','ncl_a2','ncl_c2','ncl_a3','ncl_c3','num_a1','num_c1','num_a2','num_c2','num_a3','num_c3','pom_a1','pom_c1','so4_a1','so4_c1','so4_a2','so4_c2','so4_a3','so4_c3','soa_a1','soa_c1','soa_a2','soa_c2','dst_a1DDF','dst_c1DDF','dst_a3DDF','dst_c3DDF','dst_a1SFWET','dst_c1SFWET','dst_a3SFWET','dst_c3SFWET','CMEIOUT','MNUCCCO','MNUCCTO','MNUCCDO','MNUCCDOhet','BERGO','BERGSO','HOMOO','PRAO','PRCO','PRCIO','PRAIO','WSUBI','NIHF','NIDEP','NIIMM','NIMEY','NCAL','NCAI','FREQS','ADSNOW','FREQS','ANSNOW','AQSNOW','DSNOW','NSNOW','EFFICE','ICINC','ICIMR','ICWNC','ICIMRST','ICIMRCU','ICIMRTOT','MPDQ','MPDT','MPDW2V','MPDW2I','MPDW2P','MPDI2V','MPDI2W','MPDI2P','NDROPSNK','MPDICE','MPDLIQ','QCRESO','QIRESO','MSACWIO','PSACWSO','MELTO','VPRAO','VPRCO','RACAU'
/
rad_diag_1= 'A:Q:H2O','N:O2:O2', 'N:CO2:CO2','N:ozone:O3','N:N2O:N2O','N:CH4:CH4','N:CFC11:CFC11', 'N:CFC12:CFC12','M:mam3_mode1:/apps/hpc/Data/CESM/1.0/inputdata/atm/cam/physprops/mam3_mode1_rrtmg_c110318.nc','M:mam3_mode2:/apps/hpc/Data/CESM/1.0/inputdata/atm/cam/physprops/mam3_mode2_rrtmg_c110318.nc', 'M:mam3_mode3:/apps/hpc/Data/CESM/1.0/inputdata/atm/cam/physprops/mam3_mode3_rrtmg_c110318.nc'
/
&cldfrc_nl
 cldfrc_rhminl = 0.8875D0
/
&chem_inparm
 ext_frc_specifier              = 'SO2         -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so2_elev_2000_c090726.nc',
         'bc_a1       -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_bc_elev_2000_c090726.nc',
         'num_a1      -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a1_elev_2000_c090726.nc',
         'num_a2      -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a2_elev_2000_c090726.nc',
         'pom_a1      -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_oc_elev_2000_c090726.nc',
         'so4_a1      -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a1_elev_2000_c090726.nc',
         'so4_a2      -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a2_elev_2000_c090726.nc'
 srf_emis_specifier             = 'DMS       -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/aerocom_mam3_dms_surf_2000_c090129.nc',
         'SO2       -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so2_surf_2000_c090726.nc',
         'SOAG      -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_soag_1.5_surf_2000_c100217.nc',
         'bc_a1     -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_bc_surf_2000_c090726.nc',
         'num_a1    -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a1_surf_2000_c090726.nc',
         'num_a2    -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_num_a2_surf_2000_c090726.nc',
         'pom_a1    -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_oc_surf_2000_c090726.nc',
         'so4_a1    -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a1_surf_2000_c090726.nc',
         'so4_a2    -> /apps/hpc/Data/CESM/1.0/inputdata/atm/cam/chem/trop_mozart_aero/emis/ar5_mam3_so4_a2_surf_2000_c090726.nc'
 tracer_cnst_cycle_yr           = 2000
 tracer_cnst_file               = 'oxid_1.9x2.5_L26_1850-2005_c091123.nc'
 tracer_cnst_filelist           = 'oxid_1.9x2.5_L26_clim_list.c090805.txt'
/
&prescribed_ozone_nl
 prescribed_ozone_cycle_yr              = 2000
 prescribed_ozone_datapath              = '/apps/hpc/Data/CESM/1.0/inputdata/atm/cam/ozone'
 prescribed_ozone_file          = 'ozone_1.9x2.5_L26_2000clim_c091112.nc'
 prescribed_ozone_name          = 'O3'
 prescribed_ozone_type          = 'CYCLICAL'
/
&chem_surfvals_nl
 ch4vmr         = 1760.0e-9
 co2vmr         = 530.9e-6
 f11vmr         = 653.45e-12
 f12vmr         = 535.0e-12
 flbc_list              = ' '
 n2ovmr         = 316.0e-9
/
TXT2
./xmlchange -file env_run.xml -id DOCN_SOM_FILENAME -val 'pop_frc.b.c40.B1850CN.f19_g16.100105.nc'
./${case}.build
sed -i '9i#SBATCH --exclude=c03n[01-16]' ${case}.run
cp ${case}.run ${case}.run_fas
sed -i "s/#SBATCH --partition=week/#SBATCH --partition=scavenge/" ${case}.run
sed -i "/#SBATCH -A long/d" ${case}.run
cp ${case}.run ${case}.run_scavenge
./${case}.submit
cp ${case}.run_fas ${case}.run
sleep 1m
./${case}.submit
