for app in /Users/trisyong/homefiles/apps/*.app; do
	xattr -d com.apple.quarantine "$app"
done
