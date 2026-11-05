cmake_minimum_required(VERSION 3.22)

# 语言标准
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# 没指定构建类型时默认 Debug
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build Type: Debug/Release" FORCE)
endif()

project(at32f4_template LANGUAGES C CXX ASM)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
message(STATUS "Build Type = ${CMAKE_BUILD_TYPE}")

# 芯片事实 + 编译策略
include(cmake/mcu-at32f435.cmake)
include(cmake/build-rules.cmake)

add_executable(${PROJECT_NAME}.elf
    ${MCU_STARTUP_SRC}
    ${MCU_SYSTEM_SRC}
    ${MCU_DRIVER_SOURCES}
)
target_link_libraries(${PROJECT_NAME}.elf PRIVATE mcu_flags)

include(cmake/executable-rules.cmake)

# 启用的组件：增删只改这一行
set(COMPONENTS freertos)

if(COMPONENTS AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/components)
    foreach(c ${COMPONENTS})
        add_subdirectory(components/${c})
    endforeach()
    add_library(components INTERFACE)
    target_link_libraries(components INTERFACE ${COMPONENTS})
    target_link_libraries(${PROJECT_NAME}.elf PRIVATE components)
endif()

add_subdirectory(core)
add_subdirectory(bsp)
