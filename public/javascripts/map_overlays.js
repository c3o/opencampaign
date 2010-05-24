function makePoly(map) {
  var geoXml = new GGeoXml("http://localhost:3000/constituencies.kml");
  map.addOverlay(geoXml);
  map.removeMapType(G_HYBRID_MAP);
  map.removeMapType(G_NORMAL_MAP);
  map.removeMapType(G_SATELLITE_MAP);
  // p.show();
}