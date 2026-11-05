# 业务代码
target_sources(${PROJECT_NAME}.elf PRIVATE
    src/main.c
    src/at32f435_437_clock.c
    src/at32f435_437_int.c
)

target_include_directories(${PROJECT_NAME}.elf PRIVATE inc)

if("freertos" IN_LIST COMPONENTS)
    # FreeRTOSConfig.h 属于应用，把目录注入给组件
    target_include_directories(freertos PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/inc)
    target_sources(${PROJECT_NAME}.elf PRIVATE
        src/freertos.c
        src/startup_task.c
    )
endif()
