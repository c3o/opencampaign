function makePoly(map) {
  var geoXml = new GGeoXml("http://boinkor.net/tmp/constituencies.kml");
  map.addOverlay(geoXml);
  map.removeMapType(G_HYBRID_MAP);
  map.removeMapType(G_NORMAL_MAP);
  map.removeMapType(G_SATELLITE_MAP);
// p.show();
 
}