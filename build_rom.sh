repo init -u https://github.com/PixelOS-Pixelish/manifest -b eleven-plus --depth=1 --no-repo-verify -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kanup4m/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
 
# build rom
source build/envsetup.sh
lunch floko_r5x-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
