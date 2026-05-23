#!/bin/bash
set -e

echo "=== WagoRenshuchou Bootstrap ==="

if ! command -v xcodegen &> /dev/null; then
  echo "Installing XcodeGen..."
  brew install xcodegen
fi

if ! command -v swiftlint &> /dev/null; then
  echo "Installing SwiftLint..."
  brew install swiftlint
fi

echo "Generating Xcode project..."
xcodegen generate

echo ""
echo "Done. Open WagoRenshuchou.xcodeproj in Xcode."
echo "Add iCloud + CloudKit capabilities in Signing & Capabilities before first build."
