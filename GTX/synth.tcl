source -notrace ./script/project_lock.tcl

proc create_target {} {

    variable proj_dict

    set part_name "xc7k325tffg900-2"

    # Get the current time as a Unix timestamp
    set currentTime [clock seconds]
    # Format the timestamp into the desired format
    set formattedTime [clock format $currentTime -format {%Y%m%d_%H%M%S}]

    set proj_name "ISOC_GTX_${formattedTime}_"

    set origin_dir "."

    # Set project info
    ::proj::set_proj_info   \
        -force              \
        -part  "$part_name" \
        -addr "$origin_dir" \
        -name "$proj_name"

    ::proj::generate_project
    set_property board_part xilinx.com:kc705:part0:1.6 [current_project]
    # Add source files
    ::proj::create_src_filesets -base_folder $origin_dir

    # Set top module
    set HDL_TOP_MODULE_NAME "gtwizard_0_exdes"
    ::proj::set_top_wrapper -file_name $HDL_TOP_MODULE_NAME

    # Add mannaged constraint files and set their compilation order
    ::proj::create_constr_filesets -base_folder $origin_dir

    # Add simulation files
    ::proj::create_sim_filesets -base_folder $origin_dir 

    update_compile_order -fileset sources_1

    # Build the project with generic value for clock connections in the top
    # module
    puts "--- Building project"
    ::proj::build_proj

    wait_on_run impl_1

}