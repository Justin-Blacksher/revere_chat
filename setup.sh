#!/bin/bash

# Dependencies list
needful_installs=("sudo" "openssl" "go" "build-base" "libsodium-dev" "make" "git" "openrc" "autoconf")
# Important folders needed
important_folders=("/usr/local/mkp224o" "/usr/local/revere/keys" "/run/openrc" "/usr/local/revere" "/usr/local/revere/certificates")
# Important files and some nit picky stuff
openrcfile="softlevel"
log_file="/usr/local/revere/logfile.txt"
# User for changes in tor folders
user="tor"
# Openssl setup
days=365
subj="/CN=localhost"
keyout="/usr/local/revere/keys"
keyname="server.key"
encryption="rsa:2048"
crtout="server.crt"
# Vanity URL
vanity=("Foxx" "Hounds" "Turtle" "Eagle" "" "Lakers" "Nets")
githublink="https://github.com/cathugger/mkp224o.git"
vanitygen="mkp224o"
gen_dir="/usr/local/mkp224o"




function main() {
    # Get the start time
    start=$(date +%s.%N)
    # =============================
    echo "======= [ Installing The Needful ] ========"
    log "Dependencies started"
    install_the_needful
    log "Dependencies ended"
    echo "======= [          END           ] ========"
    # ==============================
    echo "======= [  Creating the softfile ] ========"
    log "Softfile requirements"
    echo "Creating the softfile"
    create_openrc_file
    echo "Done creating softfile"
    log "Softfile requirements met"
    echo "======= [          END           ] ========"
    # ==============================
    echo "======= [  Creating the needful folders ] ========"
    log "Folder requirements started"
    needful_folders
    log "Folder requirements met"
    echo "======= [          END           ] ========"
    # ==============================
    echo "======= [  Creating the needful Certificates ] ========"
    log "Certificate requirements started"
    needful_certificates
    log "Certificate requirements met"
    echo "======= [          END           ] ========"
    # ==============================
    echo "======= [  Creating the needful Vanity ] ========"
    log "Vanity requirements started"
    vanity_needful
    log "Vanity requirements met"
    echo "======= [          END           ] ========"
    # ==============================
    end=$(date +%s.%N)
    elapsed=$(echo "$end - $start" | bc)
    echo "Elapsed time: $elapsed seconds"
    log "Elapsed time: $elapsed seconds"
}



# Lets install some things
function install_the_needful () {
    log "Creating the Needful dependencies"
    for item in "${needful_installs[@]}"; do
        # Get the start time
        start=$(date +%s.%N)

        # Your commands or function calls go here
        echo "Now installing ........... $item"
        apk add $item &
        wait
        # Get the end time
        end=$(date +%s.%N)

        # Calculate the elapsed time
        elapsed=$(echo "$end - $start" | bc)
        echo "Elapsed time: $elapsed seconds"
        log "Elapsed time: $elapsed seconds"
    done
}

function log() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $1" >> "$log_file"
}

function create_openrc_file() {
    log "Creating softfile for openrc"
    touch "$openrcfile"
    log "Created softfile for openrc"
}

function needful_folders() {
    log "Creating the Needful Folders"
    for folder in "${important_folders[@]}"; do
        # Get the start time
        start=$(date +%s.%N)

        # Your commands or function calls go here
        echo "Now creating folder ........... $folder"
        mkdir -p $folder
        wait
        # Get the end time
        end=$(date +%s.%N)

        # Calculate the elapsed time
        elapsed=$(echo "$end - $start" | bc)
        echo "Elapsed time: $elapsed seconds"
        log "Elapsed time: $elapsed seconds"
    done
}

function needful_certificates() {
    log "Creating the certificates"
    openssl req -new -newkey "$encryption" -days $days -nodes -x509 -subj "$subj" -keyout "$keyout/$keyname" -out "$keyout/$crtout"
    log "Certificates $keyname and $crtout have been created"
}

function vanity_needful() {
    log "Generating Vanity URL"
    start=$(date +%s.%N)
    git_link
    run_autogen
    run_configure
    run_make
    end=$(date +%s.%N)
    echo "Elapsed time: $elapsed seconds"
    log "Elapsed time: $elapsed seconds"
}

function git_link() {
    log "Getting the vanity url program"
    echo "Cloning $githublink"
    git clone "$githublink" "$gen_dir"
    echo "Done cloning..."
    log "Finished getting the program"
    ls $gen_dir
}

function run_autogen() {
    log "cd ${pwd}"
    pwd
    cd "$gen_dir"
    log "./autogen running ............"
    start=$(date +%s.%N)
    ./autogen.sh
    end=$(date +%s.%N)
    echo "Elapsed time: $elapsed seconds"
    log "Elapsed time: $elapsed seconds"
}

function run_configure() {
    log "cd ${pwd}"
    cd "$gen_dir"
    log "./configure running .........."
    start=$(date +%s.%N)
    ./configure
    end=$(date +%s.%N)
    echo "Elapsed time: $elapsed seconds"
    log "Elapsed time: $elapsed seconds"
}

function run_make() {
    log "cd ${pwd}"
    cd "$gen_dir"
    log "running make ............."
    start=$(date +%s.%N)
    make
    echo "Elapsed time: $elapsed seconds"
    log "Elapsed time: $elapsed seconds"
}


# ========== Main Function ==============
log "Main function started"
main
log "Main function completed"
# =======================================