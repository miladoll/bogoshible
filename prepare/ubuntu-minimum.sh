#!/bin/sh

cd ~root

apt -y update

apt -y install \
    wget \
    apt \
    bash \
    coreutils \
    sed \
    gawk \
    openssh-client \
    git

wget https://raw.githubusercontent.com/miladoll/bogoshible/master/bogoshible
chmod +x bogoshible
mv bogoshible /usr/local/bin/bogoshible

cat > /usr/local/bin/git_with_key <<'_EOF_'
#!/bin/sh
set -e

is_temp=0
if [ -p /dev/stdin ] || [ "$1" = '-' ]; then
    key_file=`mktemp`
    [ -p /dev/stdin ] || shift
    cat - > "$key_file"
    is_temp=1
else
    key_file="$1"
    shift
fi

if [ ! -r "${key_file-}" ]; then
    echo "No such id file... ${key_file-}"
    exit 1
fi
if [ "$#" -lt 1 ]; then
    echo "Insufficient arguments..."
    exit 1
fi

git -c core.sshCommand="ssh -i $key_file -F /dev/null" "$@"

if [ "${is_temp-}" -eq 1 ]; then
    \rm $key_file
fi
_EOF_
chmod +x /usr/local/bin/git_with_key
