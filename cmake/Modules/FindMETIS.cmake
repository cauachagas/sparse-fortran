# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindMETIS
-------
Michael Hirsch, Ph.D.

Finds the METIS library

Result Variables
^^^^^^^^^^^^^^^^

METIS_LIBRARIES
  libraries to be linked

METIS_INCLUDE_DIRS
  dirs to be included

#]=======================================================================]


find_library(METIS_LIBRARY
             NAMES parmetis metis
             NAMES_PER_DIR
             PATH_SUFFIXES METIS lib libmetis)

find_path(METIS_INCLUDE_DIR
          NAMES parmetis.h metis.h
          PATH_SUFFIXES METIS include)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(METIS
    REQUIRED_VARS METIS_LIBRARY METIS_INCLUDE_DIR)

if(METIS_FOUND)
# need if _FOUND guard to allow project to autobuild; can't overwrite imported target even if bad
set(METIS_LIBRARIES ${METIS_LIBRARY})
set(METIS_INCLUDE_DIRS ${METIS_INCLUDE_DIR})

if(NOT TARGET METIS::METIS)
  add_library(METIS::METIS INTERFACE IMPORTED)
  set_target_properties(METIS::METIS PROPERTIES
                        INTERFACE_LINK_LIBRARIES "${METIS_LIBRARY}"
                        INTERFACE_INCLUDE_DIRECTORIES "${METIS_INCLUDE_DIR}"
                      )
endif()
endif(METIS_FOUND)

mark_as_advanced(METIS_INCLUDE_DIR METIS_LIBRARY)
