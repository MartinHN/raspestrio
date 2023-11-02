#activate dhcp on CONNECTION_NAME
nmcli con mod "CONNECTION NAME" ipv4.address ""
nmcli con mod "CONNECTION NAME" ipv4.method auto
nmcli con down "CONNECTION NAME"
nmcli con up "CONNECTION NAME"
