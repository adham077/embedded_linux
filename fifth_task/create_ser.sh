read -p "Enter a username for the new user: " USER_NAME 
echo

if grep -q "^$USER_NAME:" /etc/passwd; then
    echo "User '$USER_NAME' already exists."
    exit 1
fi

read -s -p "Enter a Password for the new user: " PASSWORD 
echo

read -s -p "Confirm Password for the new user: " PASSWORD_CONFIRM 
echo

NEXT_UID=$(($(awk -F: '($3 >= 1000 && $3 < 65534) {if ($3 > max) max=$3} END {print max}' /etc/passwd) + 1))
NEXT_GID=$(($(awk -F: '($3 >= 1000 && $3 < 65534) {if ($3 > max) max=$3} END {print max}' /etc/group) + 1))

read -p "Enter a Group for the new user: " GROUP_NAME
echo

if [ "$PASSWORD" != "$PASSWORD_CONFIRM" ]; then
    echo "Passwords do not match."
    exit 1
fi

PASSWORD_HASH=$(echo "$PASSWORD" | openssl passwd -6 -stdin)

if grep -q "^$GROUP_NAME:" /etc/group; then
    echo "Adding User: '$USER_NAME' to group: '$GROUP_NAME'"
    GROUP_ID=$(getent group "$GROUP_NAME" | awk -F: '{print $3}')
else
    echo "Creating group '$GROUP_NAME' and adding user:'$USER_NAME' to it"
    echo "$GROUP_NAME:x:$NEXT_GID:" | sudo tee -a /etc/group > /dev/null
    GROUP_ID=$NEXT_GID
    echo "Group '$GROUP_NAME' created with GID $GROUP_ID."
fi

echo "$USER_NAME:x:$NEXT_UID:$GROUP_ID:$USER_NAME:/home/$USER_NAME:/bin/bash" | sudo tee -a /etc/passwd > /dev/null
echo "$USER_NAME:$PASSWORD_HASH:19102:0:99999:7:::" | sudo tee -a /etc/shadow > /dev/null
sudo mkdir -p "/home/$USER_NAME"
sudo cp ~/.bashrc /home/$USER_NAME
sudo chown "$NEXT_UID:$GROUP_ID" "/home/$USER_NAME/.bashrc"
sudo chown "$NEXT_UID:$GROUP_ID" "/home/$USER_NAME"
sudo chmod 755 "/home/$USER_NAME"
sudo chmod 755 "/home/$USER_NAME/.bashrc"

echo "User '$USER_NAME' created with UID $NEXT_UID and added to group '$GROUP_NAME'."
