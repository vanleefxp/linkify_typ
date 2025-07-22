build:
	@cd $(dir $(MAKEFILE_LIST)) && cargo build --release --target wasm32-unknown-unknown

copy:
	@cd $(dir $(MAKEFILE_LIST)) && powershell Copy-Item -Path "./target/wasm32-unknown-unknown/release/bili.wasm" -Destination "../../src/_impl/bili.wasm"