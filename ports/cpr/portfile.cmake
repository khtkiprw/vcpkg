vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libcpr/cpr
    REF  60e78f0ce2b1c0fd32bcfb0d644dc8c54c0446ef #v1.8.3
    SHA512 67a3de3329b09fc82e802e1eccb7fa7fc5b015e2d30215fb2d541873c3fa3478db2a31e5782ccc83bcc1a816469accd7f05cec3ea740758e0adcb10e5a75422e
    HEAD_REF master
    PATCHES
        001-cpr-config.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        ssl CPR_ENABLE_SSL
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        -DCPR_BUILD_TESTS=OFF
        -DCPR_FORCE_USE_SYSTEM_CURL=ON
        ${FEATURE_OPTIONS}
    OPTIONS_DEBUG
        -DDISABLE_INSTALL_HEADERS=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/cpr)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
