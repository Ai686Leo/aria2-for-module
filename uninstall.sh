#!/system/bin/sh

APEX_CACERTS_DIRS=$(find /apex -maxdepth 2 -type d -path "*/com.android.conscrypt*" 2>/dev/null)

if [ -z "$APEX_CACERTS_DIRS" ]; then
    exit 1
fi

for APEX_CACERTS_DIR in $APEX_CACERTS_DIRS; do
    CERT_CACHE=/data"$APEX_CACERTS_DIR"
     rm -rf "$CERT_CACHE"
done