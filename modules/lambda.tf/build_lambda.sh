#!/bin/bash
set -e

# Clean previous builds
rm -f lambda.zip
rm -rf package

# Create package folder
mkdir package

# Install dependencies (if any)
if [ -s lambda/requirements.txt ]; then
    python3.12 -m pip install -r lambda/requirements.txt -t package/
fi

# Copy Lambda code
cp lambda/*.py package/

# Create ZIP
cd package
zip -r ../lambda.zip .
cd ..

# Clean up
rm -rf package

echo "Lambda package created: lambda.zip"
