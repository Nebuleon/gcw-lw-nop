#include <stdint.h>
#include <stdlib.h>

#define CACHE_LINE_SIZE 32

extern void OpNop1(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop2(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop3(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop4(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop5(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop6(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop7(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop8(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop9(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop10(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop11(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop12(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop13(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop14(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop15(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop16(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop17(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop18(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop19(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop20(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop21(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop22(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop23(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop24(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop25(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop26(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop27(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop28(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop29(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop30(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop31(void* Memory, uint32_t Blocks, uint32_t BlockDistance);
extern void OpNop32(void* Memory, uint32_t Blocks, uint32_t BlockDistance);

void (*OpNopFuncs[32]) (void*, uint32_t, uint32_t) = {
	OpNop1, OpNop2, OpNop3, OpNop4, OpNop5, OpNop6, OpNop7, OpNop8, OpNop9, OpNop10, OpNop11, OpNop12, OpNop13, OpNop14, OpNop15, OpNop16, OpNop17, OpNop18, OpNop19, OpNop20, OpNop21, OpNop22, OpNop23, OpNop24, OpNop25, OpNop26, OpNop27, OpNop28, OpNop29, OpNop30, OpNop31, OpNop32
};

int main(int argc, char** argv)
{
	if (argc < 3)
		return 1; // Failure: insufficient command-line arguments

	uint32_t NOPs = atoi(argv[1]);
	uint32_t Blocks = atoi(argv[2]);

	uint32_t* Memory = malloc(Blocks * CACHE_LINE_SIZE);

	void* Cur;
	uint32_t i;
	for (Cur = Memory;
	     Cur < (void*) Memory + Blocks * CACHE_LINE_SIZE;
	     i++, Cur += CACHE_LINE_SIZE)
	{
		*(uint32_t*) Cur = i;
	}

	OpNopFuncs [NOPs - 1] (Memory, Blocks, CACHE_LINE_SIZE);
	free(Memory);

	return 0; // Success
}

#ifdef DSTWO
#include <stdio.h>
#include "console.h"
#include "fs_api.h"
#include "ds2io.h"
#include "ds2_cpu.h"
#include "ds2_timer.h"
#include "ds2_malloc.h"

#define BLACK_COLOR		RGB15(0, 0, 0)
#define WHITE_COLOR		RGB15(31, 31, 31)

void ds2_main(void)
{
	int err;
	ds2_setCPUclocklevel(11);

	//Initial video and audio and other input and output
	err = ds2io_init(1024);
	if(err) goto _failure;

	ConsoleInit(RGB15(31, 31, 31), RGB15(0, 0, 0), DOWN_SCREEN, 2);

	unsigned int Time = getSysTime();

	//go to user main funtion
	main (0, 0);

	Time = getSysTime() - Time;

	printf("%u units\n\nof 42.667 us", Time);

	ds2_setCPUclocklevel(0);

	struct key_buf inputdata;

	do
		ds2_getrawInput(&inputdata);
	while (inputdata.key == 0);
	ds2_setBacklight(3);
	ds2_plug_exit();
	while (1);

_failure:
	ds2_plug_exit();
}

#endif