cmake_minimum_required(VERSION 3.19)
project(SimpleCXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

add_subdirectory(backward-cpp)

add_executable(main main.cpp)
target_link_libraries(main PRIVATE backward::backward)
target_compile_options(main PRIVATE -Wno-psabi )

add_custom_target(flash COMMAND scp $<TARGET_FILE:main> liftbot@192.168.1.66:~)
add_dependencies(flash main)

