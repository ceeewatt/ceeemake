#ifndef B_H
#define B_H

#if defined(DEBUG)
  #define B_ID 111
#elif defined(NDEBUG)
  #define B_ID 222
#else
  #define B_ID 999
#endif

#endif
