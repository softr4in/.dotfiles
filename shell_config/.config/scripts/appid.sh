for app in /Applications/*.app; do
  echo "$app: $(mdls -name kMDItemCFBundleIdentifier -raw "$app")"
done

for app in /Users/trisyong/homefiles/apps/*.app; do
  echo "$app: $(mdls -name kMDItemCFBundleIdentifier -raw "$app")"
done
