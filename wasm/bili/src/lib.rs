mod bili;
use wasm_minimal_protocol::*;

initiate_protocol!();

#[wasm_func]
fn av2bv(arg: &[u8]) -> Vec<u8> {
    let avid = i64::from_le_bytes(arg.try_into().unwrap());
    let bvid = bili::av2bv(avid);
    bvid.as_bytes().to_vec()
}

#[wasm_func]
fn bv2av(arg: &[u8]) -> Result<Vec<u8>, String> {
    let bvid = String::from_utf8_lossy(arg).to_string();
    match bili::bv2av(&bvid) {
        Ok(avid) => Ok(avid.to_le_bytes().to_vec()),
        Err(e) => Err(e),
    }
}
