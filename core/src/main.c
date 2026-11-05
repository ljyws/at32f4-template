#include "at32f435_437_clock.h"

#ifdef COMPONENT_FREERTOS
#include "freertos_main.h"
#endif

int main(void)
{
    system_clock_config();

#ifdef COMPONENT_FREERTOS
    startup_task_create();
    vTaskStartScheduler();
#endif

    while (1) {
    }
}
