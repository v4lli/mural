// =====================================================================
// 2__ PLACE NAMES
// =====================================================================

// Staedte mit 10k bis 100k Ein
/*
#place_label[type='town'][zoom>=8][zoom<=17][localrank<=2] {
  text-name: @name;
  text-face-name: @sans;
  text-placement: point;
  text-fill: @town_text;
  text-halo-fill: @town_halo;
  text-halo-radius: 1.5;
  text-halo-rasterizer: fast;
  text-wrap-width: 75;
  text-wrap-before: true;
  text-line-spacing: -4;
  text-size: 11;
  [zoom>=8] { text-size: 12; }
  [zoom>=10] { text-size: 13; text-halo-radius: 2; }
  [zoom>=11] { text-size: 14; }
  [zoom>=12] { text-size: 15; text-wrap-width: 80; }
  [zoom>=13] { text-size: 16; text-wrap-width: 120; }
  [zoom>=14] { text-size: 18; text-wrap-width: 160; }
  [zoom>=15] { text-size: 20; text-wrap-width: 200; }
  [zoom>=16] { text-size: 22; text-wrap-width: 240; }
}

// Doerfer mit unter 10k Einwohnern

#place_label[type='village'][zoom>=10][zoom<=14][localrank<=2],
#place_label[type='village'][zoom>=15][zoom<=17] {
  text-name: @name;
  text-face-name: @sans;
  text-placement: point;
  text-fill: @town_text;
  text-size: 11;
  text-halo-fill: @town_halo;
  text-halo-radius: 1.5;
  text-halo-rasterizer: fast;
  text-wrap-width: 60;
  text-wrap-before: true;
  text-line-spacing: -4;
  [zoom>=12] { text-size: 12; }
  [zoom>=13] { text-wrap-width: 80; }
  [zoom>=14] { text-size: 14; text-wrap-width: 100; }
  [zoom>=15] { text-size: 16; text-wrap-width: 120; }
  [zoom>=16] { text-size: 18; text-wrap-width: 160; }
  [zoom=17] { text-size: 20; text-wrap-width: 200; }
}
*/

// =====================================================================
// 4__ WATER LABELS
// =====================================================================

#water_label {
	[zoom<=15][area>200000],
	[zoom=16][area>10000],
	[zoom=17][area>10000],
	[zoom>=18][area>0]{
		text-name: @name;
		text-halo-radius: 1.5;
		text-halo-rasterizer: fast;
		text-size: 11;
		text-wrap-width: 50;
		text-wrap-before: true;
		text-halo-fill: #fff;
		text-line-spacing: -2;
		text-face-name: @sans_italic;
		text-fill: darken(@water, 30);
	}
	[zoom>=14][area>3200000],
	[zoom>=15][area>800000],
	[zoom>=16][area>200000],
	[zoom>=17][area>50000],
	[zoom>=18][area>10000] {
		text-size: 12;
		text-wrap-width: 75;
	}
	[zoom>=15][area>3200000],
	[zoom>=16][area>800000],
	[zoom>=17][area>200000],
	[zoom>=18][area>50000] {
		text-size: 14;
		text-wrap-width: 100;
		text-halo-radius: 2;
	}
	[zoom>=16][area>3200000],
	[zoom>=17][area>800000],
	[zoom>=18][area>200000] {
		text-size: 16;
		text-wrap-width: 125;
	}
	[zoom>=17][area>3200000],
	[zoom>=18][area>800000] {
		text-size: 18;
		text-wrap-width: 150;
	}
}

#waterway_label[class='river'][zoom>=13],
#waterway_label[class='canal'][zoom>=15],
#waterway_label[class='stream'][zoom>=15],
#waterway_label[class='stream_intermittent'][zoom>=15] {
	text-name: @name;
	text-face-name: @sans_italic;
	text-repeat-distance: 5000000;
	text-avoid-edges: true;
	text-placement: line;
	text-spacing: 30000;
	text-min-path-length: 200;
	text-fill: darken(@water, 30);
	text-halo-fill: fadeout(#fff,80%);
	text-halo-radius: 1.5;
	text-halo-rasterizer: fast;
	text-allow-overlap: false;
	text-size: 10;
	text-character-spacing: 1;
	[class='river'][zoom=14],
	[class='canal'][zoom=16],
	[class='stream'][zoom>=15],
	[class='stream_intermittent'][zoom>=15] {
		text-size: 10;
	}
	[class='river'][zoom=15],
	[class='canal'][zoom>=17] {
		text-size: 12;
		text-spacing: 400;
	}
	[class='river'][zoom>=16],
	[class='canal'][zoom>=18] {
		text-size: 16;
		text-spacing: 500;
	}
}


/*

// =====================================================================
// 5__ ROAD LABELS
// =====================================================================

// regular labels
#road_label['mapnik::geometry_type'=2] {
	// Longer roads get a label earlier as they are likely to be more
	// important. This especially helps label density in rural/remote areas.
	// This z14 filter is *not* redundant to logic in SQL queries. Because z14
	// includes all data for z14+ via overzooming, the streets included in a
	// z14 vector tile include more features than ideal for optimal performance.
	[class='motorway'][zoom>=12],
	[class='primary'][zoom>=12],
	[class='trunk'][zoom>=12],
	[class='tertiary'][zoom>=15],
	[class='secondary'][zoom>=15],
	[class='street'][zoom>=15],
	[class='street_limited'] {
		text-avoid-edges: true;
		text-name: @name;
		text-character-spacing: 0.25;
		text-placement: line;
		text-face-name: @sans;
		text-fill: #666;
		text-size: 6;
		text-halo-fill: @road_halo;
		text-halo-radius: 1.5;
		text-halo-rasterizer: fast;
		text-repeat-distance: 500000;
		text-margin: 10;
		text-placement-type: simple;

		[zoom>=14] { text-size: 6.5; }
		[zoom>=16] { text-size: 8.5; }
		[zoom>=18] { text-size: 9.5; }

		[class='motorway'],[class='trunk'],
		[class='primary'],[class='secondary'] {
			text-transform: uppercase;
			text-fill: #444;
			text-min-path-length: 170;;

			text-spacing: 80000;
			text-margin: 100;
			text-allow-overlap: false;
			text-repeat-distance: 1000;
			[zoom>=14] { text-size: 10; }
			[zoom>=16] { text-size: 11; text-face-name: @sans_bold; }
			[zoom>=17] { text-size: 12; }
			[zoom>=18] { text-size: 14; }
		}

		[name="Isarring"],[name="Lindwurmstraße"] {
			text-min-path-length: 300;
		}
		[name="Landsberger Straße"],[name="Bodenseestraße"] {
			text-min-path-length: 275;
		}
		[name="Chiemgaustraße"], [name="Ständlerstraße"] {
			text-min-path-length: 270;
		}
		[name="Einsteinstraße"],[name="Zschokkestraße"],
		[name="Innsbrucker Ring"],[name="Westendstraße"],
		[name="Rosenheimer Straße"],[name="Candidstraße"] {
			text-min-path-length: 250;
		}
		[name="Wittelsbacherstraße"],[name="Garmischer Straße"] {
			text-min-path-length: 230;
		}
		[name=~".*rücke"] {
			text-min-path-length: 0;
		}
	}
}



// less prominent labels for all other types, by length
#road_label['mapnik::geometry_type'=2]
[class!='motorway']
[class!='main']
[class!='street']
[class!='street_limited'] {
  [len>10000][zoom>=12],
  [len>5000][zoom>=13],
  [len>2500][zoom>=14],
  [len>1200][zoom>=15],
  [len>0][zoom>=16] {
    text-avoid-edges: true;
    text-name: @name;
    text-character-spacing: 0.25;
    text-placement: line;
    text-face-name: @sans;
    text-size: 9;
    [zoom>=17] { text-size: 10; }
    [zoom>=18] { text-size: 11; }
    text-repeat-distance: 5000;
    text-margin: 100;
  }
}
*/

// =====================================================================
// POI LABELS
// =====================================================================
#poi_label[type='Grave Yard'],
#poi_label[type='Cemetery'],
#poi_label[type='Hospital'],
#poi_label[type='Zoo'],
#poi_label[type='Museum']{
  [zoom>=14][scalerank<3]{
    text-name: @name;
    text-face-name: @sans;
    text-fill: #666;
    text-halo-fill: fadeout(#fff,75);
    text-halo-radius: 1;
    text-halo-rasterizer: fast;
    text-line-spacing: -4;
    text-wrap-width: 80;
    text-wrap-before: true;
    text-allow-overlap: false;
    [scalerank=1] {
      [zoom>=15] { text-size: 11; text-wrap-width: 100; }
      [zoom>=16] { text-size: 12; text-wrap-width: 120; }
      [zoom>=17] { text-size: 14; text-wrap-width: 130; }
    }
    [scalerank=2] {
      [zoom>=16] { text-size: 11; text-wrap-width: 100;}
      [zoom>=17] { text-size: 12; text-wrap-width: 120; }
    }
  }
}
