#let bili-wasm = plugin("./bili.wasm")

/// Regex representing a valid BVID
#let bv-regex = regex("^(?:(?:B|b)(?:V|v))?[1-9A-HJ-NP-Za-km-z]{10}$")

/// Fails with an error if the input is not a valid BVID
#let validate-bv(bvid) = {
  assert(bvid.match(bv-regex) != none, message: "Invalid BVID format.")
}

/// Convert Bilibili BVID to AVID.
///
/// - bvid (str): 10-character Bilibili BVID, or optionally preceded by `BV` (case insensitive), which, if counted would make the string to have 12 characters
/// -> int
#let bv2av(bvid) = {
  let bvid = bytes(bvid)
  let avid = bili-wasm.bv2av(bvid)
  int.from-bytes(avid, endian: "little")
}

/// Convert Bilibili AVID to BVID
///
/// - avid (int): numeric Bilibili AVID
/// - prefix (bool): Whether to add the `BV` prefix in the output result
/// -> str
#let av2bv(avid, prefix: false) = {
  let avid = int.to-bytes(avid, endian: "little")
  let bvid = bili-wasm.av2bv(avid)
  let bvid = str(bvid)
  if prefix { "BV" } + bvid
}

#let invalid-video-id-type() = {
  panic("Invalid `video-id` type. Expects `str` or `int`, got `" + str(type(video-id)) +  "`")
}

/// Turn Bilibili video ID into formatted string.
///
/// - video-id (int | str): The video ID, either AVID or BVID
/// - format (auto | "av" | "bv"): The display format, as AVID or BVID or depending on the input `video-id` type
/// - prefix (bool): Whether to add the `AV` or `BV` prefix
/// ->
#let video-id-fmt(video-id, format: auto, prefix: true) = {
  let format = if format == auto {
    if type(video-id) == int { "av" } else { "bv" }
  } else {
    lower(format)
  }
  if format == "bv" {
    if type(video-id) == int {
      av2bv(video-id, prefix: prefix)
    } else if type(video-id) == str {
      validate-bv(video-id)
      if (video-id.len() == 10) {
        if prefix { "BV" } + video-id
      } else {
        if prefix { video-id } else { video-id.slice(2) }
      }
    } else {
      invalid-video-id-type()
    }
  } else if format == "av" {
    let avid = if type(video-id) == str {
      bv2av(video-id)
    } else if type(video-id) == int {
      video-id
    } else {
      invalid-video-id-type()
    }
    if prefix { "AV" } + str(avid)
  } else {
    panic("Invalid video ID format: " + str(format))
  }
}

