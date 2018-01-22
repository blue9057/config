// standard
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include <time.h>
#include <assert.h>

// Linux specific
#include <unistd.h>
#include <fcntl.h>

// mmap
#include <sys/mman.h>

// others
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

#include <sched.h>



// inline asm template
//int __attribute__((optimize("-O2"))) test_calleax(void *addr)
int test_calleax(void *addr)
{
  asm volatile("call *%0" : : "r"(addr) : "memory");
  return 0;
}


void* mmap_address(size_t size) {

    void *ptr = mmap(0, size, 7, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    // MAP_POPULATE
    //void *ptr = mmap(0, size, 7,
    //                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE,
    //                  -1, 0);

    return ptr;
}


void get_options(int argc, char** argv) {
  char c;
  while ((c = getopt (argc, argv, "t:i:f:r:o:h:")) != -1) {
    switch (c) {
    case 'f':
      //in_fn = strdup(optarg);
      break;
    case 'o':
      //out_fn = strdup(optarg);
      break;
    case 'i':
      //iter = atoi(optarg);
      break;
    case 'r':
      //repeat = atoi(optarg);
      break;
    case 't':
      //test = atoi(optarg);
      break;
    case 'h':
      //print_usage(argv[0]);
      exit(0);
    default:
      //print_usage(argv[0]);
      exit(1);
    }
  }
}

int main(int argc, char** argv, char** envp) {

  get_options(argc, argv);

  return 0;
}
