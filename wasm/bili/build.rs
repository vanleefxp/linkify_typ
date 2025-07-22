use std::env;
use std::fs::File;
use std::io::{BufWriter, Write};
use std::path::Path;

const KEY: &str = "fZodR9XQDSUm21yCkr6zBqiveYah8bt4xsWpHnJE7jL5VG3guMTKNPAwcF";

fn main() {
    let path = Path::new(&env::var("OUT_DIR").unwrap()).join("codegen.rs");
    let mut file = BufWriter::new(File::create(&path).unwrap());

    write!(&mut file, "const KEY: &str = \"{KEY}\";\n").unwrap();
    write!(&mut file,"static KEY_INV_MAP: phf::Map<char, u8> = phf::phf_map! {{\n").unwrap();
    for (i, ch) in KEY.chars().enumerate() {
        write!(&mut file, "    '{ch}' => {i},\n").unwrap();
    }
    write!(&mut file, "}};\n").unwrap();
}
