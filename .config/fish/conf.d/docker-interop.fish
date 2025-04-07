if type -q podman
    set --export DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"
end
