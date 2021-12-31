puts "INFO: Running [info script]"

namespace eval PmodToF_basic_example {
    variable script_dir

    proc init {} {
        # script_dir variable is used here because when a process is called that contains the info script command,
        # info script returns the path to the script calling the proc rather than to this script
        set script [info script] 
        set PmodToF_basic_example::script_dir [file normalize [file dirname $script]]
    }

    proc create_app {app_name sysproj_name domain_name platform_name} {
        set lang "c"
        set template "Empty Application(C)"
        app create -name ${app_name} -lang ${lang} -template ${template} -domain ${domain_name} -platform ${platform_name} -sysproj ${sysproj_name}
        
        app config -name ${app_name} libraries "m"

        set app_sources [file join ${PmodToF_basic_example::script_dir} sources]
        set drivers [file join [file dirname [file dirname ${PmodToF_basic_example::script_dir}]] sources]
        importsources -name ${app_name} -path ${app_sources}
        importsources -name ${app_name} -path ${drivers}
        # note: configure the linker script?
    }
}

PmodToF_basic_example::init