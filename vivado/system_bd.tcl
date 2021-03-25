
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# sync_bits, ad_bus_mux, ad_bus_mux, ad_bus_mux, ad_bus_mux, sync_bits, dvbs2_tx_wrapper, util_pulse_gen

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z045ffg900-2
   set_property BOARD_PART xilinx.com:zc706:part0:1.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:proc_sys_reset:5.0\
analog.com:user:axi_dacfifo:1.0\
analog.com:user:axi_clkgen:1.0\
analog.com:user:axi_dmac:1.0\
analog.com:user:axi_adxcvr:1.0\
xilinx.com:ip:axi_fifo_mm_s:4.2\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:axi_iic:2.0\
analog.com:user:axi_sysid:1.0\
xilinx.com:ip:fifo_generator:13.2\
analog.com:user:sysid_rom:1.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:processing_system7:5.5\
analog.com:user:util_cpack2:1.0\
analog.com:user:util_adxcvr:1.0\
analog.com:user:jesd204_rx:1.0\
analog.com:user:axi_jesd204_rx:1.0\
analog.com:user:jesd204_tx:1.0\
analog.com:user:axi_jesd204_tx:1.0\
analog.com:user:ad_ip_jesd204_tpl_adc:1.0\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:fir_compiler:7.2\
analog.com:user:ad_ip_jesd204_tpl_dac:1.0\
xilinx.com:ip:axis_broadcaster:1.1\
xilinx.com:ip:util_vector_logic:2.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
sync_bits\
ad_bus_mux\
ad_bus_mux\
ad_bus_mux\
ad_bus_mux\
sync_bits\
dvbs2_tx_wrapper\
util_pulse_gen\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: tx_dvb
proc create_hier_cell_tx_dvb { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_tx_dvb() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I aclk
  create_bd_pin -dir I active
  create_bd_pin -dir O -from 31 -to 0 data_out_0
  create_bd_pin -dir O -from 31 -to 0 data_out_1
  create_bd_pin -dir I load_config
  create_bd_pin -dir I -from 31 -to 0 pulse_width
  create_bd_pin -dir I -type rst resetn
  create_bd_pin -dir O -from 7 -to 0 valid_out_0
  create_bd_pin -dir O -from 7 -to 0 valid_out_1

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.M00_TDATA_REMAP {tdata[31:0]} \
   CONFIG.M01_TDATA_REMAP {tdata[31:0]} \
   CONFIG.M_TDATA_NUM_BYTES {4} \
   CONFIG.S_TDATA_NUM_BYTES {4} \
 ] $axis_broadcaster_0

  # Create instance: cdc_sync_active, and set properties
  set block_name sync_bits
  set block_cell_name cdc_sync_active
  if { [catch {set cdc_sync_active [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $cdc_sync_active eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: dvbs2_tx_wrapper_0, and set properties
  set block_name dvbs2_tx_wrapper
  set block_cell_name dvbs2_tx_wrapper_0
  if { [catch {set dvbs2_tx_wrapper_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dvbs2_tx_wrapper_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: fir_interpolation_0, and set properties
  set fir_interpolation_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_interpolation_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {122.88} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {1} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Interpolation} \
   CONFIG.Interpolation_Rate {8} \
   CONFIG.M_DATA_Has_TREADY {true} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {2} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {15.36} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_interpolation_0

  # Create instance: fir_interpolation_1, and set properties
  set fir_interpolation_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_interpolation_1 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {122.88} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {1} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Interpolation} \
   CONFIG.Interpolation_Rate {8} \
   CONFIG.M_DATA_Has_TREADY {true} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {2} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {15.36} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_interpolation_1

  # Create instance: rate_gen, and set properties
  set block_name util_pulse_gen
  set block_cell_name rate_gen
  if { [catch {set rate_gen [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $rate_gen eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.PULSE_PERIOD {7} \
   CONFIG.PULSE_WIDTH {1} \
 ] $rate_gen

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins fir_interpolation_0/S_AXIS_DATA]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins fir_interpolation_1/S_AXIS_DATA]
  connect_bd_intf_net -intf_net dvbs2_tx_wrapper_0_m_axis [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins dvbs2_tx_wrapper_0/m_axis]
  connect_bd_intf_net -intf_net s_axi_lite_1_1 [get_bd_intf_pins s_axi_lite] [get_bd_intf_pins dvbs2_tx_wrapper_0/s_axi_lite]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dvbs2_tx_wrapper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins cdc_sync_active/out_clk] [get_bd_pins dvbs2_tx_wrapper_0/clk] [get_bd_pins fir_interpolation_0/aclk] [get_bd_pins fir_interpolation_1/aclk] [get_bd_pins rate_gen/clk]
  connect_bd_net -net active_1 [get_bd_pins active] [get_bd_pins cdc_sync_active/in_bits]
  connect_bd_net -net cdc_sync_active_out_bits [get_bd_pins cdc_sync_active/out_bits] [get_bd_pins rate_gen/rstn]
  connect_bd_net -net fir_interpolation_0_m_axis_data_tdata [get_bd_pins data_out_0] [get_bd_pins fir_interpolation_0/m_axis_data_tdata]
  connect_bd_net -net fir_interpolation_0_m_axis_data_tvalid [get_bd_pins fir_interpolation_0/m_axis_data_tvalid] [get_bd_pins util_vector_logic_1/Op2]
  connect_bd_net -net fir_interpolation_1_m_axis_data_tdata [get_bd_pins data_out_1] [get_bd_pins fir_interpolation_1/m_axis_data_tdata]
  connect_bd_net -net fir_interpolation_1_m_axis_data_tvalid [get_bd_pins fir_interpolation_1/m_axis_data_tvalid] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net load_config_1 [get_bd_pins load_config] [get_bd_pins rate_gen/load_config]
  connect_bd_net -net out_resetn_1 [get_bd_pins resetn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins cdc_sync_active/out_resetn] [get_bd_pins dvbs2_tx_wrapper_0/rst_n]
  connect_bd_net -net pulse_width_1 [get_bd_pins pulse_width] [get_bd_pins rate_gen/pulse_period] [get_bd_pins rate_gen/pulse_width]
  connect_bd_net -net rate_gen_pulse [get_bd_pins fir_interpolation_0/m_axis_data_tready] [get_bd_pins fir_interpolation_1/m_axis_data_tready] [get_bd_pins rate_gen/pulse] [get_bd_pins util_vector_logic_0/Op2] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins valid_out_1] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins valid_out_0] [get_bd_pins util_vector_logic_1/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: tx_ad9371_tpl_core
proc create_hier_cell_tx_ad9371_tpl_core { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_tx_ad9371_tpl_core() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 link

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 dac_data_0
  create_bd_pin -dir I -from 31 -to 0 dac_data_1
  create_bd_pin -dir I -from 31 -to 0 dac_data_2
  create_bd_pin -dir I -from 31 -to 0 dac_data_3
  create_bd_pin -dir I dac_dunf
  create_bd_pin -dir O -from 0 -to 0 dac_enable_0
  create_bd_pin -dir O -from 0 -to 0 dac_enable_1
  create_bd_pin -dir O -from 0 -to 0 dac_enable_2
  create_bd_pin -dir O -from 0 -to 0 dac_enable_3
  create_bd_pin -dir O -from 0 -to 0 dac_valid_0
  create_bd_pin -dir O -from 0 -to 0 dac_valid_1
  create_bd_pin -dir O -from 0 -to 0 dac_valid_2
  create_bd_pin -dir O -from 0 -to 0 dac_valid_3
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: dac_tpl_core, and set properties
  set dac_tpl_core [ create_bd_cell -type ip -vlnv analog.com:user:ad_ip_jesd204_tpl_dac:1.0 dac_tpl_core ]
  set_property -dict [ list \
   CONFIG.BITS_PER_SAMPLE {16} \
   CONFIG.CONVERTER_RESOLUTION {16} \
   CONFIG.DMA_BITS_PER_SAMPLE {16} \
   CONFIG.NUM_CHANNELS {4} \
   CONFIG.NUM_LANES {4} \
   CONFIG.OCTETS_PER_BEAT {4} \
   CONFIG.SAMPLES_PER_FRAME {1} \
 ] $dac_tpl_core

  # Create instance: data_concat0, and set properties
  set data_concat0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 data_concat0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $data_concat0

  # Create instance: enable_slice_0, and set properties
  set enable_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_0

  # Create instance: enable_slice_1, and set properties
  set enable_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_1

  # Create instance: enable_slice_2, and set properties
  set enable_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_2

  # Create instance: enable_slice_3, and set properties
  set enable_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_3

  # Create instance: valid_slice_0, and set properties
  set valid_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_0

  # Create instance: valid_slice_1, and set properties
  set valid_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_1

  # Create instance: valid_slice_2, and set properties
  set valid_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_2

  # Create instance: valid_slice_3, and set properties
  set valid_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_3

  # Create interface connections
  connect_bd_intf_net -intf_net dac_tpl_core_link [get_bd_intf_pins link] [get_bd_intf_pins dac_tpl_core/link]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins dac_tpl_core/s_axi]

  # Create port connections
  connect_bd_net -net dac_data_0_1 [get_bd_pins dac_data_0] [get_bd_pins data_concat0/In0]
  connect_bd_net -net dac_data_1_1 [get_bd_pins dac_data_1] [get_bd_pins data_concat0/In1]
  connect_bd_net -net dac_data_2_1 [get_bd_pins dac_data_2] [get_bd_pins data_concat0/In2]
  connect_bd_net -net dac_data_3_1 [get_bd_pins dac_data_3] [get_bd_pins data_concat0/In3]
  connect_bd_net -net dac_dunf_1 [get_bd_pins dac_dunf] [get_bd_pins dac_tpl_core/dac_dunf]
  connect_bd_net -net dac_tpl_core_dac_valid [get_bd_pins dac_tpl_core/dac_valid] [get_bd_pins valid_slice_0/Din] [get_bd_pins valid_slice_1/Din] [get_bd_pins valid_slice_2/Din] [get_bd_pins valid_slice_3/Din]
  connect_bd_net -net dac_tpl_core_enable [get_bd_pins dac_tpl_core/enable] [get_bd_pins enable_slice_0/Din] [get_bd_pins enable_slice_1/Din] [get_bd_pins enable_slice_2/Din] [get_bd_pins enable_slice_3/Din]
  connect_bd_net -net data_concat0_dout [get_bd_pins dac_tpl_core/dac_ddata] [get_bd_pins data_concat0/dout]
  connect_bd_net -net enable_slice_0_Dout [get_bd_pins dac_enable_0] [get_bd_pins enable_slice_0/Dout]
  connect_bd_net -net enable_slice_1_Dout [get_bd_pins dac_enable_1] [get_bd_pins enable_slice_1/Dout]
  connect_bd_net -net enable_slice_2_Dout [get_bd_pins dac_enable_2] [get_bd_pins enable_slice_2/Dout]
  connect_bd_net -net enable_slice_3_Dout [get_bd_pins dac_enable_3] [get_bd_pins enable_slice_3/Dout]
  connect_bd_net -net link_clk_1 [get_bd_pins link_clk] [get_bd_pins dac_tpl_core/link_clk]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins dac_tpl_core/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins dac_tpl_core/s_axi_aresetn]
  connect_bd_net -net valid_slice_0_Dout [get_bd_pins dac_valid_0] [get_bd_pins valid_slice_0/Dout]
  connect_bd_net -net valid_slice_1_Dout [get_bd_pins dac_valid_1] [get_bd_pins valid_slice_1/Dout]
  connect_bd_net -net valid_slice_2_Dout [get_bd_pins dac_valid_2] [get_bd_pins valid_slice_2/Dout]
  connect_bd_net -net valid_slice_3_Dout [get_bd_pins dac_valid_3] [get_bd_pins valid_slice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: rx_os_ad9371_tpl_core
proc create_hier_cell_rx_os_ad9371_tpl_core { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rx_os_ad9371_tpl_core() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir O -from 31 -to 0 adc_data_0
  create_bd_pin -dir O -from 31 -to 0 adc_data_1
  create_bd_pin -dir I adc_dovf
  create_bd_pin -dir O -from 0 -to 0 adc_enable_0
  create_bd_pin -dir O -from 0 -to 0 adc_enable_1
  create_bd_pin -dir O -from 0 -to 0 adc_valid_0
  create_bd_pin -dir O -from 0 -to 0 adc_valid_1
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir I -from 63 -to 0 link_data
  create_bd_pin -dir I -from 3 -to 0 link_sof
  create_bd_pin -dir I link_valid
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: adc_tpl_core, and set properties
  set adc_tpl_core [ create_bd_cell -type ip -vlnv analog.com:user:ad_ip_jesd204_tpl_adc:1.0 adc_tpl_core ]
  set_property -dict [ list \
   CONFIG.BITS_PER_SAMPLE {16} \
   CONFIG.CONVERTER_RESOLUTION {16} \
   CONFIG.DMA_BITS_PER_SAMPLE {16} \
   CONFIG.NUM_CHANNELS {2} \
   CONFIG.NUM_LANES {2} \
   CONFIG.OCTETS_PER_BEAT {4} \
   CONFIG.SAMPLES_PER_FRAME {1} \
 ] $adc_tpl_core

  # Create instance: data_slice_0, and set properties
  set data_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 data_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {64} \
 ] $data_slice_0

  # Create instance: data_slice_1, and set properties
  set data_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 data_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {63} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {64} \
 ] $data_slice_1

  # Create instance: enable_slice_0, and set properties
  set enable_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {2} \
 ] $enable_slice_0

  # Create instance: enable_slice_1, and set properties
  set enable_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {2} \
 ] $enable_slice_1

  # Create instance: valid_slice_0, and set properties
  set valid_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {2} \
 ] $valid_slice_0

  # Create instance: valid_slice_1, and set properties
  set valid_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {2} \
 ] $valid_slice_1

  # Create interface connections
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins adc_tpl_core/s_axi]

  # Create port connections
  connect_bd_net -net adc_dovf_1 [get_bd_pins adc_dovf] [get_bd_pins adc_tpl_core/adc_dovf]
  connect_bd_net -net adc_tpl_core_adc_data [get_bd_pins adc_tpl_core/adc_data] [get_bd_pins data_slice_0/Din] [get_bd_pins data_slice_1/Din]
  connect_bd_net -net adc_tpl_core_adc_valid [get_bd_pins adc_tpl_core/adc_valid] [get_bd_pins valid_slice_0/Din] [get_bd_pins valid_slice_1/Din]
  connect_bd_net -net adc_tpl_core_enable [get_bd_pins adc_tpl_core/enable] [get_bd_pins enable_slice_0/Din] [get_bd_pins enable_slice_1/Din]
  connect_bd_net -net data_slice_0_Dout [get_bd_pins adc_data_0] [get_bd_pins data_slice_0/Dout]
  connect_bd_net -net data_slice_1_Dout [get_bd_pins adc_data_1] [get_bd_pins data_slice_1/Dout]
  connect_bd_net -net enable_slice_0_Dout [get_bd_pins adc_enable_0] [get_bd_pins enable_slice_0/Dout]
  connect_bd_net -net enable_slice_1_Dout [get_bd_pins adc_enable_1] [get_bd_pins enable_slice_1/Dout]
  connect_bd_net -net link_clk_1 [get_bd_pins link_clk] [get_bd_pins adc_tpl_core/link_clk]
  connect_bd_net -net link_data_1 [get_bd_pins link_data] [get_bd_pins adc_tpl_core/link_data]
  connect_bd_net -net link_sof_1 [get_bd_pins link_sof] [get_bd_pins adc_tpl_core/link_sof]
  connect_bd_net -net link_valid_1 [get_bd_pins link_valid] [get_bd_pins adc_tpl_core/link_valid]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins adc_tpl_core/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins adc_tpl_core/s_axi_aresetn]
  connect_bd_net -net valid_slice_0_Dout [get_bd_pins adc_valid_0] [get_bd_pins valid_slice_0/Dout]
  connect_bd_net -net valid_slice_1_Dout [get_bd_pins adc_valid_1] [get_bd_pins valid_slice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: rx_fir_decimator
proc create_hier_cell_rx_fir_decimator { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rx_fir_decimator() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I aclk
  create_bd_pin -dir I active
  create_bd_pin -dir I -from 15 -to 0 data_in_0
  create_bd_pin -dir I -from 15 -to 0 data_in_1
  create_bd_pin -dir I -from 15 -to 0 data_in_2
  create_bd_pin -dir I -from 15 -to 0 data_in_3
  create_bd_pin -dir O -from 15 -to 0 data_out_0
  create_bd_pin -dir O -from 15 -to 0 data_out_1
  create_bd_pin -dir O -from 15 -to 0 data_out_2
  create_bd_pin -dir O -from 15 -to 0 data_out_3
  create_bd_pin -dir I enable_in_0
  create_bd_pin -dir I enable_in_1
  create_bd_pin -dir I enable_in_2
  create_bd_pin -dir I enable_in_3
  create_bd_pin -dir O enable_out_0
  create_bd_pin -dir O enable_out_1
  create_bd_pin -dir O enable_out_2
  create_bd_pin -dir O enable_out_3
  create_bd_pin -dir I -type rst out_resetn
  create_bd_pin -dir I valid_in_0
  create_bd_pin -dir I valid_in_1
  create_bd_pin -dir I valid_in_2
  create_bd_pin -dir I valid_in_3
  create_bd_pin -dir O valid_out_0
  create_bd_pin -dir O valid_out_1
  create_bd_pin -dir O valid_out_2
  create_bd_pin -dir O valid_out_3

  # Create instance: cdc_sync_active, and set properties
  set block_name sync_bits
  set block_cell_name cdc_sync_active
  if { [catch {set cdc_sync_active [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $cdc_sync_active eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: fir_decimation_0, and set properties
  set fir_decimation_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_decimation_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {122.88} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {8} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Decimation} \
   CONFIG.Interpolation_Rate {1} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {122.88} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_decimation_0

  # Create instance: fir_decimation_1, and set properties
  set fir_decimation_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_decimation_1 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {122.88} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {8} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Decimation} \
   CONFIG.Interpolation_Rate {1} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {122.88} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_decimation_1

  # Create instance: fir_decimation_2, and set properties
  set fir_decimation_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_decimation_2 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {122.88} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {8} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Decimation} \
   CONFIG.Interpolation_Rate {1} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {122.88} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_decimation_2

  # Create instance: fir_decimation_3, and set properties
  set fir_decimation_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 fir_decimation_3 ]
  set_property -dict [ list \
   CONFIG.Clock_Frequency {122.88} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.Coefficient_File {../../../../../../../../library/util_fir_int/coefile_int.coe} \
   CONFIG.Coefficient_Fractional_Bits {0} \
   CONFIG.Coefficient_Sets {1} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {16} \
   CONFIG.ColumnConfig {9} \
   CONFIG.Data_Fractional_Bits {15} \
   CONFIG.Decimation_Rate {8} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Type {Decimation} \
   CONFIG.Interpolation_Rate {1} \
   CONFIG.Number_Channels {1} \
   CONFIG.Number_Paths {1} \
   CONFIG.Output_Rounding_Mode {Symmetric_Rounding_to_Zero} \
   CONFIG.Output_Width {16} \
   CONFIG.Quantization {Integer_Coefficients} \
   CONFIG.RateSpecification {Frequency_Specification} \
   CONFIG.Sample_Frequency {122.88} \
   CONFIG.Zero_Pack_Factor {1} \
 ] $fir_decimation_3

  # Create instance: out_mux_0, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_0
  if { [catch {set out_mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_0

  # Create instance: out_mux_1, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_1
  if { [catch {set out_mux_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_1

  # Create instance: out_mux_2, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_2
  if { [catch {set out_mux_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_2

  # Create instance: out_mux_3, and set properties
  set block_name ad_bus_mux
  set block_cell_name out_mux_3
  if { [catch {set out_mux_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $out_mux_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.DATA_WIDTH {16} \
 ] $out_mux_3

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins cdc_sync_active/out_clk] [get_bd_pins fir_decimation_0/aclk] [get_bd_pins fir_decimation_1/aclk] [get_bd_pins fir_decimation_2/aclk] [get_bd_pins fir_decimation_3/aclk]
  connect_bd_net -net active_1 [get_bd_pins active] [get_bd_pins cdc_sync_active/in_bits]
  connect_bd_net -net cdc_sync_active_out_bits [get_bd_pins cdc_sync_active/out_bits] [get_bd_pins out_mux_0/select_path] [get_bd_pins out_mux_1/select_path] [get_bd_pins out_mux_2/select_path] [get_bd_pins out_mux_3/select_path]
  connect_bd_net -net data_in_0_1 [get_bd_pins data_in_0] [get_bd_pins fir_decimation_0/s_axis_data_tdata] [get_bd_pins out_mux_0/data_in_0]
  connect_bd_net -net data_in_1_1 [get_bd_pins data_in_1] [get_bd_pins fir_decimation_1/s_axis_data_tdata] [get_bd_pins out_mux_1/data_in_0]
  connect_bd_net -net data_in_2_1 [get_bd_pins data_in_2] [get_bd_pins fir_decimation_2/s_axis_data_tdata] [get_bd_pins out_mux_2/data_in_0]
  connect_bd_net -net data_in_3_1 [get_bd_pins data_in_3] [get_bd_pins fir_decimation_3/s_axis_data_tdata] [get_bd_pins out_mux_3/data_in_0]
  connect_bd_net -net enable_in_0_1 [get_bd_pins enable_in_0] [get_bd_pins out_mux_0/enable_in_0] [get_bd_pins out_mux_0/enable_in_1]
  connect_bd_net -net enable_in_1_1 [get_bd_pins enable_in_1] [get_bd_pins out_mux_1/enable_in_0] [get_bd_pins out_mux_1/enable_in_1]
  connect_bd_net -net enable_in_2_1 [get_bd_pins enable_in_2] [get_bd_pins out_mux_2/enable_in_0] [get_bd_pins out_mux_2/enable_in_1]
  connect_bd_net -net enable_in_3_1 [get_bd_pins enable_in_3] [get_bd_pins out_mux_3/enable_in_0] [get_bd_pins out_mux_3/enable_in_1]
  connect_bd_net -net fir_decimation_0_m_axis_data_tdata [get_bd_pins fir_decimation_0/m_axis_data_tdata] [get_bd_pins out_mux_0/data_in_1]
  connect_bd_net -net fir_decimation_0_m_axis_data_tvalid [get_bd_pins fir_decimation_0/m_axis_data_tvalid] [get_bd_pins out_mux_0/valid_in_1]
  connect_bd_net -net fir_decimation_1_m_axis_data_tdata [get_bd_pins fir_decimation_1/m_axis_data_tdata] [get_bd_pins out_mux_1/data_in_1]
  connect_bd_net -net fir_decimation_1_m_axis_data_tvalid [get_bd_pins fir_decimation_1/m_axis_data_tvalid] [get_bd_pins out_mux_1/valid_in_1]
  connect_bd_net -net fir_decimation_2_m_axis_data_tdata [get_bd_pins fir_decimation_2/m_axis_data_tdata] [get_bd_pins out_mux_2/data_in_1]
  connect_bd_net -net fir_decimation_2_m_axis_data_tvalid [get_bd_pins fir_decimation_2/m_axis_data_tvalid] [get_bd_pins out_mux_2/valid_in_1]
  connect_bd_net -net fir_decimation_3_m_axis_data_tdata [get_bd_pins fir_decimation_3/m_axis_data_tdata] [get_bd_pins out_mux_3/data_in_1]
  connect_bd_net -net fir_decimation_3_m_axis_data_tvalid [get_bd_pins fir_decimation_3/m_axis_data_tvalid] [get_bd_pins out_mux_3/valid_in_1]
  connect_bd_net -net out_mux_0_data_out [get_bd_pins data_out_0] [get_bd_pins out_mux_0/data_out]
  connect_bd_net -net out_mux_0_enable_out [get_bd_pins enable_out_0] [get_bd_pins out_mux_0/enable_out]
  connect_bd_net -net out_mux_0_valid_out [get_bd_pins valid_out_0] [get_bd_pins out_mux_0/valid_out]
  connect_bd_net -net out_mux_1_data_out [get_bd_pins data_out_1] [get_bd_pins out_mux_1/data_out]
  connect_bd_net -net out_mux_1_enable_out [get_bd_pins enable_out_1] [get_bd_pins out_mux_1/enable_out]
  connect_bd_net -net out_mux_1_valid_out [get_bd_pins valid_out_1] [get_bd_pins out_mux_1/valid_out]
  connect_bd_net -net out_mux_2_data_out [get_bd_pins data_out_2] [get_bd_pins out_mux_2/data_out]
  connect_bd_net -net out_mux_2_enable_out [get_bd_pins enable_out_2] [get_bd_pins out_mux_2/enable_out]
  connect_bd_net -net out_mux_2_valid_out [get_bd_pins valid_out_2] [get_bd_pins out_mux_2/valid_out]
  connect_bd_net -net out_mux_3_data_out [get_bd_pins data_out_3] [get_bd_pins out_mux_3/data_out]
  connect_bd_net -net out_mux_3_enable_out [get_bd_pins enable_out_3] [get_bd_pins out_mux_3/enable_out]
  connect_bd_net -net out_mux_3_valid_out [get_bd_pins valid_out_3] [get_bd_pins out_mux_3/valid_out]
  connect_bd_net -net out_resetn_1 [get_bd_pins out_resetn] [get_bd_pins cdc_sync_active/out_resetn]
  connect_bd_net -net valid_in_0_1 [get_bd_pins valid_in_0] [get_bd_pins fir_decimation_0/s_axis_data_tvalid] [get_bd_pins out_mux_0/valid_in_0]
  connect_bd_net -net valid_in_1_1 [get_bd_pins valid_in_1] [get_bd_pins fir_decimation_1/s_axis_data_tvalid] [get_bd_pins out_mux_1/valid_in_0]
  connect_bd_net -net valid_in_2_1 [get_bd_pins valid_in_2] [get_bd_pins fir_decimation_2/s_axis_data_tvalid] [get_bd_pins out_mux_2/valid_in_0]
  connect_bd_net -net valid_in_3_1 [get_bd_pins valid_in_3] [get_bd_pins fir_decimation_3/s_axis_data_tvalid] [get_bd_pins out_mux_3/valid_in_0]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: rx_ad9371_tpl_core
proc create_hier_cell_rx_ad9371_tpl_core { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rx_ad9371_tpl_core() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir O -from 15 -to 0 adc_data_0
  create_bd_pin -dir O -from 15 -to 0 adc_data_1
  create_bd_pin -dir O -from 15 -to 0 adc_data_2
  create_bd_pin -dir O -from 15 -to 0 adc_data_3
  create_bd_pin -dir I adc_dovf
  create_bd_pin -dir O -from 0 -to 0 adc_enable_0
  create_bd_pin -dir O -from 0 -to 0 adc_enable_1
  create_bd_pin -dir O -from 0 -to 0 adc_enable_2
  create_bd_pin -dir O -from 0 -to 0 adc_enable_3
  create_bd_pin -dir O -from 0 -to 0 adc_valid_0
  create_bd_pin -dir O -from 0 -to 0 adc_valid_1
  create_bd_pin -dir O -from 0 -to 0 adc_valid_2
  create_bd_pin -dir O -from 0 -to 0 adc_valid_3
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir I -from 63 -to 0 link_data
  create_bd_pin -dir I -from 3 -to 0 link_sof
  create_bd_pin -dir I link_valid
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: adc_tpl_core, and set properties
  set adc_tpl_core [ create_bd_cell -type ip -vlnv analog.com:user:ad_ip_jesd204_tpl_adc:1.0 adc_tpl_core ]
  set_property -dict [ list \
   CONFIG.BITS_PER_SAMPLE {16} \
   CONFIG.CONVERTER_RESOLUTION {16} \
   CONFIG.DMA_BITS_PER_SAMPLE {16} \
   CONFIG.NUM_CHANNELS {4} \
   CONFIG.NUM_LANES {2} \
   CONFIG.OCTETS_PER_BEAT {4} \
   CONFIG.SAMPLES_PER_FRAME {1} \
 ] $adc_tpl_core

  # Create instance: data_slice_0, and set properties
  set data_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 data_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {64} \
 ] $data_slice_0

  # Create instance: data_slice_1, and set properties
  set data_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 data_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {16} \
   CONFIG.DIN_WIDTH {64} \
 ] $data_slice_1

  # Create instance: data_slice_2, and set properties
  set data_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 data_slice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {47} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {64} \
 ] $data_slice_2

  # Create instance: data_slice_3, and set properties
  set data_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 data_slice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {63} \
   CONFIG.DIN_TO {48} \
   CONFIG.DIN_WIDTH {64} \
 ] $data_slice_3

  # Create instance: enable_slice_0, and set properties
  set enable_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_0

  # Create instance: enable_slice_1, and set properties
  set enable_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_1

  # Create instance: enable_slice_2, and set properties
  set enable_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_2

  # Create instance: enable_slice_3, and set properties
  set enable_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 enable_slice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
 ] $enable_slice_3

  # Create instance: valid_slice_0, and set properties
  set valid_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_0

  # Create instance: valid_slice_1, and set properties
  set valid_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_1

  # Create instance: valid_slice_2, and set properties
  set valid_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_2

  # Create instance: valid_slice_3, and set properties
  set valid_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 valid_slice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
 ] $valid_slice_3

  # Create interface connections
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins adc_tpl_core/s_axi]

  # Create port connections
  connect_bd_net -net adc_dovf_1 [get_bd_pins adc_dovf] [get_bd_pins adc_tpl_core/adc_dovf]
  connect_bd_net -net adc_tpl_core_adc_data [get_bd_pins adc_tpl_core/adc_data] [get_bd_pins data_slice_0/Din] [get_bd_pins data_slice_1/Din] [get_bd_pins data_slice_2/Din] [get_bd_pins data_slice_3/Din]
  connect_bd_net -net adc_tpl_core_adc_valid [get_bd_pins adc_tpl_core/adc_valid] [get_bd_pins valid_slice_0/Din] [get_bd_pins valid_slice_1/Din] [get_bd_pins valid_slice_2/Din] [get_bd_pins valid_slice_3/Din]
  connect_bd_net -net adc_tpl_core_enable [get_bd_pins adc_tpl_core/enable] [get_bd_pins enable_slice_0/Din] [get_bd_pins enable_slice_1/Din] [get_bd_pins enable_slice_2/Din] [get_bd_pins enable_slice_3/Din]
  connect_bd_net -net data_slice_0_Dout [get_bd_pins adc_data_0] [get_bd_pins data_slice_0/Dout]
  connect_bd_net -net data_slice_1_Dout [get_bd_pins adc_data_1] [get_bd_pins data_slice_1/Dout]
  connect_bd_net -net data_slice_2_Dout [get_bd_pins adc_data_2] [get_bd_pins data_slice_2/Dout]
  connect_bd_net -net data_slice_3_Dout [get_bd_pins adc_data_3] [get_bd_pins data_slice_3/Dout]
  connect_bd_net -net enable_slice_0_Dout [get_bd_pins adc_enable_0] [get_bd_pins enable_slice_0/Dout]
  connect_bd_net -net enable_slice_1_Dout [get_bd_pins adc_enable_1] [get_bd_pins enable_slice_1/Dout]
  connect_bd_net -net enable_slice_2_Dout [get_bd_pins adc_enable_2] [get_bd_pins enable_slice_2/Dout]
  connect_bd_net -net enable_slice_3_Dout [get_bd_pins adc_enable_3] [get_bd_pins enable_slice_3/Dout]
  connect_bd_net -net link_clk_1 [get_bd_pins link_clk] [get_bd_pins adc_tpl_core/link_clk]
  connect_bd_net -net link_data_1 [get_bd_pins link_data] [get_bd_pins adc_tpl_core/link_data]
  connect_bd_net -net link_sof_1 [get_bd_pins link_sof] [get_bd_pins adc_tpl_core/link_sof]
  connect_bd_net -net link_valid_1 [get_bd_pins link_valid] [get_bd_pins adc_tpl_core/link_valid]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins adc_tpl_core/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins adc_tpl_core/s_axi_aresetn]
  connect_bd_net -net valid_slice_0_Dout [get_bd_pins adc_valid_0] [get_bd_pins valid_slice_0/Dout]
  connect_bd_net -net valid_slice_1_Dout [get_bd_pins adc_valid_1] [get_bd_pins valid_slice_1/Dout]
  connect_bd_net -net valid_slice_2_Dout [get_bd_pins adc_valid_2] [get_bd_pins valid_slice_2/Dout]
  connect_bd_net -net valid_slice_3_Dout [get_bd_pins adc_valid_3] [get_bd_pins valid_slice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_ad9371_tx_jesd
proc create_hier_cell_axi_ad9371_tx_jesd { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_axi_ad9371_tx_jesd() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 tx_data

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_jesd204:jesd204_tx_bus_rtl:1.0 tx_phy0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_jesd204:jesd204_tx_bus_rtl:1.0 tx_phy1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_jesd204:jesd204_tx_bus_rtl:1.0 tx_phy2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_jesd204:jesd204_tx_bus_rtl:1.0 tx_phy3


  # Create pins
  create_bd_pin -dir I -type clk device_clk
  create_bd_pin -dir O -type intr irq
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -from 0 -to 0 sync
  create_bd_pin -dir I sysref

  # Create instance: tx, and set properties
  set tx [ create_bd_cell -type ip -vlnv analog.com:user:jesd204_tx:1.0 tx ]
  set_property -dict [ list \
   CONFIG.LINK_MODE {1} \
   CONFIG.NUM_LANES {4} \
   CONFIG.NUM_LINKS {1} \
 ] $tx

  # Create instance: tx_axi, and set properties
  set tx_axi [ create_bd_cell -type ip -vlnv analog.com:user:axi_jesd204_tx:1.0 tx_axi ]
  set_property -dict [ list \
   CONFIG.LINK_MODE {1} \
   CONFIG.NUM_LANES {4} \
   CONFIG.NUM_LINKS {1} \
 ] $tx_axi

  # Create interface connections
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins tx_axi/s_axi]
  connect_bd_intf_net -intf_net tx_axi_tx_cfg [get_bd_intf_pins tx/tx_cfg] [get_bd_intf_pins tx_axi/tx_cfg]
  connect_bd_intf_net -intf_net tx_axi_tx_ctrl [get_bd_intf_pins tx/tx_ctrl] [get_bd_intf_pins tx_axi/tx_ctrl]
  connect_bd_intf_net -intf_net tx_data_1 [get_bd_intf_pins tx_data] [get_bd_intf_pins tx/tx_data]
  connect_bd_intf_net -intf_net tx_tx_event [get_bd_intf_pins tx/tx_event] [get_bd_intf_pins tx_axi/tx_event]
  connect_bd_intf_net -intf_net tx_tx_ilas_config [get_bd_intf_pins tx/tx_ilas_config] [get_bd_intf_pins tx_axi/tx_ilas_config]
  connect_bd_intf_net -intf_net tx_tx_phy0 [get_bd_intf_pins tx_phy0] [get_bd_intf_pins tx/tx_phy0]
  connect_bd_intf_net -intf_net tx_tx_phy1 [get_bd_intf_pins tx_phy1] [get_bd_intf_pins tx/tx_phy1]
  connect_bd_intf_net -intf_net tx_tx_phy2 [get_bd_intf_pins tx_phy2] [get_bd_intf_pins tx/tx_phy2]
  connect_bd_intf_net -intf_net tx_tx_phy3 [get_bd_intf_pins tx_phy3] [get_bd_intf_pins tx/tx_phy3]
  connect_bd_intf_net -intf_net tx_tx_status [get_bd_intf_pins tx/tx_status] [get_bd_intf_pins tx_axi/tx_status]

  # Create port connections
  connect_bd_net -net device_clk_1 [get_bd_pins device_clk] [get_bd_pins tx/device_clk] [get_bd_pins tx_axi/device_clk]
  connect_bd_net -net link_clk_1 [get_bd_pins link_clk] [get_bd_pins tx/clk] [get_bd_pins tx_axi/core_clk]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins tx_axi/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins tx_axi/s_axi_aresetn]
  connect_bd_net -net sync_1 [get_bd_pins sync] [get_bd_pins tx/sync]
  connect_bd_net -net sysref_1 [get_bd_pins sysref] [get_bd_pins tx/sysref]
  connect_bd_net -net tx_axi_core_reset [get_bd_pins tx/reset] [get_bd_pins tx_axi/core_reset]
  connect_bd_net -net tx_axi_device_reset [get_bd_pins tx/device_reset] [get_bd_pins tx_axi/device_reset]
  connect_bd_net -net tx_axi_irq [get_bd_pins irq] [get_bd_pins tx_axi/irq]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_ad9371_rx_os_jesd
proc create_hier_cell_axi_ad9371_rx_os_jesd { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_axi_ad9371_rx_os_jesd() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_jesd204:jesd204_rx_bus_rtl:1.0 rx_phy0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_jesd204:jesd204_rx_bus_rtl:1.0 rx_phy1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir I -type clk device_clk
  create_bd_pin -dir O -type intr irq
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir O phy_en_char_align
  create_bd_pin -dir O -from 63 -to 0 rx_data_tdata
  create_bd_pin -dir O rx_data_tvalid
  create_bd_pin -dir O -from 3 -to 0 rx_eof
  create_bd_pin -dir O -from 3 -to 0 rx_sof
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir O -from 0 -to 0 sync
  create_bd_pin -dir I sysref

  # Create instance: rx, and set properties
  set rx [ create_bd_cell -type ip -vlnv analog.com:user:jesd204_rx:1.0 rx ]
  set_property -dict [ list \
   CONFIG.LINK_MODE {1} \
   CONFIG.NUM_LANES {2} \
   CONFIG.NUM_LINKS {1} \
 ] $rx

  # Create instance: rx_axi, and set properties
  set rx_axi [ create_bd_cell -type ip -vlnv analog.com:user:axi_jesd204_rx:1.0 rx_axi ]
  set_property -dict [ list \
   CONFIG.LINK_MODE {1} \
   CONFIG.NUM_LANES {2} \
   CONFIG.NUM_LINKS {1} \
 ] $rx_axi

  # Create interface connections
  connect_bd_intf_net -intf_net rx_axi_rx_cfg [get_bd_intf_pins rx/rx_cfg] [get_bd_intf_pins rx_axi/rx_cfg]
  connect_bd_intf_net -intf_net rx_phy0_1 [get_bd_intf_pins rx_phy0] [get_bd_intf_pins rx/rx_phy0]
  connect_bd_intf_net -intf_net rx_phy1_1 [get_bd_intf_pins rx_phy1] [get_bd_intf_pins rx/rx_phy1]
  connect_bd_intf_net -intf_net rx_rx_event [get_bd_intf_pins rx/rx_event] [get_bd_intf_pins rx_axi/rx_event]
  connect_bd_intf_net -intf_net rx_rx_ilas_config [get_bd_intf_pins rx/rx_ilas_config] [get_bd_intf_pins rx_axi/rx_ilas_config]
  connect_bd_intf_net -intf_net rx_rx_status [get_bd_intf_pins rx/rx_status] [get_bd_intf_pins rx_axi/rx_status]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins rx_axi/s_axi]

  # Create port connections
  connect_bd_net -net device_clk_1 [get_bd_pins device_clk] [get_bd_pins rx/device_clk] [get_bd_pins rx_axi/device_clk]
  connect_bd_net -net link_clk_1 [get_bd_pins link_clk] [get_bd_pins rx/clk] [get_bd_pins rx_axi/core_clk]
  connect_bd_net -net rx_axi_core_reset [get_bd_pins rx/reset] [get_bd_pins rx_axi/core_reset]
  connect_bd_net -net rx_axi_device_reset [get_bd_pins rx/device_reset] [get_bd_pins rx_axi/device_reset]
  connect_bd_net -net rx_axi_irq [get_bd_pins irq] [get_bd_pins rx_axi/irq]
  connect_bd_net -net rx_phy_en_char_align [get_bd_pins phy_en_char_align] [get_bd_pins rx/phy_en_char_align]
  connect_bd_net -net rx_rx_data [get_bd_pins rx_data_tdata] [get_bd_pins rx/rx_data]
  connect_bd_net -net rx_rx_eof [get_bd_pins rx_eof] [get_bd_pins rx/rx_eof]
  connect_bd_net -net rx_rx_sof [get_bd_pins rx_sof] [get_bd_pins rx/rx_sof]
  connect_bd_net -net rx_rx_valid [get_bd_pins rx_data_tvalid] [get_bd_pins rx/rx_valid]
  connect_bd_net -net rx_sync [get_bd_pins sync] [get_bd_pins rx/sync]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins rx_axi/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins rx_axi/s_axi_aresetn]
  connect_bd_net -net sysref_1 [get_bd_pins sysref] [get_bd_pins rx/sysref]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_ad9371_rx_jesd
proc create_hier_cell_axi_ad9371_rx_jesd { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_axi_ad9371_rx_jesd() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_jesd204:jesd204_rx_bus_rtl:1.0 rx_phy0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_jesd204:jesd204_rx_bus_rtl:1.0 rx_phy1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi


  # Create pins
  create_bd_pin -dir I -type clk device_clk
  create_bd_pin -dir O -type intr irq
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir O phy_en_char_align
  create_bd_pin -dir O -from 63 -to 0 rx_data_tdata
  create_bd_pin -dir O rx_data_tvalid
  create_bd_pin -dir O -from 3 -to 0 rx_eof
  create_bd_pin -dir O -from 3 -to 0 rx_sof
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir O -from 0 -to 0 sync
  create_bd_pin -dir I sysref

  # Create instance: rx, and set properties
  set rx [ create_bd_cell -type ip -vlnv analog.com:user:jesd204_rx:1.0 rx ]
  set_property -dict [ list \
   CONFIG.LINK_MODE {1} \
   CONFIG.NUM_LANES {2} \
   CONFIG.NUM_LINKS {1} \
 ] $rx

  # Create instance: rx_axi, and set properties
  set rx_axi [ create_bd_cell -type ip -vlnv analog.com:user:axi_jesd204_rx:1.0 rx_axi ]
  set_property -dict [ list \
   CONFIG.LINK_MODE {1} \
   CONFIG.NUM_LANES {2} \
   CONFIG.NUM_LINKS {1} \
 ] $rx_axi

  # Create interface connections
  connect_bd_intf_net -intf_net rx_axi_rx_cfg [get_bd_intf_pins rx/rx_cfg] [get_bd_intf_pins rx_axi/rx_cfg]
  connect_bd_intf_net -intf_net rx_phy0_1 [get_bd_intf_pins rx_phy0] [get_bd_intf_pins rx/rx_phy0]
  connect_bd_intf_net -intf_net rx_phy1_1 [get_bd_intf_pins rx_phy1] [get_bd_intf_pins rx/rx_phy1]
  connect_bd_intf_net -intf_net rx_rx_event [get_bd_intf_pins rx/rx_event] [get_bd_intf_pins rx_axi/rx_event]
  connect_bd_intf_net -intf_net rx_rx_ilas_config [get_bd_intf_pins rx/rx_ilas_config] [get_bd_intf_pins rx_axi/rx_ilas_config]
  connect_bd_intf_net -intf_net rx_rx_status [get_bd_intf_pins rx/rx_status] [get_bd_intf_pins rx_axi/rx_status]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins rx_axi/s_axi]

  # Create port connections
  connect_bd_net -net device_clk_1 [get_bd_pins device_clk] [get_bd_pins rx/device_clk] [get_bd_pins rx_axi/device_clk]
  connect_bd_net -net link_clk_1 [get_bd_pins link_clk] [get_bd_pins rx/clk] [get_bd_pins rx_axi/core_clk]
  connect_bd_net -net rx_axi_core_reset [get_bd_pins rx/reset] [get_bd_pins rx_axi/core_reset]
  connect_bd_net -net rx_axi_device_reset [get_bd_pins rx/device_reset] [get_bd_pins rx_axi/device_reset]
  connect_bd_net -net rx_axi_irq [get_bd_pins irq] [get_bd_pins rx_axi/irq]
  connect_bd_net -net rx_phy_en_char_align [get_bd_pins phy_en_char_align] [get_bd_pins rx/phy_en_char_align]
  connect_bd_net -net rx_rx_data [get_bd_pins rx_data_tdata] [get_bd_pins rx/rx_data]
  connect_bd_net -net rx_rx_eof [get_bd_pins rx_eof] [get_bd_pins rx/rx_eof]
  connect_bd_net -net rx_rx_sof [get_bd_pins rx_sof] [get_bd_pins rx/rx_sof]
  connect_bd_net -net rx_rx_valid [get_bd_pins rx_data_tvalid] [get_bd_pins rx/rx_valid]
  connect_bd_net -net rx_sync [get_bd_pins sync] [get_bd_pins rx/sync]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins rx_axi/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins rx_axi/s_axi_aresetn]
  connect_bd_net -net sysref_1 [get_bd_pins sysref] [get_bd_pins rx/sysref]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ddr [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr ]

  set ddr3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr3 ]

  set fixed_io [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 fixed_io ]

  set iic_main [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_main ]

  set sys_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk ]


  # Create ports
  set adc_fir_filter_active [ create_bd_port -dir I adc_fir_filter_active ]
  set dac_fifo_bypass [ create_bd_port -dir I dac_fifo_bypass ]
  set dac_fir_filter_active [ create_bd_port -dir I dac_fir_filter_active ]
  set gpio_i [ create_bd_port -dir I -from 63 -to 0 gpio_i ]
  set gpio_o [ create_bd_port -dir O -from 63 -to 0 gpio_o ]
  set gpio_t [ create_bd_port -dir O -from 63 -to 0 gpio_t ]
  set rx_data_0_n [ create_bd_port -dir I rx_data_0_n ]
  set rx_data_0_p [ create_bd_port -dir I rx_data_0_p ]
  set rx_data_1_n [ create_bd_port -dir I rx_data_1_n ]
  set rx_data_1_p [ create_bd_port -dir I rx_data_1_p ]
  set rx_data_2_n [ create_bd_port -dir I rx_data_2_n ]
  set rx_data_2_p [ create_bd_port -dir I rx_data_2_p ]
  set rx_data_3_n [ create_bd_port -dir I rx_data_3_n ]
  set rx_data_3_p [ create_bd_port -dir I rx_data_3_p ]
  set rx_ref_clk_0 [ create_bd_port -dir I rx_ref_clk_0 ]
  set rx_ref_clk_2 [ create_bd_port -dir I rx_ref_clk_2 ]
  set rx_sync_0 [ create_bd_port -dir O -from 0 -to 0 rx_sync_0 ]
  set rx_sync_2 [ create_bd_port -dir O -from 0 -to 0 rx_sync_2 ]
  set rx_sysref_0 [ create_bd_port -dir I rx_sysref_0 ]
  set rx_sysref_2 [ create_bd_port -dir I rx_sysref_2 ]
  set spi0_clk_i [ create_bd_port -dir I spi0_clk_i ]
  set spi0_clk_o [ create_bd_port -dir O spi0_clk_o ]
  set spi0_csn_0_o [ create_bd_port -dir O spi0_csn_0_o ]
  set spi0_csn_1_o [ create_bd_port -dir O spi0_csn_1_o ]
  set spi0_csn_2_o [ create_bd_port -dir O spi0_csn_2_o ]
  set spi0_csn_i [ create_bd_port -dir I spi0_csn_i ]
  set spi0_sdi_i [ create_bd_port -dir I spi0_sdi_i ]
  set spi0_sdo_i [ create_bd_port -dir I spi0_sdo_i ]
  set spi0_sdo_o [ create_bd_port -dir O spi0_sdo_o ]
  set spi1_clk_i [ create_bd_port -dir I spi1_clk_i ]
  set spi1_clk_o [ create_bd_port -dir O spi1_clk_o ]
  set spi1_csn_0_o [ create_bd_port -dir O spi1_csn_0_o ]
  set spi1_csn_1_o [ create_bd_port -dir O spi1_csn_1_o ]
  set spi1_csn_2_o [ create_bd_port -dir O spi1_csn_2_o ]
  set spi1_csn_i [ create_bd_port -dir I spi1_csn_i ]
  set spi1_sdi_i [ create_bd_port -dir I spi1_sdi_i ]
  set spi1_sdo_i [ create_bd_port -dir I spi1_sdo_i ]
  set spi1_sdo_o [ create_bd_port -dir O spi1_sdo_o ]
  set sys_rst [ create_bd_port -dir I -type rst sys_rst ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $sys_rst
  set tx_data_0_n [ create_bd_port -dir O tx_data_0_n ]
  set tx_data_0_p [ create_bd_port -dir O tx_data_0_p ]
  set tx_data_1_n [ create_bd_port -dir O tx_data_1_n ]
  set tx_data_1_p [ create_bd_port -dir O tx_data_1_p ]
  set tx_data_2_n [ create_bd_port -dir O tx_data_2_n ]
  set tx_data_2_p [ create_bd_port -dir O tx_data_2_p ]
  set tx_data_3_n [ create_bd_port -dir O tx_data_3_n ]
  set tx_data_3_p [ create_bd_port -dir O tx_data_3_p ]
  set tx_ref_clk_0 [ create_bd_port -dir I tx_ref_clk_0 ]
  set tx_sync_0 [ create_bd_port -dir I -from 0 -to 0 tx_sync_0 ]
  set tx_sysref_0 [ create_bd_port -dir I tx_sysref_0 ]

  # Create instance: GND_1, and set properties
  set GND_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $GND_1

  # Create instance: GND_32, and set properties
  set GND_32 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND_32 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $GND_32

  # Create instance: VCC_1, and set properties
  set VCC_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 VCC_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $VCC_1

  # Create instance: ad9371_rx_device_clk_rstgen, and set properties
  set ad9371_rx_device_clk_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ad9371_rx_device_clk_rstgen ]

  # Create instance: ad9371_rx_os_device_clk_rstgen, and set properties
  set ad9371_rx_os_device_clk_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ad9371_rx_os_device_clk_rstgen ]

  # Create instance: ad9371_tx_device_clk_rstgen, and set properties
  set ad9371_tx_device_clk_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ad9371_tx_device_clk_rstgen ]

  # Create instance: axi_ad9371_dacfifo, and set properties
  set axi_ad9371_dacfifo [ create_bd_cell -type ip -vlnv analog.com:user:axi_dacfifo:1.0 axi_ad9371_dacfifo ]
  set_property -dict [ list \
   CONFIG.AXI_ADDRESS {0x80000000} \
   CONFIG.AXI_ADDRESS_LIMIT {0xbfffffff} \
   CONFIG.AXI_DATA_WIDTH {512} \
   CONFIG.AXI_LENGTH {255} \
   CONFIG.AXI_SIZE {6} \
   CONFIG.DAC_DATA_WIDTH {32} \
   CONFIG.DMA_DATA_WIDTH {128} \
 ] $axi_ad9371_dacfifo

  # Create instance: axi_ad9371_dacfifo_axi_periph, and set properties
  set axi_ad9371_dacfifo_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_ad9371_dacfifo_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $axi_ad9371_dacfifo_axi_periph

  # Create instance: axi_ad9371_rx_clkgen, and set properties
  set axi_ad9371_rx_clkgen [ create_bd_cell -type ip -vlnv analog.com:user:axi_clkgen:1.0 axi_ad9371_rx_clkgen ]
  set_property -dict [ list \
   CONFIG.CLK0_DIV {8} \
   CONFIG.CLKIN_PERIOD {8} \
   CONFIG.ID {2} \
   CONFIG.VCO_DIV {1} \
   CONFIG.VCO_MUL {8} \
 ] $axi_ad9371_rx_clkgen

  # Create instance: axi_ad9371_rx_dma, and set properties
  set axi_ad9371_rx_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9371_rx_dma ]
  set_property -dict [ list \
   CONFIG.ASYNC_CLK_DEST_REQ {true} \
   CONFIG.ASYNC_CLK_REQ_SRC {true} \
   CONFIG.ASYNC_CLK_SRC_DEST {true} \
   CONFIG.AXI_SLICE_DEST {false} \
   CONFIG.AXI_SLICE_SRC {false} \
   CONFIG.CYCLIC {false} \
   CONFIG.DMA_2D_TRANSFER {false} \
   CONFIG.DMA_DATA_WIDTH_SRC {64} \
   CONFIG.DMA_TYPE_DEST {0} \
   CONFIG.DMA_TYPE_SRC {2} \
   CONFIG.SYNC_TRANSFER_START {true} \
 ] $axi_ad9371_rx_dma

  # Create instance: axi_ad9371_rx_jesd
  create_hier_cell_axi_ad9371_rx_jesd [current_bd_instance .] axi_ad9371_rx_jesd

  # Create instance: axi_ad9371_rx_os_clkgen, and set properties
  set axi_ad9371_rx_os_clkgen [ create_bd_cell -type ip -vlnv analog.com:user:axi_clkgen:1.0 axi_ad9371_rx_os_clkgen ]
  set_property -dict [ list \
   CONFIG.CLK0_DIV {8} \
   CONFIG.CLKIN_PERIOD {8} \
   CONFIG.ID {2} \
   CONFIG.VCO_DIV {1} \
   CONFIG.VCO_MUL {8} \
 ] $axi_ad9371_rx_os_clkgen

  # Create instance: axi_ad9371_rx_os_dma, and set properties
  set axi_ad9371_rx_os_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9371_rx_os_dma ]
  set_property -dict [ list \
   CONFIG.ASYNC_CLK_DEST_REQ {true} \
   CONFIG.ASYNC_CLK_REQ_SRC {true} \
   CONFIG.ASYNC_CLK_SRC_DEST {true} \
   CONFIG.AXI_SLICE_DEST {false} \
   CONFIG.AXI_SLICE_SRC {false} \
   CONFIG.CYCLIC {false} \
   CONFIG.DMA_2D_TRANSFER {false} \
   CONFIG.DMA_DATA_WIDTH_SRC {64} \
   CONFIG.DMA_TYPE_DEST {0} \
   CONFIG.DMA_TYPE_SRC {2} \
   CONFIG.SYNC_TRANSFER_START {true} \
 ] $axi_ad9371_rx_os_dma

  # Create instance: axi_ad9371_rx_os_jesd
  create_hier_cell_axi_ad9371_rx_os_jesd [current_bd_instance .] axi_ad9371_rx_os_jesd

  # Create instance: axi_ad9371_rx_os_xcvr, and set properties
  set axi_ad9371_rx_os_xcvr [ create_bd_cell -type ip -vlnv analog.com:user:axi_adxcvr:1.0 axi_ad9371_rx_os_xcvr ]
  set_property -dict [ list \
   CONFIG.LPM_OR_DFE_N {1} \
   CONFIG.NUM_OF_LANES {2} \
   CONFIG.OUT_CLK_SEL {"011"} \
   CONFIG.QPLL_ENABLE {0} \
   CONFIG.SYS_CLK_SEL {00} \
   CONFIG.TX_OR_RX_N {0} \
 ] $axi_ad9371_rx_os_xcvr

  # Create instance: axi_ad9371_rx_xcvr, and set properties
  set axi_ad9371_rx_xcvr [ create_bd_cell -type ip -vlnv analog.com:user:axi_adxcvr:1.0 axi_ad9371_rx_xcvr ]
  set_property -dict [ list \
   CONFIG.LPM_OR_DFE_N {1} \
   CONFIG.NUM_OF_LANES {2} \
   CONFIG.OUT_CLK_SEL {"011"} \
   CONFIG.QPLL_ENABLE {0} \
   CONFIG.SYS_CLK_SEL {00} \
   CONFIG.TX_OR_RX_N {0} \
 ] $axi_ad9371_rx_xcvr

  # Create instance: axi_ad9371_tx_clkgen, and set properties
  set axi_ad9371_tx_clkgen [ create_bd_cell -type ip -vlnv analog.com:user:axi_clkgen:1.0 axi_ad9371_tx_clkgen ]
  set_property -dict [ list \
   CONFIG.CLK0_DIV {8} \
   CONFIG.CLKIN_PERIOD {8} \
   CONFIG.ID {2} \
   CONFIG.VCO_DIV {1} \
   CONFIG.VCO_MUL {8} \
 ] $axi_ad9371_tx_clkgen

  # Create instance: axi_ad9371_tx_dma, and set properties
  set axi_ad9371_tx_dma [ create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9371_tx_dma ]
  set_property -dict [ list \
   CONFIG.ASYNC_CLK_DEST_REQ {true} \
   CONFIG.ASYNC_CLK_REQ_SRC {true} \
   CONFIG.ASYNC_CLK_SRC_DEST {true} \
   CONFIG.AXI_SLICE_DEST {true} \
   CONFIG.AXI_SLICE_SRC {false} \
   CONFIG.CYCLIC {true} \
   CONFIG.DMA_2D_TRANSFER {false} \
   CONFIG.DMA_DATA_WIDTH_DEST {128} \
   CONFIG.DMA_TYPE_DEST {1} \
   CONFIG.DMA_TYPE_SRC {0} \
 ] $axi_ad9371_tx_dma

  # Create instance: axi_ad9371_tx_jesd
  create_hier_cell_axi_ad9371_tx_jesd [current_bd_instance .] axi_ad9371_tx_jesd

  # Create instance: axi_ad9371_tx_xcvr, and set properties
  set axi_ad9371_tx_xcvr [ create_bd_cell -type ip -vlnv analog.com:user:axi_adxcvr:1.0 axi_ad9371_tx_xcvr ]
  set_property -dict [ list \
   CONFIG.LPM_OR_DFE_N {0} \
   CONFIG.NUM_OF_LANES {4} \
   CONFIG.OUT_CLK_SEL {"011"} \
   CONFIG.QPLL_ENABLE {1} \
   CONFIG.SYS_CLK_SEL {"11"} \
   CONFIG.TX_OR_RX_N {1} \
 ] $axi_ad9371_tx_xcvr

  # Create instance: axi_cpu_interconnect, and set properties
  set axi_cpu_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_cpu_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {19} \
 ] $axi_cpu_interconnect

  # Create instance: axi_fifo_mm_s, and set properties
  set axi_fifo_mm_s [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_fifo_mm_s:4.2 axi_fifo_mm_s ]
  set_property -dict [ list \
   CONFIG.C_USE_RX_DATA {0} \
 ] $axi_fifo_mm_s

  # Create instance: axi_hp1_interconnect, and set properties
  set axi_hp1_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_hp1_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
 ] $axi_hp1_interconnect

  # Create instance: axi_hp2_interconnect, and set properties
  set axi_hp2_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_hp2_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
 ] $axi_hp2_interconnect

  # Create instance: axi_hp3_interconnect, and set properties
  set axi_hp3_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_hp3_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
 ] $axi_hp3_interconnect

  # Create instance: axi_iic_main, and set properties
  set axi_iic_main [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_main ]
  set_property -dict [ list \
   CONFIG.IIC_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_iic_main

  # Create instance: axi_rstgen, and set properties
  set axi_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 axi_rstgen ]

  # Create instance: axi_sysid_0, and set properties
  set axi_sysid_0 [ create_bd_cell -type ip -vlnv analog.com:user:axi_sysid:1.0 axi_sysid_0 ]
  set_property -dict [ list \
   CONFIG.ROM_ADDR_BITS {9} \
 ] $axi_sysid_0

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Type_AXI {Independent_Clock} \
   CONFIG.Empty_Threshold_Assert_Value_axis {13} \
   CONFIG.Empty_Threshold_Assert_Value_rach {13} \
   CONFIG.Empty_Threshold_Assert_Value_rdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wach {13} \
   CONFIG.Empty_Threshold_Assert_Value_wdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {13} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_axis {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_rach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_rdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wrch {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {15} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.HAS_ACLKEN {false} \
   CONFIG.HAS_TKEEP {true} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TKEEP_WIDTH {4} \
   CONFIG.TSTRB_WIDTH {4} \
 ] $fifo_generator_0

  # Create instance: rom_sys_0, and set properties
  set rom_sys_0 [ create_bd_cell -type ip -vlnv analog.com:user:sysid_rom:1.0 rom_sys_0 ]
  set_property -dict [ list \
   CONFIG.PATH_TO_FILE {c:/Users/yrrapt/Repositories/analogdevices_hdl/projects/adrv9371x/zc706/mem_init_sys.txt} \
   CONFIG.ROM_ADDR_BITS {9} \
 ] $rom_sys_0

  # Create instance: rx_ad9371_tpl_core
  create_hier_cell_rx_ad9371_tpl_core [current_bd_instance .] rx_ad9371_tpl_core

  # Create instance: rx_fir_decimator
  create_hier_cell_rx_fir_decimator [current_bd_instance .] rx_fir_decimator

  # Create instance: rx_os_ad9371_tpl_core
  create_hier_cell_rx_os_ad9371_tpl_core [current_bd_instance .] rx_os_ad9371_tpl_core

  # Create instance: sys_200m_rstgen, and set properties
  set sys_200m_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_200m_rstgen ]
  set_property -dict [ list \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $sys_200m_rstgen

  # Create instance: sys_concat_intc, and set properties
  set sys_concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 sys_concat_intc ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {16} \
 ] $sys_concat_intc

  # Create instance: sys_ps7, and set properties
  set sys_ps7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 sys_ps7 ]
  set_property -dict [ list \
   CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {666.666687} \
   CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
   CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {25.000000} \
   CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
   CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {166.666672} \
   CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {667.000000} \
   CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
   CONFIG.PCW_CAN0_GRP_CLK_ENABLE {0} \
   CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ {100} \
   CONFIG.PCW_CLK0_FREQ {100000000} \
   CONFIG.PCW_CLK1_FREQ {200000000} \
   CONFIG.PCW_CLK2_FREQ {200000000} \
   CONFIG.PCW_CLK3_FREQ {10000000} \
   CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
   CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
   CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
   CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
   CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
   CONFIG.PCW_DUAL_PARALLEL_QSPI_DATA_MODE {x8} \
   CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
   CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
   CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {5} \
   CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {100 Mbps} \
   CONFIG.PCW_ENET0_RESET_ENABLE {1} \
   CONFIG.PCW_ENET0_RESET_IO {MIO 47} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET1_RESET_ENABLE {0} \
   CONFIG.PCW_ENET_RESET_ENABLE {1} \
   CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_EN_CLK1_PORT {1} \
   CONFIG.PCW_EN_CLK2_PORT {1} \
   CONFIG.PCW_EN_EMIO_GPIO {1} \
   CONFIG.PCW_EN_EMIO_SPI0 {1} \
   CONFIG.PCW_EN_EMIO_SPI1 {1} \
   CONFIG.PCW_EN_EMIO_TTC0 {0} \
   CONFIG.PCW_EN_ENET0 {1} \
   CONFIG.PCW_EN_GPIO {1} \
   CONFIG.PCW_EN_I2C0 {1} \
   CONFIG.PCW_EN_QSPI {1} \
   CONFIG.PCW_EN_RST1_PORT {1} \
   CONFIG.PCW_EN_RST2_PORT {1} \
   CONFIG.PCW_EN_SDIO0 {1} \
   CONFIG.PCW_EN_SPI0 {1} \
   CONFIG.PCW_EN_SPI1 {1} \
   CONFIG.PCW_EN_TTC0 {0} \
   CONFIG.PCW_EN_UART1 {1} \
   CONFIG.PCW_EN_USB0 {1} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {2} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK_CLK1_BUF {TRUE} \
   CONFIG.PCW_FCLK_CLK2_BUF {TRUE} \
   CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} \
   CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.0} \
   CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
   CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK2_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK3_ENABLE {0} \
   CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
   CONFIG.PCW_GPIO_EMIO_GPIO_IO {64} \
   CONFIG.PCW_GPIO_EMIO_GPIO_WIDTH {64} \
   CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
   CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
   CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
   CONFIG.PCW_I2C0_I2C0_IO {MIO 50 .. 51} \
   CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_I2C0_RESET_ENABLE {1} \
   CONFIG.PCW_I2C0_RESET_IO {MIO 46} \
   CONFIG.PCW_I2C1_RESET_ENABLE {0} \
   CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_I2C_RESET_ENABLE {1} \
   CONFIG.PCW_I2C_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
   CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
   CONFIG.PCW_IRQ_F2P_INTR {1} \
   CONFIG.PCW_IRQ_F2P_MODE {REVERSE} \
   CONFIG.PCW_MIO_0_DIRECTION {out} \
   CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_0_PULLUP {enabled} \
   CONFIG.PCW_MIO_0_SLEW {slow} \
   CONFIG.PCW_MIO_10_DIRECTION {inout} \
   CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_10_PULLUP {enabled} \
   CONFIG.PCW_MIO_10_SLEW {slow} \
   CONFIG.PCW_MIO_11_DIRECTION {inout} \
   CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_11_PULLUP {enabled} \
   CONFIG.PCW_MIO_11_SLEW {slow} \
   CONFIG.PCW_MIO_12_DIRECTION {inout} \
   CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_12_PULLUP {enabled} \
   CONFIG.PCW_MIO_12_SLEW {slow} \
   CONFIG.PCW_MIO_13_DIRECTION {inout} \
   CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_13_PULLUP {enabled} \
   CONFIG.PCW_MIO_13_SLEW {slow} \
   CONFIG.PCW_MIO_14_DIRECTION {in} \
   CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_14_PULLUP {enabled} \
   CONFIG.PCW_MIO_14_SLEW {slow} \
   CONFIG.PCW_MIO_15_DIRECTION {in} \
   CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_15_PULLUP {enabled} \
   CONFIG.PCW_MIO_15_SLEW {slow} \
   CONFIG.PCW_MIO_16_DIRECTION {out} \
   CONFIG.PCW_MIO_16_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_16_PULLUP {disabled} \
   CONFIG.PCW_MIO_16_SLEW {slow} \
   CONFIG.PCW_MIO_17_DIRECTION {out} \
   CONFIG.PCW_MIO_17_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_17_PULLUP {disabled} \
   CONFIG.PCW_MIO_17_SLEW {slow} \
   CONFIG.PCW_MIO_18_DIRECTION {out} \
   CONFIG.PCW_MIO_18_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_18_PULLUP {disabled} \
   CONFIG.PCW_MIO_18_SLEW {slow} \
   CONFIG.PCW_MIO_19_DIRECTION {out} \
   CONFIG.PCW_MIO_19_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_19_PULLUP {disabled} \
   CONFIG.PCW_MIO_19_SLEW {slow} \
   CONFIG.PCW_MIO_1_DIRECTION {out} \
   CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_1_PULLUP {enabled} \
   CONFIG.PCW_MIO_1_SLEW {slow} \
   CONFIG.PCW_MIO_20_DIRECTION {out} \
   CONFIG.PCW_MIO_20_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_20_PULLUP {disabled} \
   CONFIG.PCW_MIO_20_SLEW {slow} \
   CONFIG.PCW_MIO_21_DIRECTION {out} \
   CONFIG.PCW_MIO_21_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_21_PULLUP {disabled} \
   CONFIG.PCW_MIO_21_SLEW {slow} \
   CONFIG.PCW_MIO_22_DIRECTION {in} \
   CONFIG.PCW_MIO_22_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_22_PULLUP {disabled} \
   CONFIG.PCW_MIO_22_SLEW {slow} \
   CONFIG.PCW_MIO_23_DIRECTION {in} \
   CONFIG.PCW_MIO_23_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_23_PULLUP {disabled} \
   CONFIG.PCW_MIO_23_SLEW {slow} \
   CONFIG.PCW_MIO_24_DIRECTION {in} \
   CONFIG.PCW_MIO_24_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_24_PULLUP {disabled} \
   CONFIG.PCW_MIO_24_SLEW {slow} \
   CONFIG.PCW_MIO_25_DIRECTION {in} \
   CONFIG.PCW_MIO_25_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_25_PULLUP {disabled} \
   CONFIG.PCW_MIO_25_SLEW {slow} \
   CONFIG.PCW_MIO_26_DIRECTION {in} \
   CONFIG.PCW_MIO_26_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_26_PULLUP {disabled} \
   CONFIG.PCW_MIO_26_SLEW {slow} \
   CONFIG.PCW_MIO_27_DIRECTION {in} \
   CONFIG.PCW_MIO_27_IOTYPE {HSTL 1.8V} \
   CONFIG.PCW_MIO_27_PULLUP {disabled} \
   CONFIG.PCW_MIO_27_SLEW {slow} \
   CONFIG.PCW_MIO_28_DIRECTION {inout} \
   CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_28_PULLUP {disabled} \
   CONFIG.PCW_MIO_28_SLEW {slow} \
   CONFIG.PCW_MIO_29_DIRECTION {in} \
   CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_29_PULLUP {disabled} \
   CONFIG.PCW_MIO_29_SLEW {slow} \
   CONFIG.PCW_MIO_2_DIRECTION {inout} \
   CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_2_PULLUP {disabled} \
   CONFIG.PCW_MIO_2_SLEW {slow} \
   CONFIG.PCW_MIO_30_DIRECTION {out} \
   CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_30_PULLUP {disabled} \
   CONFIG.PCW_MIO_30_SLEW {slow} \
   CONFIG.PCW_MIO_31_DIRECTION {in} \
   CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_31_PULLUP {disabled} \
   CONFIG.PCW_MIO_31_SLEW {slow} \
   CONFIG.PCW_MIO_32_DIRECTION {inout} \
   CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_32_PULLUP {disabled} \
   CONFIG.PCW_MIO_32_SLEW {slow} \
   CONFIG.PCW_MIO_33_DIRECTION {inout} \
   CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_33_PULLUP {disabled} \
   CONFIG.PCW_MIO_33_SLEW {slow} \
   CONFIG.PCW_MIO_34_DIRECTION {inout} \
   CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_34_PULLUP {disabled} \
   CONFIG.PCW_MIO_34_SLEW {slow} \
   CONFIG.PCW_MIO_35_DIRECTION {inout} \
   CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_35_PULLUP {disabled} \
   CONFIG.PCW_MIO_35_SLEW {slow} \
   CONFIG.PCW_MIO_36_DIRECTION {in} \
   CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_36_PULLUP {disabled} \
   CONFIG.PCW_MIO_36_SLEW {slow} \
   CONFIG.PCW_MIO_37_DIRECTION {inout} \
   CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_37_PULLUP {disabled} \
   CONFIG.PCW_MIO_37_SLEW {slow} \
   CONFIG.PCW_MIO_38_DIRECTION {inout} \
   CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_38_PULLUP {disabled} \
   CONFIG.PCW_MIO_38_SLEW {slow} \
   CONFIG.PCW_MIO_39_DIRECTION {inout} \
   CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_39_PULLUP {disabled} \
   CONFIG.PCW_MIO_39_SLEW {slow} \
   CONFIG.PCW_MIO_3_DIRECTION {inout} \
   CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_3_PULLUP {disabled} \
   CONFIG.PCW_MIO_3_SLEW {slow} \
   CONFIG.PCW_MIO_40_DIRECTION {inout} \
   CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_40_PULLUP {disabled} \
   CONFIG.PCW_MIO_40_SLEW {slow} \
   CONFIG.PCW_MIO_41_DIRECTION {inout} \
   CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_41_PULLUP {disabled} \
   CONFIG.PCW_MIO_41_SLEW {slow} \
   CONFIG.PCW_MIO_42_DIRECTION {inout} \
   CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_42_PULLUP {disabled} \
   CONFIG.PCW_MIO_42_SLEW {slow} \
   CONFIG.PCW_MIO_43_DIRECTION {inout} \
   CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_43_PULLUP {disabled} \
   CONFIG.PCW_MIO_43_SLEW {slow} \
   CONFIG.PCW_MIO_44_DIRECTION {inout} \
   CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_44_PULLUP {disabled} \
   CONFIG.PCW_MIO_44_SLEW {slow} \
   CONFIG.PCW_MIO_45_DIRECTION {inout} \
   CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_45_PULLUP {disabled} \
   CONFIG.PCW_MIO_45_SLEW {slow} \
   CONFIG.PCW_MIO_46_DIRECTION {out} \
   CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_46_PULLUP {enabled} \
   CONFIG.PCW_MIO_46_SLEW {slow} \
   CONFIG.PCW_MIO_47_DIRECTION {out} \
   CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_47_PULLUP {enabled} \
   CONFIG.PCW_MIO_47_SLEW {slow} \
   CONFIG.PCW_MIO_48_DIRECTION {out} \
   CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_48_PULLUP {disabled} \
   CONFIG.PCW_MIO_48_SLEW {slow} \
   CONFIG.PCW_MIO_49_DIRECTION {in} \
   CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_49_PULLUP {disabled} \
   CONFIG.PCW_MIO_49_SLEW {slow} \
   CONFIG.PCW_MIO_4_DIRECTION {inout} \
   CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_4_PULLUP {disabled} \
   CONFIG.PCW_MIO_4_SLEW {slow} \
   CONFIG.PCW_MIO_50_DIRECTION {inout} \
   CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_50_PULLUP {enabled} \
   CONFIG.PCW_MIO_50_SLEW {slow} \
   CONFIG.PCW_MIO_51_DIRECTION {inout} \
   CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_51_PULLUP {enabled} \
   CONFIG.PCW_MIO_51_SLEW {slow} \
   CONFIG.PCW_MIO_52_DIRECTION {out} \
   CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_52_PULLUP {disabled} \
   CONFIG.PCW_MIO_52_SLEW {slow} \
   CONFIG.PCW_MIO_53_DIRECTION {inout} \
   CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_53_PULLUP {disabled} \
   CONFIG.PCW_MIO_53_SLEW {slow} \
   CONFIG.PCW_MIO_5_DIRECTION {inout} \
   CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_5_PULLUP {disabled} \
   CONFIG.PCW_MIO_5_SLEW {slow} \
   CONFIG.PCW_MIO_6_DIRECTION {out} \
   CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_6_PULLUP {disabled} \
   CONFIG.PCW_MIO_6_SLEW {slow} \
   CONFIG.PCW_MIO_7_DIRECTION {out} \
   CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_7_PULLUP {disabled} \
   CONFIG.PCW_MIO_7_SLEW {slow} \
   CONFIG.PCW_MIO_8_DIRECTION {out} \
   CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_8_PULLUP {disabled} \
   CONFIG.PCW_MIO_8_SLEW {slow} \
   CONFIG.PCW_MIO_9_DIRECTION {out} \
   CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_9_PULLUP {enabled} \
   CONFIG.PCW_MIO_9_SLEW {slow} \
   CONFIG.PCW_MIO_TREE_PERIPHERALS { \
     0#Enet 0 \
     0#Enet 0 \
     0#Enet 0 \
     0#Enet 0 \
     0#Enet 0 \
     0#Enet 0 \
     0#Enet 0 \
     0#I2C 0#Enet \
     0#SD 0#I2C \
     0#SD 0#I2C \
     0#SD 0#I2C \
     0#SD 0#I2C \
     0#USB 0#SD \
     0#USB 0#SD \
     0#USB 0#SD \
     0#USB 0#SD \
     0#USB 0#SD \
     0#USB 0#SD \
     1#UART 1#I2C \
     Flash#Quad SPI \
     Flash#Quad SPI \
     Flash#Quad SPI \
     Flash#Quad SPI \
     Flash#Quad SPI \
     Flash#Quad SPI \
     Flash#USB Reset#Quad \
     Quad SPI \
     Reset#ENET Reset#UART \
     SPI Flash#SD \
     SPI Flash#SD \
     SPI Flash#SD \
     SPI Flash#SD \
     SPI Flash#SD \
     SPI Flash#SD \
   } \
   CONFIG.PCW_MIO_TREE_SIGNALS {qspi1_ss_b#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]/HOLD_B#qspi0_sclk#reset#qspi_fbclk#qspi1_sclk#qspi1_io[0]#qspi1_io[1]#qspi1_io[2]#qspi1_io[3]#cd#wp#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#reset#reset#tx#rx#scl#sda#mdc#mdio} \
   CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
   CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
   CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V} \
   CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
   CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} \
   CONFIG.PCW_QSPI_GRP_IO1_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_IO1_IO {MIO 0 9 .. 13} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} \
   CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
   CONFIG.PCW_QSPI_INTERNAL_HIGHADDRESS {0xFDFFFFFF} \
   CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
   CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
   CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
   CONFIG.PCW_SD0_GRP_CD_IO {MIO 14} \
   CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
   CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
   CONFIG.PCW_SD0_GRP_WP_IO {MIO 15} \
   CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
   CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
   CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_SPI0_GRP_SS0_ENABLE {1} \
   CONFIG.PCW_SPI0_GRP_SS0_IO {EMIO} \
   CONFIG.PCW_SPI0_GRP_SS1_ENABLE {1} \
   CONFIG.PCW_SPI0_GRP_SS1_IO {EMIO} \
   CONFIG.PCW_SPI0_GRP_SS2_ENABLE {1} \
   CONFIG.PCW_SPI0_GRP_SS2_IO {EMIO} \
   CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SPI0_SPI0_IO {EMIO} \
   CONFIG.PCW_SPI1_GRP_SS0_ENABLE {1} \
   CONFIG.PCW_SPI1_GRP_SS0_IO {EMIO} \
   CONFIG.PCW_SPI1_GRP_SS1_ENABLE {1} \
   CONFIG.PCW_SPI1_GRP_SS1_IO {EMIO} \
   CONFIG.PCW_SPI1_GRP_SS2_ENABLE {1} \
   CONFIG.PCW_SPI1_GRP_SS2_IO {EMIO} \
   CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SPI1_SPI1_IO {EMIO} \
   CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {6} \
   CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
   CONFIG.PCW_SPI_PERIPHERAL_VALID {1} \
   CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_TTC0_TTC0_IO {<Select>} \
   CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
   CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
   CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
   CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
   CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
   CONFIG.PCW_UIPARAM_DDR_BL {8} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.521} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.636} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.54} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.621} \
   CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
   CONFIG.PCW_UIPARAM_DDR_CL {7} \
   CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
   CONFIG.PCW_UIPARAM_DDR_CWL {6} \
   CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {2048 MBits} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.226} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.278} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.184} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.309} \
   CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {8 Bits} \
   CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
   CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333313} \
   CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
   CONFIG.PCW_UIPARAM_DDR_PARTNO {Custom} \
   CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
   CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
   CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
   CONFIG.PCW_UIPARAM_DDR_T_FAW {30.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {36.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RC {49.5} \
   CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
   CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
   CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} \
   CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
   CONFIG.PCW_USB0_RESET_ENABLE {1} \
   CONFIG.PCW_USB0_RESET_IO {MIO 7} \
   CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
   CONFIG.PCW_USB1_RESET_ENABLE {0} \
   CONFIG.PCW_USB_RESET_ENABLE {1} \
   CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_USE_DMA0 {1} \
   CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
   CONFIG.PCW_USE_S_AXI_HP0 {1} \
   CONFIG.PCW_USE_S_AXI_HP1 {1} \
   CONFIG.PCW_USE_S_AXI_HP2 {1} \
   CONFIG.PCW_USE_S_AXI_HP3 {1} \
   CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ {133.333333} \
   CONFIG.preset {ZC706} \
 ] $sys_ps7

  # Create instance: sys_rstgen, and set properties
  set sys_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rstgen ]
  set_property -dict [ list \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $sys_rstgen

  # Create instance: tx_ad9371_tpl_core
  create_hier_cell_tx_ad9371_tpl_core [current_bd_instance .] tx_ad9371_tpl_core

  # Create instance: tx_dvb
  create_hier_cell_tx_dvb [current_bd_instance .] tx_dvb

  # Create instance: util_ad9371_rx_cpack, and set properties
  set util_ad9371_rx_cpack [ create_bd_cell -type ip -vlnv analog.com:user:util_cpack2:1.0 util_ad9371_rx_cpack ]
  set_property -dict [ list \
   CONFIG.NUM_OF_CHANNELS {4} \
   CONFIG.SAMPLES_PER_CHANNEL {1} \
   CONFIG.SAMPLE_DATA_WIDTH {16} \
 ] $util_ad9371_rx_cpack

  # Create instance: util_ad9371_rx_os_cpack, and set properties
  set util_ad9371_rx_os_cpack [ create_bd_cell -type ip -vlnv analog.com:user:util_cpack2:1.0 util_ad9371_rx_os_cpack ]
  set_property -dict [ list \
   CONFIG.NUM_OF_CHANNELS {2} \
   CONFIG.SAMPLES_PER_CHANNEL {2} \
   CONFIG.SAMPLE_DATA_WIDTH {16} \
 ] $util_ad9371_rx_os_cpack

  # Create instance: util_ad9371_xcvr, and set properties
  set util_ad9371_xcvr [ create_bd_cell -type ip -vlnv analog.com:user:util_adxcvr:1.0 util_ad9371_xcvr ]
  set_property -dict [ list \
   CONFIG.CPLL_FBDIV {4} \
   CONFIG.QPLL_FBDIV {0x120} \
   CONFIG.RX_CDR_CFG {0x03000023ff20400020} \
   CONFIG.RX_CLK25_DIV {5} \
   CONFIG.RX_NUM_OF_LANES {4} \
   CONFIG.RX_PMA_CFG {0x00018480} \
   CONFIG.TX_CLK25_DIV {5} \
   CONFIG.TX_NUM_OF_LANES {4} \
   CONFIG.TX_OUT_DIV {2} \
 ] $util_ad9371_xcvr

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_cpu_interconnect/S00_AXI] [get_bd_intf_pins sys_ps7/M_AXI_GP0]
  connect_bd_intf_net -intf_net axi_ad9371_dacfifo_axi [get_bd_intf_pins axi_ad9371_dacfifo/axi] [get_bd_intf_pins axi_ad9371_dacfifo_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net axi_ad9371_dacfifo_axi_periph_M00_AXI [get_bd_intf_pins axi_ad9371_dacfifo_axi_periph/M00_AXI] [get_bd_intf_pins axi_fifo_mm_s/S_AXI]
  connect_bd_intf_net -intf_net axi_ad9371_rx_dma_m_dest_axi [get_bd_intf_pins axi_ad9371_rx_dma/m_dest_axi] [get_bd_intf_pins axi_hp2_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_ad9371_rx_os_dma_m_dest_axi [get_bd_intf_pins axi_ad9371_rx_os_dma/m_dest_axi] [get_bd_intf_pins axi_hp2_interconnect/S01_AXI]
  connect_bd_intf_net -intf_net axi_ad9371_rx_os_xcvr_m_axi [get_bd_intf_pins axi_ad9371_rx_os_xcvr/m_axi] [get_bd_intf_pins axi_hp3_interconnect/S01_AXI]
  connect_bd_intf_net -intf_net axi_ad9371_rx_os_xcvr_up_ch_0 [get_bd_intf_pins axi_ad9371_rx_os_xcvr/up_ch_0] [get_bd_intf_pins util_ad9371_xcvr/up_rx_2]
  connect_bd_intf_net -intf_net axi_ad9371_rx_os_xcvr_up_ch_1 [get_bd_intf_pins axi_ad9371_rx_os_xcvr/up_ch_1] [get_bd_intf_pins util_ad9371_xcvr/up_rx_3]
  connect_bd_intf_net -intf_net axi_ad9371_rx_os_xcvr_up_es_0 [get_bd_intf_pins axi_ad9371_rx_os_xcvr/up_es_0] [get_bd_intf_pins util_ad9371_xcvr/up_es_2]
  connect_bd_intf_net -intf_net axi_ad9371_rx_os_xcvr_up_es_1 [get_bd_intf_pins axi_ad9371_rx_os_xcvr/up_es_1] [get_bd_intf_pins util_ad9371_xcvr/up_es_3]
  connect_bd_intf_net -intf_net axi_ad9371_rx_xcvr_m_axi [get_bd_intf_pins axi_ad9371_rx_xcvr/m_axi] [get_bd_intf_pins axi_hp3_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_ad9371_rx_xcvr_up_ch_0 [get_bd_intf_pins axi_ad9371_rx_xcvr/up_ch_0] [get_bd_intf_pins util_ad9371_xcvr/up_rx_0]
  connect_bd_intf_net -intf_net axi_ad9371_rx_xcvr_up_ch_1 [get_bd_intf_pins axi_ad9371_rx_xcvr/up_ch_1] [get_bd_intf_pins util_ad9371_xcvr/up_rx_1]
  connect_bd_intf_net -intf_net axi_ad9371_rx_xcvr_up_es_0 [get_bd_intf_pins axi_ad9371_rx_xcvr/up_es_0] [get_bd_intf_pins util_ad9371_xcvr/up_es_0]
  connect_bd_intf_net -intf_net axi_ad9371_rx_xcvr_up_es_1 [get_bd_intf_pins axi_ad9371_rx_xcvr/up_es_1] [get_bd_intf_pins util_ad9371_xcvr/up_es_1]
  connect_bd_intf_net -intf_net axi_ad9371_tx_dma_m_src_axi [get_bd_intf_pins axi_ad9371_tx_dma/m_src_axi] [get_bd_intf_pins axi_hp1_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_ad9371_tx_jesd_tx_phy0 [get_bd_intf_pins axi_ad9371_tx_jesd/tx_phy0] [get_bd_intf_pins util_ad9371_xcvr/tx_1]
  connect_bd_intf_net -intf_net axi_ad9371_tx_jesd_tx_phy1 [get_bd_intf_pins axi_ad9371_tx_jesd/tx_phy1] [get_bd_intf_pins util_ad9371_xcvr/tx_2]
  connect_bd_intf_net -intf_net axi_ad9371_tx_jesd_tx_phy2 [get_bd_intf_pins axi_ad9371_tx_jesd/tx_phy2] [get_bd_intf_pins util_ad9371_xcvr/tx_3]
  connect_bd_intf_net -intf_net axi_ad9371_tx_jesd_tx_phy3 [get_bd_intf_pins axi_ad9371_tx_jesd/tx_phy3] [get_bd_intf_pins util_ad9371_xcvr/tx_0]
  connect_bd_intf_net -intf_net axi_ad9371_tx_xcvr_up_ch_0 [get_bd_intf_pins axi_ad9371_tx_xcvr/up_ch_0] [get_bd_intf_pins util_ad9371_xcvr/up_tx_1]
  connect_bd_intf_net -intf_net axi_ad9371_tx_xcvr_up_ch_1 [get_bd_intf_pins axi_ad9371_tx_xcvr/up_ch_1] [get_bd_intf_pins util_ad9371_xcvr/up_tx_2]
  connect_bd_intf_net -intf_net axi_ad9371_tx_xcvr_up_ch_2 [get_bd_intf_pins axi_ad9371_tx_xcvr/up_ch_2] [get_bd_intf_pins util_ad9371_xcvr/up_tx_3]
  connect_bd_intf_net -intf_net axi_ad9371_tx_xcvr_up_ch_3 [get_bd_intf_pins axi_ad9371_tx_xcvr/up_ch_3] [get_bd_intf_pins util_ad9371_xcvr/up_tx_0]
  connect_bd_intf_net -intf_net axi_ad9371_tx_xcvr_up_cm_0 [get_bd_intf_pins axi_ad9371_tx_xcvr/up_cm_0] [get_bd_intf_pins util_ad9371_xcvr/up_cm_0]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M00_AXI [get_bd_intf_pins axi_cpu_interconnect/M00_AXI] [get_bd_intf_pins axi_iic_main/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M01_AXI [get_bd_intf_pins axi_cpu_interconnect/M01_AXI] [get_bd_intf_pins axi_sysid_0/s_axi]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M02_AXI [get_bd_intf_pins axi_cpu_interconnect/M02_AXI] [get_bd_intf_pins rx_ad9371_tpl_core/s_axi]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M06_AXI [get_bd_intf_pins axi_ad9371_tx_xcvr/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M06_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M07_AXI [get_bd_intf_pins axi_ad9371_tx_clkgen/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M07_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M09_AXI [get_bd_intf_pins axi_ad9371_tx_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M09_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M10_AXI [get_bd_intf_pins axi_ad9371_rx_xcvr/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M10_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M11_AXI [get_bd_intf_pins axi_ad9371_rx_clkgen/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M11_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M13_AXI [get_bd_intf_pins axi_ad9371_rx_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M13_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M14_AXI [get_bd_intf_pins axi_ad9371_rx_os_xcvr/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M14_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M15_AXI [get_bd_intf_pins axi_ad9371_rx_os_clkgen/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M15_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M17_AXI [get_bd_intf_pins axi_ad9371_rx_os_dma/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M17_AXI]
  connect_bd_intf_net -intf_net axi_fifo_mm_s_AXI_STR_TXD [get_bd_intf_pins axi_fifo_mm_s/AXI_STR_TXD] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_hp1_interconnect_M00_AXI [get_bd_intf_pins axi_hp1_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP1]
  connect_bd_intf_net -intf_net axi_hp2_interconnect_M00_AXI [get_bd_intf_pins axi_hp2_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP2]
  connect_bd_intf_net -intf_net axi_hp3_interconnect_M00_AXI [get_bd_intf_pins axi_hp3_interconnect/M00_AXI] [get_bd_intf_pins sys_ps7/S_AXI_HP3]
  connect_bd_intf_net -intf_net axi_iic_main_IIC [get_bd_intf_ports iic_main] [get_bd_intf_pins axi_iic_main/IIC]
  connect_bd_intf_net -intf_net coeffs_axi_lite_1 [get_bd_intf_pins axi_cpu_interconnect/M18_AXI] [get_bd_intf_pins tx_dvb/s_axi_lite]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins fifo_generator_0/M_AXIS] [get_bd_intf_pins tx_dvb/s_axis]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins axi_cpu_interconnect/M04_AXI] [get_bd_intf_pins tx_ad9371_tpl_core/s_axi]
  connect_bd_intf_net -intf_net s_axi_2 [get_bd_intf_pins axi_cpu_interconnect/M05_AXI] [get_bd_intf_pins rx_os_ad9371_tpl_core/s_axi]
  connect_bd_intf_net -intf_net s_axi_3 [get_bd_intf_pins axi_ad9371_tx_jesd/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M08_AXI]
  connect_bd_intf_net -intf_net s_axi_4 [get_bd_intf_pins axi_ad9371_rx_jesd/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M12_AXI]
  connect_bd_intf_net -intf_net s_axi_5 [get_bd_intf_pins axi_ad9371_rx_os_jesd/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M16_AXI]
  connect_bd_intf_net -intf_net sys_ps7_DDR [get_bd_intf_ports ddr] [get_bd_intf_pins sys_ps7/DDR]
  connect_bd_intf_net -intf_net sys_ps7_FIXED_IO [get_bd_intf_ports fixed_io] [get_bd_intf_pins sys_ps7/FIXED_IO]
  connect_bd_intf_net -intf_net tx_data_1 [get_bd_intf_pins axi_ad9371_tx_jesd/tx_data] [get_bd_intf_pins tx_ad9371_tpl_core/link]
  connect_bd_intf_net -intf_net util_ad9371_rx_cpack_packed_fifo_wr [get_bd_intf_pins axi_ad9371_rx_dma/fifo_wr] [get_bd_intf_pins util_ad9371_rx_cpack/packed_fifo_wr]
  connect_bd_intf_net -intf_net util_ad9371_rx_os_cpack_packed_fifo_wr [get_bd_intf_pins axi_ad9371_rx_os_dma/fifo_wr] [get_bd_intf_pins util_ad9371_rx_os_cpack/packed_fifo_wr]
  connect_bd_intf_net -intf_net util_ad9371_xcvr_rx_0 [get_bd_intf_pins axi_ad9371_rx_jesd/rx_phy0] [get_bd_intf_pins util_ad9371_xcvr/rx_0]
  connect_bd_intf_net -intf_net util_ad9371_xcvr_rx_1 [get_bd_intf_pins axi_ad9371_rx_jesd/rx_phy1] [get_bd_intf_pins util_ad9371_xcvr/rx_1]
  connect_bd_intf_net -intf_net util_ad9371_xcvr_rx_2 [get_bd_intf_pins axi_ad9371_rx_os_jesd/rx_phy0] [get_bd_intf_pins util_ad9371_xcvr/rx_2]
  connect_bd_intf_net -intf_net util_ad9371_xcvr_rx_3 [get_bd_intf_pins axi_ad9371_rx_os_jesd/rx_phy1] [get_bd_intf_pins util_ad9371_xcvr/rx_3]

  # Create port connections
  connect_bd_net -net GND_1_dout [get_bd_pins GND_1/dout] [get_bd_pins sys_concat_intc/In0] [get_bd_pins sys_concat_intc/In1] [get_bd_pins sys_concat_intc/In2] [get_bd_pins sys_concat_intc/In3] [get_bd_pins sys_concat_intc/In4] [get_bd_pins sys_concat_intc/In5] [get_bd_pins sys_concat_intc/In6] [get_bd_pins sys_concat_intc/In7] [get_bd_pins tx_dvb/load_config]
  connect_bd_net -net GND_32_dout [get_bd_pins GND_32/dout] [get_bd_pins tx_dvb/pulse_width]
  connect_bd_net -net VCC_1_dout [get_bd_pins VCC_1/dout] [get_bd_pins rx_fir_decimator/out_resetn]
  connect_bd_net -net active_1 [get_bd_ports dac_fir_filter_active] [get_bd_pins tx_dvb/active]
  connect_bd_net -net active_2 [get_bd_ports adc_fir_filter_active] [get_bd_pins rx_fir_decimator/active]
  connect_bd_net -net ad9371_rx_device_clk [get_bd_pins ad9371_rx_device_clk_rstgen/slowest_sync_clk] [get_bd_pins axi_ad9371_rx_clkgen/clk_0] [get_bd_pins axi_ad9371_rx_dma/fifo_wr_clk] [get_bd_pins axi_ad9371_rx_jesd/device_clk] [get_bd_pins axi_ad9371_rx_jesd/link_clk] [get_bd_pins rx_ad9371_tpl_core/link_clk] [get_bd_pins rx_fir_decimator/aclk] [get_bd_pins util_ad9371_rx_cpack/clk] [get_bd_pins util_ad9371_xcvr/rx_clk_0] [get_bd_pins util_ad9371_xcvr/rx_clk_1]
  connect_bd_net -net ad9371_rx_device_clk_rstgen_peripheral_reset [get_bd_pins ad9371_rx_device_clk_rstgen/peripheral_reset] [get_bd_pins util_ad9371_rx_cpack/reset]
  connect_bd_net -net ad9371_rx_os_device_clk [get_bd_pins ad9371_rx_os_device_clk_rstgen/slowest_sync_clk] [get_bd_pins axi_ad9371_rx_os_clkgen/clk_0] [get_bd_pins axi_ad9371_rx_os_dma/fifo_wr_clk] [get_bd_pins axi_ad9371_rx_os_jesd/device_clk] [get_bd_pins axi_ad9371_rx_os_jesd/link_clk] [get_bd_pins rx_os_ad9371_tpl_core/link_clk] [get_bd_pins util_ad9371_rx_os_cpack/clk] [get_bd_pins util_ad9371_xcvr/rx_clk_2] [get_bd_pins util_ad9371_xcvr/rx_clk_3]
  connect_bd_net -net ad9371_rx_os_device_clk_rstgen_peripheral_reset [get_bd_pins ad9371_rx_os_device_clk_rstgen/peripheral_reset] [get_bd_pins util_ad9371_rx_os_cpack/reset]
  connect_bd_net -net ad9371_tx_device_clk [get_bd_pins ad9371_tx_device_clk_rstgen/slowest_sync_clk] [get_bd_pins axi_ad9371_dacfifo/dac_clk] [get_bd_pins axi_ad9371_tx_clkgen/clk_0] [get_bd_pins axi_ad9371_tx_jesd/device_clk] [get_bd_pins axi_ad9371_tx_jesd/link_clk] [get_bd_pins tx_ad9371_tpl_core/link_clk] [get_bd_pins util_ad9371_xcvr/tx_clk_0] [get_bd_pins util_ad9371_xcvr/tx_clk_1] [get_bd_pins util_ad9371_xcvr/tx_clk_2] [get_bd_pins util_ad9371_xcvr/tx_clk_3]
  connect_bd_net -net ad9371_tx_device_clk_rstgen_peripheral_reset [get_bd_pins ad9371_tx_device_clk_rstgen/peripheral_reset] [get_bd_pins axi_ad9371_dacfifo/dac_rst]
  connect_bd_net -net adc_dovf_1 [get_bd_pins rx_ad9371_tpl_core/adc_dovf] [get_bd_pins util_ad9371_rx_cpack/fifo_wr_overflow]
  connect_bd_net -net adc_dovf_2 [get_bd_pins rx_os_ad9371_tpl_core/adc_dovf] [get_bd_pins util_ad9371_rx_os_cpack/fifo_wr_overflow]
  connect_bd_net -net axi_ad9371_dacfifo_dac_dunf [get_bd_pins axi_ad9371_dacfifo/dac_dunf] [get_bd_pins tx_ad9371_tpl_core/dac_dunf]
  connect_bd_net -net axi_ad9371_dacfifo_dma_ready [get_bd_pins axi_ad9371_dacfifo/dma_ready] [get_bd_pins axi_ad9371_tx_dma/m_axis_ready]
  connect_bd_net -net axi_ad9371_rx_dma_irq [get_bd_pins axi_ad9371_rx_dma/irq] [get_bd_pins sys_concat_intc/In13]
  connect_bd_net -net axi_ad9371_rx_jesd_irq [get_bd_pins axi_ad9371_rx_jesd/irq] [get_bd_pins sys_concat_intc/In10]
  connect_bd_net -net axi_ad9371_rx_jesd_phy_en_char_align [get_bd_pins axi_ad9371_rx_jesd/phy_en_char_align] [get_bd_pins util_ad9371_xcvr/rx_calign_0] [get_bd_pins util_ad9371_xcvr/rx_calign_1]
  connect_bd_net -net axi_ad9371_rx_jesd_rx_data_tdata [get_bd_pins axi_ad9371_rx_jesd/rx_data_tdata] [get_bd_pins rx_ad9371_tpl_core/link_data]
  connect_bd_net -net axi_ad9371_rx_jesd_rx_data_tvalid [get_bd_pins axi_ad9371_rx_jesd/rx_data_tvalid] [get_bd_pins rx_ad9371_tpl_core/link_valid]
  connect_bd_net -net axi_ad9371_rx_jesd_rx_sof [get_bd_pins axi_ad9371_rx_jesd/rx_sof] [get_bd_pins rx_ad9371_tpl_core/link_sof]
  connect_bd_net -net axi_ad9371_rx_jesd_sync [get_bd_ports rx_sync_0] [get_bd_pins axi_ad9371_rx_jesd/sync]
  connect_bd_net -net axi_ad9371_rx_os_dma_irq [get_bd_pins axi_ad9371_rx_os_dma/irq] [get_bd_pins sys_concat_intc/In11]
  connect_bd_net -net axi_ad9371_rx_os_jesd_irq [get_bd_pins axi_ad9371_rx_os_jesd/irq] [get_bd_pins sys_concat_intc/In8]
  connect_bd_net -net axi_ad9371_rx_os_jesd_phy_en_char_align [get_bd_pins axi_ad9371_rx_os_jesd/phy_en_char_align] [get_bd_pins util_ad9371_xcvr/rx_calign_2] [get_bd_pins util_ad9371_xcvr/rx_calign_3]
  connect_bd_net -net axi_ad9371_rx_os_jesd_rx_data_tdata [get_bd_pins axi_ad9371_rx_os_jesd/rx_data_tdata] [get_bd_pins rx_os_ad9371_tpl_core/link_data]
  connect_bd_net -net axi_ad9371_rx_os_jesd_rx_data_tvalid [get_bd_pins axi_ad9371_rx_os_jesd/rx_data_tvalid] [get_bd_pins rx_os_ad9371_tpl_core/link_valid]
  connect_bd_net -net axi_ad9371_rx_os_jesd_rx_sof [get_bd_pins axi_ad9371_rx_os_jesd/rx_sof] [get_bd_pins rx_os_ad9371_tpl_core/link_sof]
  connect_bd_net -net axi_ad9371_rx_os_jesd_sync [get_bd_ports rx_sync_2] [get_bd_pins axi_ad9371_rx_os_jesd/sync]
  connect_bd_net -net axi_ad9371_rx_os_xcvr_up_pll_rst [get_bd_pins axi_ad9371_rx_os_xcvr/up_pll_rst] [get_bd_pins util_ad9371_xcvr/up_cpll_rst_2] [get_bd_pins util_ad9371_xcvr/up_cpll_rst_3]
  connect_bd_net -net axi_ad9371_rx_xcvr_up_pll_rst [get_bd_pins axi_ad9371_rx_xcvr/up_pll_rst] [get_bd_pins util_ad9371_xcvr/up_cpll_rst_0] [get_bd_pins util_ad9371_xcvr/up_cpll_rst_1]
  connect_bd_net -net axi_ad9371_tx_dma_irq [get_bd_pins axi_ad9371_tx_dma/irq] [get_bd_pins sys_concat_intc/In12]
  connect_bd_net -net axi_ad9371_tx_dma_m_axis_data [get_bd_pins axi_ad9371_dacfifo/dma_data] [get_bd_pins axi_ad9371_tx_dma/m_axis_data]
  connect_bd_net -net axi_ad9371_tx_dma_m_axis_last [get_bd_pins axi_ad9371_dacfifo/dma_xfer_last] [get_bd_pins axi_ad9371_tx_dma/m_axis_last]
  connect_bd_net -net axi_ad9371_tx_dma_m_axis_valid [get_bd_pins axi_ad9371_dacfifo/dma_valid] [get_bd_pins axi_ad9371_tx_dma/m_axis_valid]
  connect_bd_net -net axi_ad9371_tx_dma_m_axis_xfer_req [get_bd_pins axi_ad9371_dacfifo/dma_xfer_req] [get_bd_pins axi_ad9371_tx_dma/m_axis_xfer_req]
  connect_bd_net -net axi_ad9371_tx_jesd_irq [get_bd_pins axi_ad9371_tx_jesd/irq] [get_bd_pins sys_concat_intc/In9]
  connect_bd_net -net axi_ad9371_tx_xcvr_up_pll_rst [get_bd_pins axi_ad9371_tx_xcvr/up_pll_rst] [get_bd_pins util_ad9371_xcvr/up_qpll_rst_0]
  connect_bd_net -net axi_iic_main_iic2intc_irpt [get_bd_pins axi_iic_main/iic2intc_irpt] [get_bd_pins sys_concat_intc/In14]
  connect_bd_net -net axi_rstgen_peripheral_aresetn [get_bd_pins axi_ad9371_dacfifo/axi_resetn] [get_bd_pins axi_ad9371_dacfifo_axi_periph/ARESETN] [get_bd_pins axi_ad9371_dacfifo_axi_periph/M00_ARESETN] [get_bd_pins axi_ad9371_dacfifo_axi_periph/S00_ARESETN] [get_bd_pins axi_fifo_mm_s/s_axi_aresetn] [get_bd_pins axi_rstgen/peripheral_aresetn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net axi_sysid_0_rom_addr [get_bd_pins axi_sysid_0/rom_addr] [get_bd_pins rom_sys_0/rom_addr]
  connect_bd_net -net dac_fifo_bypass_1 [get_bd_ports dac_fifo_bypass] [get_bd_pins axi_ad9371_dacfifo/bypass]
  connect_bd_net -net gpio_i_1 [get_bd_ports gpio_i] [get_bd_pins sys_ps7/GPIO_I]
  connect_bd_net -net rom_sys_0_rom_data [get_bd_pins axi_sysid_0/sys_rom_data] [get_bd_pins rom_sys_0/rom_data]
  connect_bd_net -net rx_ad9371_tpl_core_adc_data_0 [get_bd_pins rx_ad9371_tpl_core/adc_data_0] [get_bd_pins rx_fir_decimator/data_in_0]
  connect_bd_net -net rx_ad9371_tpl_core_adc_data_1 [get_bd_pins rx_ad9371_tpl_core/adc_data_1] [get_bd_pins rx_fir_decimator/data_in_1]
  connect_bd_net -net rx_ad9371_tpl_core_adc_data_2 [get_bd_pins rx_ad9371_tpl_core/adc_data_2] [get_bd_pins rx_fir_decimator/data_in_2]
  connect_bd_net -net rx_ad9371_tpl_core_adc_data_3 [get_bd_pins rx_ad9371_tpl_core/adc_data_3] [get_bd_pins rx_fir_decimator/data_in_3]
  connect_bd_net -net rx_ad9371_tpl_core_adc_enable_0 [get_bd_pins rx_ad9371_tpl_core/adc_enable_0] [get_bd_pins rx_fir_decimator/enable_in_0]
  connect_bd_net -net rx_ad9371_tpl_core_adc_enable_1 [get_bd_pins rx_ad9371_tpl_core/adc_enable_1] [get_bd_pins rx_fir_decimator/enable_in_1]
  connect_bd_net -net rx_ad9371_tpl_core_adc_enable_2 [get_bd_pins rx_ad9371_tpl_core/adc_enable_2] [get_bd_pins rx_fir_decimator/enable_in_2]
  connect_bd_net -net rx_ad9371_tpl_core_adc_enable_3 [get_bd_pins rx_ad9371_tpl_core/adc_enable_3] [get_bd_pins rx_fir_decimator/enable_in_3]
  connect_bd_net -net rx_ad9371_tpl_core_adc_valid_0 [get_bd_pins rx_ad9371_tpl_core/adc_valid_0] [get_bd_pins rx_fir_decimator/valid_in_0]
  connect_bd_net -net rx_ad9371_tpl_core_adc_valid_1 [get_bd_pins rx_ad9371_tpl_core/adc_valid_1] [get_bd_pins rx_fir_decimator/valid_in_1]
  connect_bd_net -net rx_ad9371_tpl_core_adc_valid_2 [get_bd_pins rx_ad9371_tpl_core/adc_valid_2] [get_bd_pins rx_fir_decimator/valid_in_2]
  connect_bd_net -net rx_ad9371_tpl_core_adc_valid_3 [get_bd_pins rx_ad9371_tpl_core/adc_valid_3] [get_bd_pins rx_fir_decimator/valid_in_3]
  connect_bd_net -net rx_data_0_n_1 [get_bd_ports rx_data_0_n] [get_bd_pins util_ad9371_xcvr/rx_0_n]
  connect_bd_net -net rx_data_0_p_1 [get_bd_ports rx_data_0_p] [get_bd_pins util_ad9371_xcvr/rx_0_p]
  connect_bd_net -net rx_data_1_n_1 [get_bd_ports rx_data_1_n] [get_bd_pins util_ad9371_xcvr/rx_1_n]
  connect_bd_net -net rx_data_1_p_1 [get_bd_ports rx_data_1_p] [get_bd_pins util_ad9371_xcvr/rx_1_p]
  connect_bd_net -net rx_data_2_n_1 [get_bd_ports rx_data_2_n] [get_bd_pins util_ad9371_xcvr/rx_2_n]
  connect_bd_net -net rx_data_2_p_1 [get_bd_ports rx_data_2_p] [get_bd_pins util_ad9371_xcvr/rx_2_p]
  connect_bd_net -net rx_data_3_n_1 [get_bd_ports rx_data_3_n] [get_bd_pins util_ad9371_xcvr/rx_3_n]
  connect_bd_net -net rx_data_3_p_1 [get_bd_ports rx_data_3_p] [get_bd_pins util_ad9371_xcvr/rx_3_p]
  connect_bd_net -net rx_fir_decimator_data_out_0 [get_bd_pins rx_fir_decimator/data_out_0] [get_bd_pins util_ad9371_rx_cpack/fifo_wr_data_0]
  connect_bd_net -net rx_fir_decimator_data_out_1 [get_bd_pins rx_fir_decimator/data_out_1] [get_bd_pins util_ad9371_rx_cpack/fifo_wr_data_1]
  connect_bd_net -net rx_fir_decimator_data_out_2 [get_bd_pins rx_fir_decimator/data_out_2] [get_bd_pins util_ad9371_rx_cpack/fifo_wr_data_2]
  connect_bd_net -net rx_fir_decimator_data_out_3 [get_bd_pins rx_fir_decimator/data_out_3] [get_bd_pins util_ad9371_rx_cpack/fifo_wr_data_3]
  connect_bd_net -net rx_fir_decimator_enable_out_0 [get_bd_pins rx_fir_decimator/enable_out_0] [get_bd_pins util_ad9371_rx_cpack/enable_0]
  connect_bd_net -net rx_fir_decimator_enable_out_1 [get_bd_pins rx_fir_decimator/enable_out_1] [get_bd_pins util_ad9371_rx_cpack/enable_1]
  connect_bd_net -net rx_fir_decimator_enable_out_2 [get_bd_pins rx_fir_decimator/enable_out_2] [get_bd_pins util_ad9371_rx_cpack/enable_2]
  connect_bd_net -net rx_fir_decimator_enable_out_3 [get_bd_pins rx_fir_decimator/enable_out_3] [get_bd_pins util_ad9371_rx_cpack/enable_3]
  connect_bd_net -net rx_fir_decimator_valid_out_0 [get_bd_pins rx_fir_decimator/valid_out_0] [get_bd_pins util_ad9371_rx_cpack/fifo_wr_en]
  connect_bd_net -net rx_os_ad9371_tpl_core_adc_data_0 [get_bd_pins rx_os_ad9371_tpl_core/adc_data_0] [get_bd_pins util_ad9371_rx_os_cpack/fifo_wr_data_0]
  connect_bd_net -net rx_os_ad9371_tpl_core_adc_data_1 [get_bd_pins rx_os_ad9371_tpl_core/adc_data_1] [get_bd_pins util_ad9371_rx_os_cpack/fifo_wr_data_1]
  connect_bd_net -net rx_os_ad9371_tpl_core_adc_enable_0 [get_bd_pins rx_os_ad9371_tpl_core/adc_enable_0] [get_bd_pins util_ad9371_rx_os_cpack/enable_0]
  connect_bd_net -net rx_os_ad9371_tpl_core_adc_enable_1 [get_bd_pins rx_os_ad9371_tpl_core/adc_enable_1] [get_bd_pins util_ad9371_rx_os_cpack/enable_1]
  connect_bd_net -net rx_os_ad9371_tpl_core_adc_valid_0 [get_bd_pins rx_os_ad9371_tpl_core/adc_valid_0] [get_bd_pins util_ad9371_rx_os_cpack/fifo_wr_en]
  connect_bd_net -net rx_ref_clk_0_1 [get_bd_ports rx_ref_clk_0] [get_bd_pins util_ad9371_xcvr/cpll_ref_clk_0] [get_bd_pins util_ad9371_xcvr/cpll_ref_clk_1]
  connect_bd_net -net rx_ref_clk_2_1 [get_bd_ports rx_ref_clk_2] [get_bd_pins util_ad9371_xcvr/cpll_ref_clk_2] [get_bd_pins util_ad9371_xcvr/cpll_ref_clk_3]
  connect_bd_net -net spi0_clk_i_1 [get_bd_ports spi0_clk_i] [get_bd_pins sys_ps7/SPI0_SCLK_I]
  connect_bd_net -net spi0_csn_i_1 [get_bd_ports spi0_csn_i] [get_bd_pins sys_ps7/SPI0_SS_I]
  connect_bd_net -net spi0_sdi_i_1 [get_bd_ports spi0_sdi_i] [get_bd_pins sys_ps7/SPI0_MISO_I]
  connect_bd_net -net spi0_sdo_i_1 [get_bd_ports spi0_sdo_i] [get_bd_pins sys_ps7/SPI0_MOSI_I]
  connect_bd_net -net spi1_clk_i_1 [get_bd_ports spi1_clk_i] [get_bd_pins sys_ps7/SPI1_SCLK_I]
  connect_bd_net -net spi1_csn_i_1 [get_bd_ports spi1_csn_i] [get_bd_pins sys_ps7/SPI1_SS_I]
  connect_bd_net -net spi1_sdi_i_1 [get_bd_ports spi1_sdi_i] [get_bd_pins sys_ps7/SPI1_MISO_I]
  connect_bd_net -net spi1_sdo_i_1 [get_bd_ports spi1_sdo_i] [get_bd_pins sys_ps7/SPI1_MOSI_I]
  connect_bd_net -net sync_1 [get_bd_ports tx_sync_0] [get_bd_pins axi_ad9371_tx_jesd/sync]
  connect_bd_net -net sys_200m_clk [get_bd_pins axi_ad9371_dacfifo/axi_clk] [get_bd_pins axi_ad9371_dacfifo/dma_clk] [get_bd_pins axi_ad9371_dacfifo_axi_periph/ACLK] [get_bd_pins axi_ad9371_dacfifo_axi_periph/M00_ACLK] [get_bd_pins axi_ad9371_dacfifo_axi_periph/S00_ACLK] [get_bd_pins axi_ad9371_rx_dma/m_dest_axi_aclk] [get_bd_pins axi_ad9371_rx_os_dma/m_dest_axi_aclk] [get_bd_pins axi_ad9371_tx_dma/m_axis_aclk] [get_bd_pins axi_ad9371_tx_dma/m_src_axi_aclk] [get_bd_pins axi_fifo_mm_s/s_axi_aclk] [get_bd_pins axi_hp1_interconnect/aclk] [get_bd_pins axi_hp2_interconnect/aclk] [get_bd_pins axi_rstgen/slowest_sync_clk] [get_bd_pins fifo_generator_0/s_aclk] [get_bd_pins sys_200m_rstgen/slowest_sync_clk] [get_bd_pins sys_ps7/FCLK_CLK1] [get_bd_pins sys_ps7/S_AXI_HP1_ACLK] [get_bd_pins sys_ps7/S_AXI_HP2_ACLK]
  connect_bd_net -net sys_200m_reset [get_bd_pins axi_ad9371_dacfifo/dma_rst] [get_bd_pins sys_200m_rstgen/peripheral_reset]
  connect_bd_net -net sys_200m_resetn [get_bd_pins axi_ad9371_rx_dma/m_dest_axi_aresetn] [get_bd_pins axi_ad9371_rx_os_dma/m_dest_axi_aresetn] [get_bd_pins axi_ad9371_tx_dma/m_src_axi_aresetn] [get_bd_pins axi_hp1_interconnect/aresetn] [get_bd_pins axi_hp2_interconnect/aresetn] [get_bd_pins sys_200m_rstgen/peripheral_aresetn]
  connect_bd_net -net sys_concat_intc_dout [get_bd_pins sys_concat_intc/dout] [get_bd_pins sys_ps7/IRQ_F2P]
  connect_bd_net -net sys_cpu_clk [get_bd_pins axi_ad9371_rx_clkgen/s_axi_aclk] [get_bd_pins axi_ad9371_rx_dma/s_axi_aclk] [get_bd_pins axi_ad9371_rx_jesd/s_axi_aclk] [get_bd_pins axi_ad9371_rx_os_clkgen/s_axi_aclk] [get_bd_pins axi_ad9371_rx_os_dma/s_axi_aclk] [get_bd_pins axi_ad9371_rx_os_jesd/s_axi_aclk] [get_bd_pins axi_ad9371_rx_os_xcvr/s_axi_aclk] [get_bd_pins axi_ad9371_rx_xcvr/s_axi_aclk] [get_bd_pins axi_ad9371_tx_clkgen/s_axi_aclk] [get_bd_pins axi_ad9371_tx_dma/s_axi_aclk] [get_bd_pins axi_ad9371_tx_jesd/s_axi_aclk] [get_bd_pins axi_ad9371_tx_xcvr/s_axi_aclk] [get_bd_pins axi_cpu_interconnect/ACLK] [get_bd_pins axi_cpu_interconnect/M00_ACLK] [get_bd_pins axi_cpu_interconnect/M01_ACLK] [get_bd_pins axi_cpu_interconnect/M02_ACLK] [get_bd_pins axi_cpu_interconnect/M03_ACLK] [get_bd_pins axi_cpu_interconnect/M04_ACLK] [get_bd_pins axi_cpu_interconnect/M05_ACLK] [get_bd_pins axi_cpu_interconnect/M06_ACLK] [get_bd_pins axi_cpu_interconnect/M07_ACLK] [get_bd_pins axi_cpu_interconnect/M08_ACLK] [get_bd_pins axi_cpu_interconnect/M09_ACLK] [get_bd_pins axi_cpu_interconnect/M10_ACLK] [get_bd_pins axi_cpu_interconnect/M11_ACLK] [get_bd_pins axi_cpu_interconnect/M12_ACLK] [get_bd_pins axi_cpu_interconnect/M13_ACLK] [get_bd_pins axi_cpu_interconnect/M14_ACLK] [get_bd_pins axi_cpu_interconnect/M15_ACLK] [get_bd_pins axi_cpu_interconnect/M16_ACLK] [get_bd_pins axi_cpu_interconnect/M17_ACLK] [get_bd_pins axi_cpu_interconnect/M18_ACLK] [get_bd_pins axi_cpu_interconnect/S00_ACLK] [get_bd_pins axi_hp3_interconnect/aclk] [get_bd_pins axi_iic_main/s_axi_aclk] [get_bd_pins axi_sysid_0/s_axi_aclk] [get_bd_pins fifo_generator_0/m_aclk] [get_bd_pins rom_sys_0/clk] [get_bd_pins rx_ad9371_tpl_core/s_axi_aclk] [get_bd_pins rx_os_ad9371_tpl_core/s_axi_aclk] [get_bd_pins sys_ps7/DMA0_ACLK] [get_bd_pins sys_ps7/FCLK_CLK0] [get_bd_pins sys_ps7/M_AXI_GP0_ACLK] [get_bd_pins sys_ps7/S_AXI_HP0_ACLK] [get_bd_pins sys_ps7/S_AXI_HP3_ACLK] [get_bd_pins sys_rstgen/slowest_sync_clk] [get_bd_pins tx_ad9371_tpl_core/s_axi_aclk] [get_bd_pins tx_dvb/aclk] [get_bd_pins util_ad9371_xcvr/up_clk]
  connect_bd_net -net sys_cpu_reset [get_bd_pins sys_rstgen/peripheral_reset]
  connect_bd_net -net sys_cpu_resetn [get_bd_pins ad9371_rx_device_clk_rstgen/ext_reset_in] [get_bd_pins ad9371_rx_os_device_clk_rstgen/ext_reset_in] [get_bd_pins ad9371_tx_device_clk_rstgen/ext_reset_in] [get_bd_pins axi_ad9371_rx_clkgen/s_axi_aresetn] [get_bd_pins axi_ad9371_rx_dma/s_axi_aresetn] [get_bd_pins axi_ad9371_rx_jesd/s_axi_aresetn] [get_bd_pins axi_ad9371_rx_os_clkgen/s_axi_aresetn] [get_bd_pins axi_ad9371_rx_os_dma/s_axi_aresetn] [get_bd_pins axi_ad9371_rx_os_jesd/s_axi_aresetn] [get_bd_pins axi_ad9371_rx_os_xcvr/s_axi_aresetn] [get_bd_pins axi_ad9371_rx_xcvr/s_axi_aresetn] [get_bd_pins axi_ad9371_tx_clkgen/s_axi_aresetn] [get_bd_pins axi_ad9371_tx_dma/s_axi_aresetn] [get_bd_pins axi_ad9371_tx_jesd/s_axi_aresetn] [get_bd_pins axi_ad9371_tx_xcvr/s_axi_aresetn] [get_bd_pins axi_cpu_interconnect/ARESETN] [get_bd_pins axi_cpu_interconnect/M00_ARESETN] [get_bd_pins axi_cpu_interconnect/M01_ARESETN] [get_bd_pins axi_cpu_interconnect/M02_ARESETN] [get_bd_pins axi_cpu_interconnect/M03_ARESETN] [get_bd_pins axi_cpu_interconnect/M04_ARESETN] [get_bd_pins axi_cpu_interconnect/M05_ARESETN] [get_bd_pins axi_cpu_interconnect/M06_ARESETN] [get_bd_pins axi_cpu_interconnect/M07_ARESETN] [get_bd_pins axi_cpu_interconnect/M08_ARESETN] [get_bd_pins axi_cpu_interconnect/M09_ARESETN] [get_bd_pins axi_cpu_interconnect/M10_ARESETN] [get_bd_pins axi_cpu_interconnect/M11_ARESETN] [get_bd_pins axi_cpu_interconnect/M12_ARESETN] [get_bd_pins axi_cpu_interconnect/M13_ARESETN] [get_bd_pins axi_cpu_interconnect/M14_ARESETN] [get_bd_pins axi_cpu_interconnect/M15_ARESETN] [get_bd_pins axi_cpu_interconnect/M16_ARESETN] [get_bd_pins axi_cpu_interconnect/M17_ARESETN] [get_bd_pins axi_cpu_interconnect/M18_ARESETN] [get_bd_pins axi_cpu_interconnect/S00_ARESETN] [get_bd_pins axi_hp3_interconnect/aresetn] [get_bd_pins axi_iic_main/s_axi_aresetn] [get_bd_pins axi_rstgen/ext_reset_in] [get_bd_pins axi_sysid_0/s_axi_aresetn] [get_bd_pins rx_ad9371_tpl_core/s_axi_aresetn] [get_bd_pins rx_os_ad9371_tpl_core/s_axi_aresetn] [get_bd_pins sys_rstgen/peripheral_aresetn] [get_bd_pins tx_ad9371_tpl_core/s_axi_aresetn] [get_bd_pins tx_dvb/resetn] [get_bd_pins util_ad9371_xcvr/up_rstn]
  connect_bd_net -net sys_ps7_FCLK_RESET0_N [get_bd_pins sys_ps7/FCLK_RESET0_N] [get_bd_pins sys_rstgen/ext_reset_in]
  connect_bd_net -net sys_ps7_FCLK_RESET1_N [get_bd_pins sys_200m_rstgen/ext_reset_in] [get_bd_pins sys_ps7/FCLK_RESET1_N]
  connect_bd_net -net sys_ps7_GPIO_O [get_bd_ports gpio_o] [get_bd_pins sys_ps7/GPIO_O]
  connect_bd_net -net sys_ps7_GPIO_T [get_bd_ports gpio_t] [get_bd_pins sys_ps7/GPIO_T]
  connect_bd_net -net sys_ps7_SPI0_MOSI_O [get_bd_ports spi0_sdo_o] [get_bd_pins sys_ps7/SPI0_MOSI_O]
  connect_bd_net -net sys_ps7_SPI0_SCLK_O [get_bd_ports spi0_clk_o] [get_bd_pins sys_ps7/SPI0_SCLK_O]
  connect_bd_net -net sys_ps7_SPI0_SS1_O [get_bd_ports spi0_csn_1_o] [get_bd_pins sys_ps7/SPI0_SS1_O]
  connect_bd_net -net sys_ps7_SPI0_SS2_O [get_bd_ports spi0_csn_2_o] [get_bd_pins sys_ps7/SPI0_SS2_O]
  connect_bd_net -net sys_ps7_SPI0_SS_O [get_bd_ports spi0_csn_0_o] [get_bd_pins sys_ps7/SPI0_SS_O]
  connect_bd_net -net sys_ps7_SPI1_MOSI_O [get_bd_ports spi1_sdo_o] [get_bd_pins sys_ps7/SPI1_MOSI_O]
  connect_bd_net -net sys_ps7_SPI1_SCLK_O [get_bd_ports spi1_clk_o] [get_bd_pins sys_ps7/SPI1_SCLK_O]
  connect_bd_net -net sys_ps7_SPI1_SS1_O [get_bd_ports spi1_csn_1_o] [get_bd_pins sys_ps7/SPI1_SS1_O]
  connect_bd_net -net sys_ps7_SPI1_SS2_O [get_bd_ports spi1_csn_2_o] [get_bd_pins sys_ps7/SPI1_SS2_O]
  connect_bd_net -net sys_ps7_SPI1_SS_O [get_bd_ports spi1_csn_0_o] [get_bd_pins sys_ps7/SPI1_SS_O]
  connect_bd_net -net sysref_1 [get_bd_ports tx_sysref_0] [get_bd_pins axi_ad9371_tx_jesd/sysref]
  connect_bd_net -net sysref_2 [get_bd_ports rx_sysref_0] [get_bd_pins axi_ad9371_rx_jesd/sysref]
  connect_bd_net -net sysref_3 [get_bd_ports rx_sysref_2] [get_bd_pins axi_ad9371_rx_os_jesd/sysref]
  connect_bd_net -net tx_dvb_data_out_0 [get_bd_pins tx_ad9371_tpl_core/dac_data_0] [get_bd_pins tx_dvb/data_out_0]
  connect_bd_net -net tx_dvb_data_out_1 [get_bd_pins tx_ad9371_tpl_core/dac_data_1] [get_bd_pins tx_dvb/data_out_1]
  connect_bd_net -net tx_ref_clk_0_1 [get_bd_ports tx_ref_clk_0] [get_bd_pins util_ad9371_xcvr/qpll_ref_clk_0]
  connect_bd_net -net util_ad9371_xcvr_rx_out_clk_0 [get_bd_pins axi_ad9371_rx_clkgen/clk] [get_bd_pins util_ad9371_xcvr/rx_out_clk_0]
  connect_bd_net -net util_ad9371_xcvr_rx_out_clk_2 [get_bd_pins axi_ad9371_rx_os_clkgen/clk] [get_bd_pins util_ad9371_xcvr/rx_out_clk_2]
  connect_bd_net -net util_ad9371_xcvr_tx_0_n [get_bd_ports tx_data_0_n] [get_bd_pins util_ad9371_xcvr/tx_0_n]
  connect_bd_net -net util_ad9371_xcvr_tx_0_p [get_bd_ports tx_data_0_p] [get_bd_pins util_ad9371_xcvr/tx_0_p]
  connect_bd_net -net util_ad9371_xcvr_tx_1_n [get_bd_ports tx_data_1_n] [get_bd_pins util_ad9371_xcvr/tx_1_n]
  connect_bd_net -net util_ad9371_xcvr_tx_1_p [get_bd_ports tx_data_1_p] [get_bd_pins util_ad9371_xcvr/tx_1_p]
  connect_bd_net -net util_ad9371_xcvr_tx_2_n [get_bd_ports tx_data_2_n] [get_bd_pins util_ad9371_xcvr/tx_2_n]
  connect_bd_net -net util_ad9371_xcvr_tx_2_p [get_bd_ports tx_data_2_p] [get_bd_pins util_ad9371_xcvr/tx_2_p]
  connect_bd_net -net util_ad9371_xcvr_tx_3_n [get_bd_ports tx_data_3_n] [get_bd_pins util_ad9371_xcvr/tx_3_n]
  connect_bd_net -net util_ad9371_xcvr_tx_3_p [get_bd_ports tx_data_3_p] [get_bd_pins util_ad9371_xcvr/tx_3_p]
  connect_bd_net -net util_ad9371_xcvr_tx_out_clk_0 [get_bd_pins axi_ad9371_tx_clkgen/clk] [get_bd_pins util_ad9371_xcvr/tx_out_clk_0]

  # Create address segments
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_ad9371_dacfifo/axi] [get_bd_addr_segs axi_fifo_mm_s/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_ad9371_rx_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_ad9371_rx_os_dma/m_dest_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_ad9371_rx_os_xcvr/m_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_ad9371_rx_xcvr/m_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP3/HP3_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_ad9371_tx_dma/m_src_axi] [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] -force
  assign_bd_address -offset 0x44A00000 -range 0x00002000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs rx_ad9371_tpl_core/adc_tpl_core/s_axi/axi_lite] -force
  assign_bd_address -offset 0x44A08000 -range 0x00002000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs rx_os_ad9371_tpl_core/adc_tpl_core/s_axi/axi_lite] -force
  assign_bd_address -offset 0x43C10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_clkgen/s_axi/axi_lite] -force
  assign_bd_address -offset 0x7C400000 -range 0x00001000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_dma/s_axi/axi_lite] -force
  assign_bd_address -offset 0x43C20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_os_clkgen/s_axi/axi_lite] -force
  assign_bd_address -offset 0x7C440000 -range 0x00001000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_os_dma/s_axi/axi_lite] -force
  assign_bd_address -offset 0x44A50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_os_xcvr/s_axi/axi_lite] -force
  assign_bd_address -offset 0x44A60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_xcvr/s_axi/axi_lite] -force
  assign_bd_address -offset 0x43C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_tx_clkgen/s_axi/axi_lite] -force
  assign_bd_address -offset 0x7C420000 -range 0x00001000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_tx_dma/s_axi/axi_lite] -force
  assign_bd_address -offset 0x44A80000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_tx_xcvr/s_axi/axi_lite] -force
  assign_bd_address -offset 0x41600000 -range 0x00001000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_iic_main/S_AXI/Reg] -force
  assign_bd_address -offset 0x45000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_sysid_0/s_axi/axi_lite] -force
  assign_bd_address -offset 0x44A04000 -range 0x00002000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs tx_ad9371_tpl_core/dac_tpl_core/s_axi/axi_lite] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs tx_dvb/dvbs2_tx_wrapper_0/s_axi_lite/reg0] -force
  assign_bd_address -offset 0x44AA0000 -range 0x00004000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_jesd/rx_axi/s_axi/axi_lite] -force
  assign_bd_address -offset 0x44AB0000 -range 0x00004000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_rx_os_jesd/rx_axi/s_axi/axi_lite] -force
  assign_bd_address -offset 0x44A90000 -range 0x00004000 -target_address_space [get_bd_addr_spaces sys_ps7/Data] [get_bd_addr_segs axi_ad9371_tx_jesd/tx_axi/s_axi/axi_lite] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


