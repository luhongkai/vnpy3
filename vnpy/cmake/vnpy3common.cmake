
macro(init_compiler_system)
	if(WIN32)
		if(CMAKE_CONFIGURATION_TYPES)
			set(CMAKE_CONFIGURATION_TYPES Debug Release)
		 endif()

		message(status "Setting MSVC flags")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W3 /WX- /D UNICODE")
		add_definitions(-D_SCL_SECURE_NO_WARNINGS)
		add_definitions(-D_CRT_SECURE_NO_WARNINGS)
	endif(WIN32)

	if(UNIX)	
		add_definitions(-Wall)
		add_definitions(-fPIC)
		include(CheckCXXCompilerFlag)
		CHECK_CXX_COMPILER_FLAG(-std=c++11 HAVING_COMPILER_SUPPORTS_CXX11)
		if(HAVING_COMPILER_SUPPORTS_CXX11)
			add_definitions(-std=c++11)
		else(HAVING_COMPILER_SUPPORTS_CXX11)
			CHECK_CXX_COMPILER_FLAG(-std=c++0x HAVING_COMPILER_SUPPORTS_CXX0X)
			if(HAVING_COMPILER_SUPPORTS_CXX0X)
				add_definitions(-std=c++0x)
			else(HAVING_COMPILER_SUPPORTS_CXX0X)
				message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
			endif(HAVING_COMPILER_SUPPORTS_CXX0X)
		endif(HAVING_COMPILER_SUPPORTS_CXX11)
	endif(UNIX)

endmacro(init_compiler_system)


macro(init_pthread_rt)	
	if(UNIX)
	#	if(CMAKE_USE_PTHREADS_INIT)
			set(CMAKE_USE_PTHREADS_INIT -lpthread)
			include(CheckLibraryExists)
			CHECK_LIBRARY_EXISTS(rt clock_gettime "" HAVING_REALTIME_LIB)
			IF(HAVING_REALTIME_LIB)
				LIST(APPEND CMAKE_USE_PTHREADS_INIT -lrt)
			ENDIF(HAVING_REALTIME_LIB)
	#	ENDIF(CMAKE_USE_PTHREADS_INIT)
	endif(UNIX)
endmacro(init_pthread_rt)