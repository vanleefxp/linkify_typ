/// Generate nicely formatted, clickable links to media contents that can be directly inserted into articles. The media contents are mostly displayed by their content IDs.
///
/// If you want to customize the display content instead of using the default content ID, you can use the `linkify.url` sub-libray to generate string URLs and put it in a `link` element with custom content instead.

#import "_impl/display.typ": (
  bili,
  weixin,
  youtube,
  wiki,
  moegirl,
  twitter,
  isbn,
)

#let B站 = bili
#let 微信 = weixin
#let 油管 = youtube
#let 维基 = wiki
#let 萌百 = moegirl
#let 推特 = twitter
#let X = twitter

