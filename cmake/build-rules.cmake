# 所有目标共享的编译设置
add_library(mcu_flags INTERFACE)

target_compile_options(mcu_flags INTERFACE
    ${MCU_CPU_FLAGS}
    -Wall -Wextra
    -ffunction-sections -fdata-sections
    $<$<CONFIG:Debug>:-Og -g3>
    $<$<CONFIG:Release>:-Os -g0>
)

target_compile_definitions(mcu_flags INTERFACE
    ${MCU_DEFINES}
    $<$<CONFIG:Release>:NDEBUG>
)

target_include_directories(mcu_flags INTERFACE
    ${MCU_INCLUDE_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}/bsp/inc
)
