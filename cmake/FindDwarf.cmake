list(FIND Dwarf_FIND_COMPONENTS STATIC STATIC_REQUESTED)
list(FIND Dwarf_FIND_COMPONENTS SHARED SHARED_REQUESTED)

if (STATIC_REQUESTED GREATER -1 AND SHARED_REQUESTED GREATER -1)
    message(FATAL_ERROR "STATIC AND SHARED libraries cannot be requested at the same time")
elseif (SHARED_REQUESTED GREATER -1)
    find_library(Dwarf_LIBRARY libdwarf.so)
    set(LIBRARY_TYPE SHARED)
else ()
    find_library(Dwarf_LIBRARY libdwarf.a)
    set(LIBRARY_TYPE STATIC)
endif ()

if (Dwarf_LIBRARY)
    add_library(Dwarf ${LIBRARY_TYPE} IMPORTED)
    add_library(Dwarf::Dwarf ALIAS Dwarf)
    set_target_properties(Dwarf
            PROPERTIES IMPORTED_LOCATION "${Dwarf_LIBRARY}")
    find_path(Dwarf_INCLUDE_DIR libdwarf.h HINTS /usr/include/libdwarf)
    target_include_directories(Dwarf INTERFACE ${Dwarf_INCLUDE_DIR})
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Dwarf REQUIRED_VARS Dwarf_LIBRARY Dwarf_INCLUDE_DIR)
