/// A sub-module of `linkify` that focuses on processing Bilibili video ID. Bilibili currently has two main video ID formats, which are AVID and BVID. AVID was used in the past and #link("https://www.bilibili.com/blackboard/activity-BV-PC.html")[has been substituted by BVID] since 23, March, 2020 with the purpose to enhance platform security and adapt for more videos, but accessing videos via AVID is still supported.
///
/// - AVID is an integer which used to follow increasing order as new videos were published. Videos published later than the time when it was substituted by BVID no longer follows this rule.
/// - BVID is a string containing 10 alphanumeric characters. It is actually a Base58 encoding of AVID.

#import "_impl/bili.typ": (
  av2bv,
  bv2av,
  video-id-fmt,
  validate-bv,
  bv-regex,
)

