# Set Toolchin
set(CMAKE_ASM_COMPILER  clang)
set(CMAKE_C_COMPILER    clang)
set(CMAKE_CXX_COMPILER  clang++)
set(CMAKE_LINKER        clang)
set(CMAKE_PP            ${TRIPLE}cpp)
set(CMAKE_AR            llvm-ar)
set(CMAKE_OBJCOPY       ${TRIPLE}objcopy)
set(CMAKE_OBJDUMP       ${TRIPLE}objdump)
set(CMAKE_RANLIB        llvm-ranlib)
set(CMAKE_STRIP         llvm-strip)
set(CMAKE_SIZE          llvm-size)
set(CMAKE_C_COMPILER_TARGET ${TARGET_TRIPLE})
set(CMAKE_CXX_COMPILER_TARGET ${TARGET_TRIPLE})

# Get And Apply sysroot
execute_process(
    COMMAND ${TRIPLE}gcc -print-sysroot
    OUTPUT_VARIABLE GCC_SYSROOT
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
if(GCC_SYSROOT)
    set(CMAKE_SYSROOT "${GCC_SYSROOT}" CACHE PATH "Sysroot path" FORCE)
    message(STATUS "Sysroot detected: ${CMAKE_SYSROOT}")
else()
    message(WARNING "Failed to detect sysroot from ${CMAKE_C_COMPILER}")
endif()

# Find And Apply gcc-toolchain
execute_process(
    COMMAND which ${TRIPLE}gcc
    OUTPUT_VARIABLE GCC_TOOLCHAIN
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
get_filename_component(GCC_TOOLCHAIN_BIN "${GCC_TOOLCHAIN}" DIRECTORY)
get_filename_component(GCC_TOOLCHAIN_ROOT "${GCC_TOOLCHAIN_BIN}" DIRECTORY)

set(LLVM_TARGET_AND_SYSROOT "--target=${TARGET_TRIPLE} --sysroot=${CMAKE_SYSROOT} --gcc-toolchain=${GCC_TOOLCHAIN_ROOT}")
set(CMAKE_C_FLAGS_INIT             "${LLVM_TARGET_AND_SYSROOT}")
set(CMAKE_CXX_FLAGS_INIT           "${LLVM_TARGET_AND_SYSROOT}")
set(CMAKE_ASM_FLAGS_INIT           "${LLVM_TARGET_AND_SYSROOT}")
set(CMAKE_EXE_LINKER_FLAGS_INIT    "${LLVM_TARGET_AND_SYSROOT} -fuse-ld=bfd")
set(CMAKE_SHARED_LINKER_FLAGS_INIT "${LLVM_TARGET_AND_SYSROOT} -fuse-ld=bfd")
set(CMAKE_MODULE_LINKER_FLAGS_INIT "${LLVM_TARGET_AND_SYSROOT} -fuse-ld=bfd")

set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
