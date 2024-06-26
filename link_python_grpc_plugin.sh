if command -v protoc-gen-grpc_python; then
    echo "protoc-gen-grpc_python already installed"
	exit 0
fi

if command -v grpc_python_plugin; then
  echo "grpc_python_plugin already installed creating link."
  plugin_path=$(which grpc_python_plugin)
  linked_path=$(readlink $plugin_path)
  canonicalPath=$(cd $(dirname "$(dirname $plugin_path)/${linked_path}"); pwd)
  echo "${canonicalPath}/$(basename $plugin_path)"
  echo "$(dirname $plugin_path)/protoc-gen-grpc_python"
  ln -s "${canonicalPath}/$(basename $plugin_path)" "$(dirname $plugin_path)/protoc-gen-grpc_python"
  exit 0
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends python3.9 protobuf-compiler-grpc
  sudo ln -s /usr/bin/grpc_python_plugin /usr/bin/protoc-gen-grpc_python
  exit 0
fi
echo "Error: grpc_python_plugin not found. Please install protoc"
exit 1
