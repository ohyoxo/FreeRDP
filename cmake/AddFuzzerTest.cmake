macro(add_fuzzer_test FILES LINK_LIBS)
  if(BUILD_FUZZERS)
    string(REPLACE " " ";" LOCAL_LINK_LIBS ${LINK_LIBS})
    list(APPEND LOCAL_LINK_LIBS fuzzer_config)
    foreach(test ${FILES})
      get_filename_component(TestName ${test} NAME_WE)
      add_executable(${TestName} ${test})
      # Use PUBLIC to force 'fuzzer_config' for all dependent targets.
      target_link_libraries(${TestName} PUBLIC ${LOCAL_LINK_LIBS})
      add_test(${TestName} ${TESTING_OUTPUT_DIRECTORY}/${MODULE_NAME} ${TestName})
      set_target_properties(${TestName} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${TESTING_OUTPUT_DIRECTORY}")
      add_dependencies(fuzzers ${TestName})
    endforeach()
  endif(BUILD_FUZZERS)
endmacro()
