# AT32F435CGT7 芯片事实 —— 换芯片只改这个文件

get_filename_component(PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/.." ABSOLUTE)

# 内核参数，编译和链接都要用
set(MCU_CPU_FLAGS
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard          # 须与 FreeRTOS 的 ARM_CM4F 移植层一致
)

set(MCU_DEFINES
    AT32F435CGT7              # 器件型号，决定寄存器定义
    AT_START_F435_V1
    USE_STDPERIPH_DRIVER
)

set(MCU_STARTUP_SRC
    ${PROJECT_ROOT}/board/at32f435_437/startup_at32f435_437.s
)

set(MCU_SYSTEM_SRC
    ${PROJECT_ROOT}/libraries/cmsis/cm4/device_support/system_at32f435_437.c
)

set(MCU_INCLUDE_DIRS
    ${PROJECT_ROOT}/libraries/cmsis/cm4/core_support
    ${PROJECT_ROOT}/libraries/cmsis/cm4/device_support
    ${PROJECT_ROOT}/libraries/drivers/inc
)

# 外设驱动：用哪个列哪个，不用的不参与编译
# 以后常用：wdt（看门狗）/ can / dma / crc
set(MCU_DRIVER_SOURCES
    ${PROJECT_ROOT}/libraries/drivers/src/at32f435_437_crm.c
    ${PROJECT_ROOT}/libraries/drivers/src/at32f435_437_flash.c
    ${PROJECT_ROOT}/libraries/drivers/src/at32f435_437_gpio.c
    ${PROJECT_ROOT}/libraries/drivers/src/at32f435_437_misc.c
    ${PROJECT_ROOT}/libraries/drivers/src/at32f435_437_usart.c
)

set(MCU_LINKER_SCRIPT
    ${PROJECT_ROOT}/board/at32f435_437/AT32F435xG_FLASH.ld   # 1024K FLASH / 384K RAM
)
