#include <climits>
#include <stdint.h>
#include <stdio.h>

#include <fuzzer/FuzzedDataProvider.h>

extern void VL_DBG_MSGF(const char* formatp, ...);

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size) {
    FuzzedDataProvider provider(data, size);
    std::string str = provider.ConsumeRandomLengthString(1000);
    const char* cstr = str.c_str();
    VL_DBG_MSGF(cstr);

    return 0;
}