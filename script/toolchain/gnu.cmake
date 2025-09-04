# Set Toolchin
set(CMAKE_ASM_COMPILER  ${TRIPLE}gcc)
set(CMAKE_C_COMPILER    ${TRIPLE}gcc)
set(CMAKE_CXX_COMPILER  ${TRIPLE}g++)
set(CMAKE_LINKER        ${TRIPLE}ld)
set(CMAKE_PP            ${TRIPLE}cpp)
set(CMAKE_AR            ${TRIPLE}ar)
set(CMAKE_OBJCOPY       ${TRIPLE}objcopy)
set(CMAKE_OBJDUMP       ${TRIPLE}objdump)
set(CMAKE_RANLIB        ${TRIPLE}ranlib)
set(CMAKE_STRIP         ${TRIPLE}strip)
set(CMAKE_SIZE          ${TRIPLE}size)

# Get sysroot
execute_process(
    COMMAND ${CMAKE_C_COMPILER} -print-sysroot
    OUTPUT_VARIABLE GCC_SYSROOT
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Apply sysroot
if(GCC_SYSROOT)
    set(CMAKE_SYSROOT "${GCC_SYSROOT}" CACHE PATH "Sysroot path" FORCE)
    message(STATUS "Sysroot detected: ${CMAKE_SYSROOT}")
else()
    message(WARNING "Failed to detect sysroot from ${CMAKE_C_COMPILER}")
endif()

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
