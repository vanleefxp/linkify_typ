/// Typst implementation of Bilibili AVID-BVID conversion
/// The code is now replaced by more efficient Rust implementation and is thus obsolete. Left here for reference only.

#let key = "fZodR9XQDSUm21yCkr6zBqiveYah8bt4xsWpHnJE7jL5VG3guMTKNPAwcF"
#let key-inv-map = (
  key
    .clusters()
    .enumerate()
    .map(array.rev)
    .to-dict()
)
#let reorder-arg = (9, 8, 1, 6, 2, 4, 0, 7, 3, 5)
#let mask = 177451812
#let sh = 100618342136696320

#let bv2av(bvid) = {
  let bvid = bvid
  if (
    bvid.len() == 12 and
    (bvid.starts-with("BV") or bvid.starts-with("bv"))
  ) {
    bvid = bvid.slice(2)
  }
  if not bvid.len() == 10 {
    panic("Invalid BVID format.")
  }

  let r = 0
  let d = 1
  for pos in reorder-arg {
    r += key-inv-map.at(bvid.at(pos)) * d
    d *= 58
  }

  (r - sh).bit-xor(mask)
}

#let av2bv(avid, prefix: false) = {
  let avid = avid
  avid = avid.bit-xor(mask) + sh
  let res = (none,) * 10
  for pos in reorder-arg {
    res.at(pos) = key.at(calc.rem-euclid(avid, 58))
    avid = calc.div-euclid(avid, 58)
  }
  if prefix { "BV" } + res.join("")
}
