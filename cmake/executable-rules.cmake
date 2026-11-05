# 只对可执行目标生效：静态库不参与链接
target_link_options(${PROJECT_NAME}.elf PRIVATE
    ${MCU_CPU_FLAGS}
    -T${MCU_LINKER_SCRIPT}
    -Wl,--gc-sections
    -Wl,--print-memory-usage
    -Wl,--no-warn-rwx-segments        # 内置 Flash 工程的常态，屏蔽掉
    -Wl,-Map=${CMAKE_BINARY_DIR}/${PROJECT_NAME}.map
    -specs=nano.specs
    -specs=nosys.specs
    -u _printf_float                  # printf 支持 %f，不用可删
)

# 用 gcc 链接而非 g++：C++ 组件不依赖 libstdc++（无异常/RTTI）
set_target_properties(${PROJECT_NAME}.elf PROPERTIES LINKER_LANGUAGE C)

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex   $<TARGET_FILE:${PROJECT_NAME}.elf> ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}.elf> ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.bin
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}.elf>
    COMMENT "生成 hex / bin"
)

add_custom_target(clean-bin
    COMMAND ${CMAKE_COMMAND} -E rm -f
            ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.hex
            ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.bin
            ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.map
)
