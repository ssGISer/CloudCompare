# On Linux and Windows, we need to install the libraries that CGAL depends on.
# Because these are dependencies, we don't have access to the targets, so we
# must work with files.

# Use the variables set by the libraries themselves and call InstallFiles() on them.

if( CCCORELIB_USE_TBB )
	InstallFiles( FILES ${TBB_LIBRARY_RELEASE} )
endif()

if( CCCORELIB_USE_CGAL )
	get_target_property( cgal_header_only CCCoreLib CGAL_HEADER_ONLY )
	
	if( NOT cgal_header_only )
		InstallFiles( FILES ${CGAL_LIBRARIES} )
	endif()
	
	InstallFiles( FILES ${GMP_LIBRARIES} )
	InstallFiles( FILES ${MPFR_LIBRARIES} )
endif()

if( CCCORELIB_USE_QT_CONCURRENT )
	# We have already used find_package() for this.
	# Link to it as a target so deployqt can install it properly.
	target_link_libraries( ${PROJECT_NAME}
		Qt5::Concurrent
	)
endif()
