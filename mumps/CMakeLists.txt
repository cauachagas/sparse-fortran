cmake_minimum_required(VERSION 3.14)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release" FORCE)
endif()
project(MumpsExamples
  LANGUAGES C Fortran)
enable_testing()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules)
find_package(MPI COMPONENTS Fortran REQUIRED)
find_package(OpenMP COMPONENTS C Fortran)

if(realbits EQUAL 32)
  set(arith s)
else()
  set(arith d)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/mumps.cmake)

if(MUMPS_FOUND)
  add_executable(testmumps test_mumps.f90)
  target_link_libraries(testmumps PRIVATE MUMPS::MUMPS SCALAPACK::SCALAPACK LAPACK::LAPACK MPI::MPI_Fortran)

  add_test(NAME MUMPS
    COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS}
      $<TARGET_FILE:testmumps> ${CMAKE_CURRENT_SOURCE_DIR}/input_simpletest_real)
  set_tests_properties(MUMPS PROPERTIES RUN_SERIAL true TIMEOUT 15)
endif(MUMPS_FOUND)
