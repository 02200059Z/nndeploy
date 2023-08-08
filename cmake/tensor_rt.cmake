
include(ExternalProject)

if (ENABLE_NNDEPLOY_INFERENCE_TENSORRT STREQUAL "ON")
  set(NNDEPLOY_THIRD_PARTY_LIBRARY ${NNDEPLOY_THIRD_PARTY_LIBRARY} libnvinfer.so)
  set(NNDEPLOY_THIRD_PARTY_LIBRARY ${NNDEPLOY_THIRD_PARTY_LIBRARY} libnvinfer_plugin.so)
  set(NNDEPLOY_THIRD_PARTY_LIBRARY ${NNDEPLOY_THIRD_PARTY_LIBRARY} libnvparsers.so)
  set(NNDEPLOY_THIRD_PARTY_LIBRARY ${NNDEPLOY_THIRD_PARTY_LIBRARY} libnvonnxparser.so)
else()
  include_directories(${ENABLE_NNDEPLOY_INFERENCE_TENSORRT}/include)
  set(LIB_PATH ${ENABLE_NNDEPLOY_INFERENCE_OPENVINO}/lib)
  set(LIBS "nvinfer" "nvinfer_plugin" "nvparsers" "nvonnxparser")
  foreach(LIB ${LIBS})
    set(LIB_NAME ${NNDEPLOY_LIB_PREFIX}${LIB}${NNDEPLOY_LIB_SUFFIX})
    set(FULL_LIB_NAME ${LIB_PATH}/${LIB_NAME})
    set(NNDEPLOY_THIRD_PARTY_LIBRARY ${NNDEPLOY_THIRD_PARTY_LIBRARY} ${FULL_LIB_NAME})    
  endforeach()
  file(GLOB_RECURSE INSTALL_LIBS "${LIB_PATH}/*")
  foreach(INSTALL_LIB ${INSTALL_LIBS})
    install(FILES ${INSTALL_LIB} DESTINATION ${NNDEPLOY_INSTALL_PATH})
  endforeach()
endif()