#!/bin/bash
#FLUX: --job-name=purple-leader-4285
#FLUX: -N=6
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'
export ICON_THREADS='4'
export OMP_SCHEDULE='dynamic,1'
export OMP_DYNAMIC='false'
export OMP_STACKSIZE='200M'

set -x
export OMP_NUM_THREADS=4
export ICON_THREADS=4
export OMP_SCHEDULE=dynamic,1
export OMP_DYNAMIC="false"
export OMP_STACKSIZE=200M
mpi_root=/opt/mpi/bullxmpi_mlx/1.2.8.3
no_of_nodes=${SLURM_JOB_NUM_NODES:-1}
mpi_procs_pernode=12
((mpi_total_procs=no_of_nodes * mpi_procs_pernode))
START="srun --cpu-freq=2500000 --kill-on-bad-exit=1 --nodes=${SLURM_JOB_NUM_NODES:-1} --cpu_bind=verbose,cores --distribution=block:block --ntasks=$((no_of_nodes * mpi_procs_pernode)) --ntasks-per-node=${mpi_procs_pernode} --cpus-per-task=${OMP_NUM_THREADS} --propagate=STACK --mpi=openmpi"
cd ${SLURM_SUBMIT_DIR}
basedir=${SLURM_SUBMIT_DIR}/../
GRIDDIR=/pool/data/ICON/grids/public/edzw
INDATADIR=/pool/data/ICON/grids/private/m222072/initdata_R2B6N7
EXTPARDIR=/pool/data/ICON/grids/public/edzw
bindir="${basedir}/build/x86_64-unknown-linux-gnu/bin"   # binaries
EXPNAME=icon-nwp-test
EXPDIR=${basedir}/experiments/${EXPNAME}
MODEL=$bindir/icon
if [ ! -d $EXPDIR ]; then
    mkdir -p $EXPDIR
fi
cd ${EXPDIR}
ln -sf $GRIDDIR/icon_grid_0023_R02B05_R.nc iconR2B05_DOM00.nc
ln -sf $GRIDDIR/icon_grid_0023_R02B05_R-grfinfo.nc iconR2B05_DOM00-grfinfo.nc
ln -sf $GRIDDIR/icon_grid_0024_R02B06_G.nc iconR2B06_DOM01.nc
ln -sf $GRIDDIR/icon_grid_0024_R02B06_G-grfinfo.nc iconR2B06_DOM01-grfinfo.nc
ln -sf $GRIDDIR/icon_grid_0028_R02B07_N02.nc iconR2B07_DOM02.nc
ln -sf $GRIDDIR/icon_grid_0028_R02B07_N02-grfinfo.nc iconR2B07_DOM02-grfinfo.nc
ln -sf $EXTPARDIR/icon_extpar_0024_R02B06_G_20150805_tiles.nc extpar_iconR2B06_DOM01.nc
ln -sf $EXTPARDIR/icon_extpar_0028_R02B07_N02_20150805_tiles.nc extpar_iconR2B07_DOM02.nc
ln -sf $INDATADIR/prepiconR2B06_DOM01_2012062000.nc ifs2icon_R2B06_DOM01.nc
ln -sf $INDATADIR/prepiconR2B07_DOM02_2012062000.nc ifs2icon_R2B07_DOM02.nc
ln -sf ${basedir}/data/ECHAM6_CldOptProps.nc .
ln -sf ${basedir}/data/rrtmg_lw.nc .
cp -p $MODEL icon
atmo_dyn_grids="iconR2B06_DOM01.nc iconR2B07_DOM02.nc"
atmo_rad_grids="iconR2B05_DOM00.nc"
dynamics_grid_filename=""
for gridfile in ${atmo_dyn_grids}; do
  dynamics_grid_filename="${dynamics_grid_filename} '${gridfile}',"
done
radiation_grid_filename=""
for gridfile in ${atmo_rad_grids}; do
  radiation_grid_filename="${radiation_grid_filename} '${gridfile}',"
done
cat > icon_master.namelist << EOF
! master_nml: ----------------------------------------------------------------
&master_nml
 lrestart                   =                      .FALSE.        ! .TRUE.=current experiment is resumed
/
! master_model_nml: repeated for each model ----------------------------------
&master_model_nml
 model_type                  =                          1         ! identifies which component to run (atmosphere,ocean,...)
 model_name                  =                      "ATMO"        ! character string for naming this component.
 model_namelist_filename     =              "NAMELIST_NWP"        ! file name containing the model namelists
 model_min_rank              =                          1         ! start MPI rank for this model
 model_max_rank              =                      65536         ! end MPI rank for this model
 model_inc_rank              =                          1         ! stride of MPI ranks
/
! time_nml: specification of date and time------------------------------------
&time_nml
 ini_datetime_string         =      "2012-06-20T00:00:00Z"        ! initial date and time of the simulation
/
EOF
cat > NAMELIST_NWP << EOF
! parallel_nml: MPI parallelization -------------------------------------------
&parallel_nml
 nproma                      =                         16         ! loop chunk length
 p_test_run                  =                     .FALSE.        ! .TRUE. means verification run for MPI parallelization
 num_io_procs                =                          1         ! number of I/O processors
 num_restart_procs           =                          0         ! number of restart processors
 iorder_sendrecv             =                          3         ! sequence of MPI send/receive calls
/
! run_nml: general switches ---------------------------------------------------
&run_nml
 ltestcase                   =                     .FALSE.        ! idealized testcase runs
 num_lev                     =                     90, 56         ! number of full levels (atm.) for each domain
 lvert_nest                  =                      .TRUE.        ! vertical nesting
 nsteps                      =                        120         ! number of time steps of this run
 dtime                       =                        360         ! timestep in seconds
 ldynamics                   =                      .TRUE.        ! compute adiabatic dynamic tendencies
 ltransport                  =                      .TRUE.        ! compute large-scale tracer transport
 ntracer                     =                          5         ! number of advected tracers
 iforcing                    =                          3         ! forcing of dynamics and transport by parameterized processes
 msg_level                   =                         12         ! controls how much printout is written during runtime
 ltimer                      =                      .TRUE.        ! timer for monitoring the runtime of specific routines
 timers_level                =                         10         ! performance timer granularity
 output                      =                       "nml"        ! main switch for enabling/disabling components of the model output
/
! diffusion_nml: horizontal (numerical) diffusion ----------------------------
&diffusion_nml
 hdiff_order                 =                          5         ! order of nabla operator for diffusion
 itype_vn_diffu              =                          1         ! reconstruction method used for Smagorinsky diffusion
 itype_t_diffu               =                          2         ! discretization of temperature diffusion
 hdiff_efdt_ratio            =                         36.0       ! ratio of e-folding time to time step 
 hdiff_smag_fac              =                          0.015     ! scaling factor for Smagorinsky diffusion
 lhdiff_vn                   =                      .TRUE.        ! diffusion on the horizontal wind field
 lhdiff_temp                 =                      .TRUE.        ! diffusion on the temperature field
/
! dynamics_nml: dynamical core -----------------------------------------------
&dynamics_nml
 iequations                  =                          3         ! type of equations and prognostic variables
 idiv_method                 =                          1         ! method for divergence computation
 divavg_cntrwgt              =                          0.50      ! weight of central cell for divergence averaging
 lcoriolis                   =                      .TRUE.        ! Coriolis force
/
! extpar_nml: external data --------------------------------------------------
&extpar_nml
 extpar_filename             =  "<path>extpar_<gridfile>"         ! filename of external parameter input file
 itopo                       =                          1         ! topography (0:analytical)
 n_iter_smooth_topo          =                          1         ! iterations of topography smoother
 heightdiff_threshold        =                       3000.0       ! height difference between neighb. grid points
/
! initicon_nml: specify read-in of initial state ------------------------------
&initicon_nml
  zpbl1                      =                        500.0       ! bottom height of layer used for gradient computation
  zpbl2                      =                       1000.0       ! top height of layer used for gradient computation
/
! grid_nml: horizontal grid --------------------------------------------------
&grid_nml
 dynamics_grid_filename      =  ${dynamics_grid_filename}         ! array of the grid filenames for the dycore
 radiation_grid_filename     = ${radiation_grid_filename}         ! array of the grid filenames for the radiation model
 dynamics_parent_grid_id     =                       0, 1         ! array of the indexes of the parent grid filenames
 lredgrid_phys               =               .TRUE.,.TRUE.        ! .true.=radiation is calculated on a reduced grid
 lfeedback                   =                      .TRUE.        ! specifies if feedback to parent grid is performed
 ifeedback_type              =                          2         ! feedback type (incremental/relaxation-based)
/
! gridref_nml: grid refinement and nesting -----------------------------------
&gridref_nml
 grf_intmethod_e             =                          6         ! interpolation method for grid refinement
 grf_scalfbk                 =                          2         ! feedback method for dynamical scalar variables
 grf_tracfbk                 =                          2         ! feedback method for tracer variables
 denom_diffu_v               =                        150.0       ! Denominator for lateral boundary diffusion of velocity
/
! io_nml: general switches for model I/O -------------------------------------
&io_nml
 dt_diag                     =                      21600.0       ! diagnostic integral output interval
 dt_checkpoint               =                     864000.0       ! time interval for writing restart files.
 itype_pres_msl              =                          2         ! method for computation of mean sea level pressure
/
! nonhydrostatic_nml: nonhydrostatic model -----------------------------------
&nonhydrostatic_nml
 iadv_rhotheta               =                          2         ! advection method for rho and rhotheta
 ivctype                     =                          2         ! type of vertical coordinate
 itime_scheme                =                          4         ! time integration scheme
 exner_expol                 =                          0.333     ! temporal extrapolation of Exner function
 vwind_offctr                =                          0.2       ! off-centering in vertical wind solver
 damp_height                 =                      50000.0       ! height at which Rayleigh damping of vertical wind starts
 rayleigh_coeff              =                          0.10      ! Rayleigh damping coefficient
 ndyn_substeps               =                          5         ! number of dynamical core substeps
 lhdiff_rcf                  =                      .TRUE.        ! .TRUE.=compute diffusion only at advection time steps
 divdamp_order               =                          4         ! order of divergence damping
 l_open_ubc                  =                     .FALSE.        ! .TRUE.=use open upper boundary condition
 igradp_method               =                          3         ! discretization of horizontal pressure gradient
 l_zdiffu_t                  =                      .TRUE.        ! specifies computation of Smagorinsky temperature diffusion
 thslp_zdiffu                =                          0.02      ! slope threshold (temperature diffusion)
 thhgtd_zdiffu               =                        125.0       ! threshold of height difference (temperature diffusion)
 htop_moist_proc             =                      22500.0       ! max. height for moist physics
 hbot_qvsubstep              =                      19500.0       ! height above which QV is advected with substepping scheme
/
! nwp_phy_nml: switches for the physics schemes ------------------------------
&nwp_phy_nml
 inwp_gscp                   =                          1         ! cloud microphysics and precipitation
 inwp_convection             =                          1         ! convection
 inwp_radiation              =                          1         ! radiation
 inwp_cldcover               =                          1         ! cloud cover scheme for radiation
 inwp_turb                   =                          1         ! vertical diffusion and transfer
 inwp_satad                  =                          1         ! saturation adjustment
 inwp_sso                    =                          1         ! subgrid scale orographic drag
 inwp_gwd                    =                          1         ! non-orographic gravity wave drag
 inwp_surface                =                          1         ! surface scheme
 latm_above_top              =              .FALSE.,.TRUE.        ! take into account atmosphere above model top for radiation computation
 efdt_min_raylfric           =                       7200.0       ! minimum e-folding time of Rayleigh friction
 itype_z0                    =                          2         ! type of roughness length data
/
! output_nml: specifies an output stream --------------------------------------
&output_nml
 filetype                    =                          4         ! output format: 2=GRIB2, 4=NETCDFv2
 dom                         =                         -1         ! write all domains
 output_bounds               =       0., 10000000., 10800.        ! output: start, end, increment
 steps_per_file              =                          2         ! number of output steps in one output file
 mode                        =                          1         ! 1: forecast mode (relative t-axis), 2: climate mode (absolute t-axis)
 include_last                =                      .TRUE.        ! flag whether to include the last time step
 output_filename             =                       'NWP'        ! file name base
 output_grid                 =                      .TRUE.        ! flag whether grid information is added to output.
 !
 ml_varlist                  =  'u', 'v', 'w', 'temp', 'pres','topography_c', 'pres_msl', 
                                'qv', 'qc', 'qi', 'qr', 'qs', 'tke',                      
                                'tkvm', 'tkvh', 'group:pbl_vars',                         
                                'group:precip_vars',  'group:additional_precip_vars',     
                                'group:land_vars', 'group:land_tile_vars',                
                                'group:multisnow_vars'
/
! meteogram_output_nml: meteogram output for specified locations --------------
&meteogram_output_nml
 lmeteogram_enabled          =                      .TRUE.        ! .TRUE.=meteogram of output variables is desired
 n0_mtgrm                    =                          0         ! initial time step for meteogram output
 ninc_mtgrm                  =                         10         ! meteogram output interval (in terms of time steps)
 ldistributed                =                     .FALSE.        ! .FALSE.=Do not separate files for each PE
 stationlist_tot             =  52.17,  14.12, 'Lindenberg',
                                51.97,   4.93, 'Cabauw',
                               -10.08, -61.93, 'LBA_Rondonia',
                                13.50,   2.5 , 'Niamey',
                                36.61, -97.49, 'ARM_Southern_Great_Plains',
                               -71.32, 156.62, 'ARM_North_Slope_of_Alaska_Barrow',
                                -2.06, 147.43, 'ARM_Tropical_W_Pacific_Manus',
                               -12.43, 130.89, 'ARM_Tropical_W_Pacific_Darwin',
                                60.00,  80.00, 'Snow Test Russia',
                                50.00,   8.6 , 'Frankfurt-Flughafen'
/
! sleve_nml: vertical level specification -------------------------------------
&sleve_nml
 min_lay_thckn               =                         20.0       ! layer thickness of lowermost layer
 top_height                  =                      75000.0       ! height of model top
 stretch_fac                 =                          0.9       ! stretching factor to vary distribution of model levels
 decay_scale_1               =                       4000.0       ! decay scale of large-scale topography component
 decay_scale_2               =                       2500.0       ! decay scale of small-scale topography component
 decay_exp                   =                          1.2       ! exponent of decay function
 flat_height                 =                      16000.0       ! height above which the coordinate surfaces are flat
/
! radiation_nml: radiation scheme ---------------------------------------------
&radiation_nml
 irad_o3                     =                          7         ! ozone climatology
 irad_aero                   =                          6         ! aerosols
 albedo_type                 =                          2         ! type of surface albedo
/
! transport_nml: tracer transport ---------------------------------------------
&transport_nml
 ivadv_tracer                =              3, 3, 3, 3, 3         ! tracer specific method to compute vertical advection
 itype_hlimit                =           3, 4, 4, 4, 4, 0         ! type of limiter for horizontal transport
 ihadv_tracer                =          52, 2, 2, 2, 2, 0         ! tracer specific method to compute horizontal advection
 llsq_svd                    =                      .TRUE.        ! use SV decomposition for least squares design matrix
 beta_fct                    =                          1.005     ! factor of allowed over-/undershooting in monotonous limiter
/
! turbdiff_nml: turbulent diffusion -------------------------------------------
&turbdiff_nml
 tkhmin                      =                          0.75      ! scaling factor for minimum vertical diffusion coefficient
 tkmmin                      =                          0.75      ! scaling factor for minimum vertical diffusion coefficient
 pat_len                     =                        750.0       ! 
 c_diff                      =                          0.2       !
 rat_sea                     =                          8.0       !
/
! lnd_nml: land scheme switches -----------------------------------------------
&lnd_nml
 ntiles                      =                          3         ! number of tiles
 nlev_snow                   =                          2         ! number of snow layers
 lmulti_snow                 =                     .FALSE.        ! .TRUE. for use of multi-layer snow model
 idiag_snowfrac              =                          2         ! type of snow-fraction diagnosis
 lsnowtile                   =                      .TRUE.        ! .TRUE.=consider snow-covered and snow-free separately
 itype_root                  =                          2         ! root density distribution
 itype_heatcond              =                          2         ! type of soil heat conductivity
 itype_lndtbl                =                          2         ! table for associating surface parameters
 lseaice                     =                      .TRUE.        ! .TRUE. for use of sea-ice model
 llake                       =                      .TRUE.        ! .TRUE. for use of lake model
/
EOF
echo ${START} ${MODEL}
${START} ${MODEL}
