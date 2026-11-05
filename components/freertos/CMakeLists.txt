# 源码在 middlewares/，这里只负责编成库
set(FT ${CMAKE_CURRENT_SOURCE_DIR}/../../middlewares/FreeRTOS)

add_library(freertos STATIC
    ${FT}/croutine.c
    ${FT}/event_groups.c
    ${FT}/list.c
    ${FT}/queue.c
    ${FT}/stream_buffer.c
    ${FT}/tasks.c
    ${FT}/timers.c
    ${FT}/portable/GCC/ARM_CM4F/port.c
    ${FT}/portable/MemMang/heap_4.c
)

target_link_libraries(freertos PUBLIC mcu_flags)

target_include_directories(freertos PUBLIC
    ${FT}/include
    ${FT}/portable/GCC/ARM_CM4F
)

target_compile_definitions(freertos INTERFACE COMPONENT_FREERTOS=1)
