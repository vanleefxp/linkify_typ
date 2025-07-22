include!(concat!(env!("OUT_DIR"), "/codegen.rs"));
const MASK: i64 = 177451812;
const SHIFT: i64 = 100618342136696320;
const REORDER_ARG: [u8; 10] = [9, 8, 1, 6, 2, 4, 0, 7, 3, 5];

pub fn av2bv(avid: i64) -> String {
    let mut avid = (avid ^ MASK) + SHIFT;
    let mut bvid = ['\0'; 10];
    for &pos in &REORDER_ARG {
        bvid[pos as usize] = KEY.chars().nth((avid % 58) as usize).unwrap();
        avid /= 58;
    }
    String::from_iter(bvid)
}

pub fn bv2av(bvid: &str) -> Result<i64, String> {
    let length = bvid.len();
    let mut bvid = bvid;
    if length == 12 && (bvid.starts_with("BV") || bvid.starts_with("bv")) {
        bvid = &bvid[2..];
    } else if bvid.len() != 10 {
        return Err("Invalid BVID format. BVID should contain 10 alphanumeric characters, or optionally preceded by 'BV'.".to_string());
    }
    let mut r: i64 = 0;
    let mut d: i64 = 1;
    for &pos in &REORDER_ARG {
        let ch = bvid.chars().nth(pos as usize).unwrap();
        r += *KEY_INV_MAP
            .get(&ch)
            .ok_or(format!("Invalid character in bvid: {ch}"))? as i64
            * d;
        d *= 58
    }
    Ok((r - SHIFT) ^ MASK)
}
