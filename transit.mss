// =====================================================================
// Suburb Labels
// =====================================================================
#place_label[type='suburb'][zoom>=12][localrank=1] {
  text-name: @name;
  text-face-name: @sans_lt;
  text-placement: point;
  text-fill: @other_text;
  text-size: 20;
  text-halo-fill: @other_halo;
  text-halo-radius: 1.5;
  text-halo-rasterizer: fast;
  text-wrap-width: 200;
  text-wrap-before: true;
  text-line-spacing: -2;
  text-allow-overlap: false;
}

// =====================================================================
// Public Transit Stations
// =====================================================================
#rail_station_label[network=~'rail.*'][zoom>10] {
	marker-file: url("img/rail/[network]-18.svg");
	marker-height: 24;
	marker-allow-overlap: false;

	text-name: @name;
	text-face-name: @sans;
	text-fill: @transport_text;
	text-halo-fill: #fff;
	text-halo-radius: 1.5;
	text-halo-rasterizer: fast;
	text-size: 11;
	text-wrap-width: 80;
	text-placement-type: simple;
	text-dy: 11;
	text-allow-overlap: false;

	[zoom>=15] {
	text-size: 12;
	text-halo-radius: 2;
	text-dy: 15;
	}
    [name="München Hauptbahnhof Gleis 5-10"],
    [name="München Hauptbahnhof"],
    [name="München Hauptbahnhof Gleis 27-36"]{
      text-name: '';
      marker-opacity: 0;
      marker-allow-overlap: true;
    }
}
