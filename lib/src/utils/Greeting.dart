String greeting() {
  var nh = DateTime.now().hour;

  if (nh >= 5 && nh < 12) {
    return "#goodmorning";
  }
  if (nh >= 12 && nh < 18) {
    return "#goodafternoon";
  }
  if (nh >= 18 || nh < 5) {
    return "#goodevening";
  }
  return "Hey";
}
