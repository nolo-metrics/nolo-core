/* cpu-darwin.c - collect cpu stats for each user, idle, sys, nice and
 * report in nolo format. For more details, see:
 * https://www.opensource.apple.com/source/xnu/xnu-2782.1.97/osfmk/man/host_statistics.html
 */

#include <mach/mach_host.h>
#include <stdio.h>
#include <err.h>

int main(int argc, char *argv[])
{
  mach_msg_type_number_t count = HOST_CPU_LOAD_INFO_COUNT;
  mach_port_t nolo_port;
  kern_return_t kr;
  host_cpu_load_info_data_t cpuStats;

  nolo_port = mach_host_self();
  kr = host_statistics(nolo_port, HOST_CPU_LOAD_INFO, (host_info_t)&cpuStats, &count);
  if (kr != KERN_SUCCESS) {
    err(-1, "error from host_statistics(): %d", kr);
  }

  printf("user %u\n", cpuStats.cpu_ticks[CPU_STATE_USER]);
  printf("idle %u\n", cpuStats.cpu_ticks[CPU_STATE_IDLE]);
  printf("sys %u\n", cpuStats.cpu_ticks[CPU_STATE_SYSTEM]);
  printf("nice %u\n", cpuStats.cpu_ticks[CPU_STATE_NICE]);

  return 0;
}
