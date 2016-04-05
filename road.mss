
// ==================================================================
// ROAD & RAIL LINES
// ==================================================================

// At Z12 and above there are 3 basic levels of road styles:
// - ::line, for single line (caseless) rendering
// - ::case, the casing part of an outlined road
// - ::fill, the fill part of an outlined road

// Road width variables that are used in road & bridge styles
@rdz08_maj: 1.2;
@rdz09_maj: 1.4; @rdz09_med: 0.6; @rdz09_min: 0;
@rdz10_maj: 1.8; @rdz10_med: 0.8; @rdz10_min: 0;
@rdz11_maj: 2;   @rdz11_med: 1.2; @rdz11_min: 0;
@rdz12_maj: 2.5; @rdz12_med: 1.4; @rdz12_min: 0.5;
@rdz13_maj: 3;   @rdz13_med: 2.0; @rdz13_min: 1;
@rdz14_maj: 4;   @rdz14_med: 3;   @rdz14_min: 1.6;
@rdz15_maj: 5;   @rdz15_med: 4;   @rdz15_min: 2;
@rdz16_maj: 9;   @rdz16_med: 7;   @rdz16_min: 3;
@rdz17_maj: 14;  @rdz17_med: 12;  @rdz17_min: 6;
@rdz18_maj: 20;  @rdz18_med: 16;  @rdz18_min: 10;

// Attachment ordering + any style-level rules

#road[structure='tunnel'] {
  // tunnel is drawn in a single attachment to allow for
  // style-level opacity. Side effect is that casing overlaps
  // where tunnels merge.
  opacity: 0.15;
}

#road::line,
#road::line[structure='bridge'] {
  opacity: 1;
}

#road::case {
  opacity: 0.12;
}

#road::fill,
#road::fill[structure='bridge'] {
  opacity: 1;
}

#road::fill[structure='bridge'] {
  opacity: 1;
}

#road::case[structure='bridge'] {
  opacity: 0.2;
}


// ---- Line ----------------------------------------------------

// Puts caseless roads beneath casings to highlight major roads.
// Tunnels and bridges still include casing, tunnels require
// appropriate attachments too.

#road::line[class='street_limited'][zoom>=14],
#road::line[class='pedestrian'][zoom>=14],
{
  ['mapnik::geometry_type'=2] {
    line-color: @road_line;
    line-smooth: 0.4;
    [zoom=15] { line-width: @rdz15_min / 2; }
    [zoom=16] { line-width: @rdz16_min / 2; }
    [zoom=17] { line-width: @rdz17_min / 2; }
    [zoom>17] { line-width: @rdz18_min / 2; }
   }
}


#road::line[class='service'][zoom>=13] {
  ['mapnik::geometry_type'=2] {
    line-color: @road_line;
    line-smooth: 0.4;
    [zoom=13] { line-width: @rdz13_min / 3; }
    [zoom=14] { line-width: @rdz14_min / 3; }
    [zoom=15] { line-width: @rdz15_min / 3; }
    [zoom=16] { line-width: @rdz16_min / 3; }
    [zoom=17] { line-width: @rdz17_min / 3; }
    [zoom>17] { line-width: @rdz18_min / 3; }
  }
  ['mapnik::geometry_type'=3] {
    polygon-fill: @road_line;
  }
}


#road::line[class='tertiary'][zoom>=15] {
  ['mapnik::geometry_type'=2] {
    line-opacity: 0.5;
    line-color: @road_line;
    [zoom=15] { line-width: @rdz15_min / 4; }
    [zoom=16] { line-width: @rdz16_min / 4; }
    [zoom=17] { line-width: @rdz17_min / 4; }
    [zoom>17] { line-width: @rdz18_min / 4; }
  }
  ['mapnik::geometry_type'=3] {
    polygon-fill: @road_line;
    polygon-opacity: 0.5;
  }
}


#road::fill[structure='bridge']['mapnik::geometry_type'=2],
#road::fill[structure='tunnel']['mapnik::geometry_type'=2] {
  [class='path'][zoom>=14] {
    m/line-color: @land;
    m/line-width: 1 + 1;
    [zoom>=15] { m/line-width: 1.2 + 1; }
    [zoom>=16] { m/line-width: 1.4 + 1; }
    [zoom>=17] { m/line-width: 1.8 + 1; }
    [zoom>=18] { m/line-width: 2.6 + 1; }
  }
}

// All paths are white lines
#road::line[structure!='tunnel']{
  [class='path'], [class='track'] {
    ['mapnik::geometry_type'=2] {
      line-color: @path_line;
      line-opacity: 0.75;
      line-width: 1;
      line-smooth: 0.7;
      [zoom>=15] { line-width: 1.2; }
      [zoom>=16] { line-width: 1.4; }
      [zoom>=17] { line-width: 1.8; }
      [zoom>=18] { line-width: 2.6; }
    
    ['type'='track:grade5'] {
       line-dasharray: 4, 4;
       line-opacity: 0.4;
    }
    ['type'='track:grade4'],
    ['type'='track:grade3'] {
       line-dasharray: 8, 4;
       line-opacity: 0.8;
    }
    ['type'='cycleway'] {
      [zoom>=15] { line-width: 2.2; }
      [zoom>=16] { line-width: 3.4; }
      [zoom>=17] { line-width: 3.8; }
      [zoom>=18] { line-width: 5.6; }
        }
      }
  }
}

// Paths inside tunnels are dashed
#road::line[structure='tunnel'] {
  [class='path'] {
    ['mapnik::geometry_type'=2] {
      line-color: @path_line;
      line-opacity: 0.75;
      line-width: 1;
      line-smooth: 0.7;
      line-dasharray: 5, 5;
      [zoom>=15] { line-width: 1.2; }
      [zoom>=16] { line-width: 1.4; }
      [zoom>=17] { line-width: 1.8; }
      [zoom>=18] { line-width: 2.6; }
    }
  }
}


// ---- Casing --------------------------------------------------

// case fuer autobahnen
#road::case[class='motorway'][structure!='bridge'][zoom>=8] {
  ['mapnik::geometry_type'=2] {
    line-color: @motorway_case;
    [zoom=8]  { line-width: @rdz08_maj + 2.5; }
    [zoom=9]  { line-width: @rdz09_maj + 2.5; }
    [zoom=10] { line-width: @rdz10_maj + 2.5; }
    [zoom=11] { line-width: @rdz10_maj + 2.5; }
    [zoom=11] { line-width: @rdz11_maj + 2.5; }
    [zoom=12] { line-width: @rdz12_maj + 2.5; }
    [zoom=13] { line-width: @rdz13_maj + 3; }
    [zoom=14] { line-width: @rdz14_maj + 3.5; }
    [zoom=15] { line-width: @rdz15_maj + 4; }
    [zoom=16] { line-width: @rdz16_maj + 5; }
    [zoom=17] { line-width: @rdz17_maj + 5; }
    [zoom>17] { line-width: @rdz18_maj + 5; }
  }
  
}

// case fuer autobahnauffahrten
#road::case[class='motorway_link'][structure!='bridge'][zoom>=9] {
  ['mapnik::geometry_type'=2] {
    line-color: @motorway_case;
    [zoom=11] { line-width: @rdz11_maj / 2 + 2; }
    [zoom=12] { line-width: @rdz12_maj / 2 + 2; }
    [zoom=13] { line-width: @rdz13_maj / 2 + 2; }
    [zoom=14] { line-width: @rdz14_maj / 2 + 2; }
    [zoom=15] { line-width: @rdz15_maj / 2 + 2.5; }
    [zoom=16] { line-width: @rdz16_maj / 2 + 3; }
    [zoom=17] { line-width: @rdz17_maj / 2 + 4; }
    [zoom>17] { line-width: @rdz18_maj / 2 + 4; }
  }
}

// case fuer groessere strassen
#road::case[class='trunk'][zoom>=11], 
#road::case[class='primary'][zoom>=11], 
#road::case[class='link'][zoom>=11],
#road::case[class='secondary'][zoom>=11], 
#road::case[class='tertiary'][zoom>=11] {
  ['mapnik::geometry_type'=2] {
    line-color: @main_case;
    line-join: round;
    line-cap: round;
    [zoom=11] { line-width: @rdz11_med + 2; }
    [zoom=12] { line-width: @rdz12_med + 2; }
    [zoom=13] { line-width: @rdz13_med + 2; }
    [zoom=14] { line-width: @rdz14_med + 2; }
    [zoom=15] { line-width: @rdz15_med + 2.5; }
    [zoom=16] { line-width: @rdz16_med + 3; }
    [zoom=17] { line-width: @rdz17_med + 4; }
    [zoom>17] { line-width: @rdz18_med + 4; }
  }
  ['mapnik::geometry_type'=3] {
    line-color: @main_case;
    line-cap: round;
    line-join: round;
    line-width: 4;
  }
}

// case fuer kleinere strassen
#road::case[class='street'][zoom>=14] {
  ['mapnik::geometry_type'=1] {
    marker-allow-overlap: true;
    marker-ignore-placement: true;
    [zoom=14] { marker-width: @rdz14_min * 1.8; }
    [zoom=15] { marker-width: @rdz15_min * 1.8; }
    [zoom=16] { marker-width: @rdz16_min * 1.8; }
    [zoom=17] { marker-width: @rdz17_min * 1.8; }
    [zoom>17] { marker-width: @rdz18_min * 1.8; }
    marker-line-color: @road_case;
    [zoom=14] { marker-line-width: 2; }
    [zoom=15] { marker-line-width: 2; }
    [zoom=16] { marker-line-width: 2.5; }
    [zoom=17] { marker-line-width: 3; }
    [zoom>17] { marker-line-width: 3; }
  }
  ['mapnik::geometry_type'=2] {
    line-color: @road_case;
    line-join: round;
    line-cap: round;
    [zoom=14] { line-width: @rdz14_min + 2; }
    [zoom=15] { line-width: @rdz15_min + 2; }
    [zoom=16] { line-width: @rdz16_min + 2.5; }
    [zoom=17] { line-width: @rdz17_min + 3; }
    [zoom>17] { line-width: @rdz18_min + 3; }
  }
  ['mapnik::geometry_type'=3] {
    line-color: @road_case;
    line-join: round;
    line-cap: round;
    line-width: 2;
    [zoom=16] { line-width: 2.5; }
    [zoom>=17] { line-width: 3; }
  }
}


#road::case[structure='tunnel'][class='service'][zoom>=16],
#road::case[structure='bridge'][class='service'][zoom>=16] {
  ['mapnik::geometry_type'=2] {
    line-color: @road_case;
    line-join: round;
    line-cap: butt;
    [zoom=16] { line-width: @rdz16_min / 3 + 2; }
    [zoom=17] { line-width: @rdz17_min / 3 + 2.5; }
    [zoom>17] { line-width: @rdz18_min / 3 + 3; }
  }
  ['mapnik::geometry_type'=3] {
    line-color: @road_case;
    line-join: round;
    line-cap: round;
    line-width: 2;
    [zoom=16] { line-width: 2.5; }
    [zoom>=17] { line-width: 3; }
  }
}

#road::case[structure='tunnel'][class='street_limited'][zoom>=14],
#road::case[structure='bridge'][class='street_limited'][zoom>=14] {
  ['mapnik::geometry_type'=2] {
    line-color: @road_case;
    line-join: round;
    line-cap: round;
    [zoom=14] { line-width: @rdz14_min * 0.75 + 1.8; line-opacity: 0.75; }
    [zoom=15] { line-width: @rdz15_min * 0.75 + 1.8; }
    [zoom=16] { line-width: @rdz16_min * 0.75 + 2; }
    [zoom=17] { line-width: @rdz17_min * 0.75 + 2; }
    [zoom>17] { line-width: @rdz18_min * 0.75 + 2; }
  }
  ['mapnik::geometry_type'=3] {
    line-color: @road_case;
    line-join: round;
    line-cap: round;
    line-width: 1.8;
    [zoom=16] { line-width: 2; }
    [zoom>=17] { line-width: 2; }
    polygon-fill: @land;
  }
}

#road::case[structure='tunnel'][class='street_limited']
     [zoom>=14]['mapnik::geometry_type'=2] {
  line-cap: butt;
  line-dasharray: 6 , 2;
}


#road::case[structure='tunnel'],
#road::case[structure='bridge'], {
  [class='path'][zoom>=14] {
    line-join: round;
    line-color: @road_case;
    #road::case[structure='tunnel'] { line-dasharray: 2, 2; }
    line-width: 1 + 2;
    [zoom=15] { line-width: 1.2 + 2; }
    [zoom=16] { line-width: 1.4 + 2.5; }
    [zoom=17] { line-width: 1.8 + 3; }
    [zoom>17] { line-width: 2.6 + 3; }
  }
}

#road::case[structure='tunnel'][zoom>=12]['mapnik::geometry_type'=2] {
  [class='motorway'],
  [class='motorway_link'],
  [class='trunk'],
  [class='primary'],
  [class='secondary'],
  [class='tertiary'],
  [class='street'],
  [class='street_limited'],
  [class='service'],
  [class='driveway'],
  [class='path'] {
    line-cap: butt;
    line-dasharray: 6 , 2;
  }
}


#road::case[structure='bridge'][zoom>=12]['mapnik::geometry_type'=2] {
  [class='motorway'],
  [class='motorway_link'],
  [class='trunk'],
  [class='primary'],
  [class='secondary'],
  [class='tertiary'],
  [class='street'],
  [class='street_limited'][zoom>=14],
  [class='service'][zoom>=14],
  [class='driveway'][zoom>=15],
  [class='path'][zoom>=16] {
    line-cap: butt;
  }
}


#road::case[structure='tunnel'][zoom>=15] {
  ['mapnik::geometry_type'=2] {
    // colors & styles
    m/line-color: @land;
    m/line-join: round;
    // widths
    [zoom=15] {
      [class='trunk'] { m/line-width: @rdz15_med; }
      [class='primary'] { m/line-width: @rdz15_med; }
      [class='secondary'] { m/line-width: @rdz15_med; }
      [class='trunk'] { m/line-width: @rdz15_med; }
      [class='street'] { m/line-width: @rdz15_min; }
      [class='street_limited'] { m/line-width: @rdz15_min * 0.75; }
      [class='service'] { m/line-width: @rdz15_min / 3; }
      [class='major_rail'] { m/line-width: (1.5 + 1); }
      [class='minor_rail'] { m/line-width: (1.5 + 1); }
    }
    [zoom=16] {
      [class='trunk'] { m/line-width: @rdz16_med; }
      [class='primary'] { m/line-width: @rdz16_med; }
      [class='secondary'] { m/line-width: @rdz16_med; }
      [class='tertiary'] { m/line-width: @rdz16_med; }
      [class='street'] { m/line-width: @rdz16_min; }
      [class='street_limited'] { m/line-width: @rdz16_min * 0.75; }
      [class='service'] { m/line-width: @rdz16_min / 3; }
      [class='path'] { m/line-width: (@rdz16_min / 4 + 1); }
      [class='major_rail'] { m/line-width: (2 + 1); }
      [class='minor_rail'] { m/line-width: (2 + 1); }
    }
    [zoom=17] {
      [class='trunk'] { m/line-width: @rdz17_med; }
      [class='primary'] { m/line-width: @rdz17_med; }
      [class='secondary'] { m/line-width: @rdz17_med; }
      [class='tertiary'] { m/line-width: @rdz17_med; }
      [class='street'] { m/line-width: @rdz17_min; }
      [class='street_limited'] { m/line-width: @rdz17_min * 0.75; }
      [class='service'] { m/line-width: @rdz17_min / 3; }
      [class='path'] { m/line-width: (@rdz17_min / 4 + 2); }
      [class='major_rail'] { m/line-width: (3 + 2); }
      [class='minor_rail'] { m/line-width: (3 + 2); }
    }
    [zoom>17] {
      [class='trunk'] { m/line-width: @rdz18_med; }
      [class='primary'] { m/line-width: @rdz18_med; }
      [class='secondary'] { m/line-width: @rdz18_med; }
      [class='tertiary'] { m/line-width: @rdz18_med; }
      [class='street'] { m/line-width: @rdz18_min; }
      [class='street_limited'] { m/line-width: @rdz18_min * 0.75; }
      [class='service'] { m/line-width: @rdz18_min / 3; }
      [class='path'] { m/line-width: (@rdz18_min / 4 + 2);  }
      [class='major_rail'] { m/line-width: (4 + 3); }
      [class='minor_rail'] { m/line-width: (4 + 3); }
    }
  }
}


// ---- Fill ----------------------------------------------------

#road::fill[class='motorway'][zoom>=8] {
  ['mapnik::geometry_type'=2] {
    f/line-color: @motorway_fill;
    f/line-cap: round;
    f/line-join: round;
    [zoom=8] { f/line-width: @rdz08_maj; }
    [zoom=9] { f/line-width: @rdz09_maj; }
    [zoom=10] { f/line-width: @rdz10_maj; }
    [zoom=11] { f/line-width: @rdz10_maj; }
    [zoom=11] { f/line-width: @rdz11_maj; }
    [zoom=12] { f/line-width: @rdz12_maj; }
    [zoom=13] { f/line-width: @rdz13_maj; }
    [zoom=14] { f/line-width: @rdz14_maj; }
    [zoom=15] { f/line-width: @rdz15_maj; }
    [zoom=16] { f/line-width: @rdz16_maj; }
    [zoom=17] { f/line-width: @rdz17_maj; }
    [zoom>17] { f/line-width: @rdz18_maj; }
  }
}

#road::fill[class='motorway_link'][zoom>=9] {
  ['mapnik::geometry_type'=2] {
    f/line-color: mix(@motorway_fill,@main_fill,50%);
    f/line-cap: round;
    f/line-join: round;
    [zoom=11] { f/line-width: @rdz11_maj / 2; }
    [zoom=12] { f/line-width: @rdz12_maj / 2; }
    [zoom=13] { f/line-width: @rdz13_maj / 2; }
    [zoom=14] { f/line-width: @rdz14_maj / 2; }
    [zoom=15] { f/line-width: @rdz15_maj / 2; }
    [zoom=16] { f/line-width: @rdz16_maj / 2; }
    [zoom=17] { f/line-width: @rdz17_maj / 2; }
    [zoom>17] { f/line-width: @rdz18_maj / 2; }
  }
}

#road::fill[class='trunk'][zoom>=11],
#road::fill[class='primary'][zoom>=11],
#road::fill[class='link'][zoom>=11],
#road::fill[class='secondary'][zoom>=11],
#road::fill[class='tertiary'][zoom>=11] {
  ['mapnik::geometry_type'=2] {
    f/line-color: @main_fill;
    f/line-cap: round;
    f/line-join: round;
    [zoom=11] { f/line-width: @rdz11_med; }
    [zoom=12] { f/line-width: @rdz12_med; }
    [zoom=13] { f/line-width: @rdz13_med; }
    [zoom=14] { f/line-width: @rdz14_med; }
    [zoom=15] { f/line-width: @rdz15_med; }
    [zoom=16] { f/line-width: @rdz16_med; }
    [zoom=17] { f/line-width: @rdz17_med; }
    [zoom>17] { f/line-width: @rdz18_med; }
  }
  ['mapnik::geometry_type'=3] {
    f/polygon-fill: @main_fill;
  }
}


#road::fill[class='street'][zoom>=14] {
  ['mapnik::geometry_type'=2] {
    f/line-color: @road_fill;
    f/line-cap: round;
    f/line-join: round;
    [zoom=14] { f/line-width: @rdz14_min; }
    [zoom=15] { f/line-width: @rdz15_min; }
    [zoom=16] { f/line-width: @rdz16_min; }
    [zoom=17] { f/line-width: @rdz17_min; }
    [zoom>17] { f/line-width: @rdz18_min; }
  }
  ['mapnik::geometry_type'=3] {
    f/polygon-fill: @road_fill;
  }
}
#road::fill[class='street'][zoom>=14] {
  ['mapnik::geometry_type'=1] {
    f/marker-allow-overlap: true;
    f/marker-ignore-placement: true;
    f/marker-fill: @road_fill;
    f/marker-line-opacity: 0;
    [zoom=14] { f/marker-width: @rdz14_min * 1.8; }
    [zoom=15] { f/marker-width: @rdz15_min * 1.8; }
    [zoom=16] { f/marker-width: @rdz16_min * 1.8; }
    [zoom=17] { f/marker-width: @rdz17_min * 1.8; }
    [zoom>17] { f/marker-width: @rdz18_min * 1.8; }
  }
}

#road::tram[class='minor_rail'][type='tram'] {
  ['mapnik::geometry_type'=2] {
    f/line-color: @rail_line;
    f/line-dasharray: 1, 2;
    f/opacity: 0.7;
    [zoom>=16] { f/line-dasharray: 1, 2; }
    [zoom=13] { f/line-width: 0.8; }
    [zoom=14] { f/line-width: 1; }
    [zoom=15] { f/line-width: 1.5; }
    [zoom=16] { f/line-width: 2; }
    [zoom>16] { f/line-width: 3; }
  }
}

// XXX bridge fix
#road::bridgecase[class='motorway'][structure='bridge'][zoom>=8] {
  ['mapnik::geometry_type'=2] {
    opacity: 0.12;
    line-color: @motorway_case;
    [zoom=8]  { line-width: @rdz08_maj + 2.5; }
    [zoom=9]  { line-width: @rdz09_maj + 2.5; }
    [zoom=10] { line-width: @rdz10_maj + 2.5; }
    [zoom=11] { line-width: @rdz10_maj + 2.5; }
    [zoom=11] { line-width: @rdz11_maj + 2.5; }
    [zoom=12] { line-width: @rdz12_maj + 2.5; }
    [zoom=13] { line-width: @rdz13_maj + 3; }
    [zoom=14] { line-width: @rdz14_maj + 3.5; }
    [zoom=15] { line-width: @rdz15_maj + 4; }
    [zoom=16] { line-width: @rdz16_maj + 5; }
    [zoom=17] { line-width: @rdz17_maj + 5; }
    [zoom>17] { line-width: @rdz18_maj + 5; }
  }
}

#road::bridgefill[class='motorway'][structure='bridge'][zoom>=8] {
  ['mapnik::geometry_type'=2] {
    f/line-color: @motorway_fill;
    [zoom=8] { f/line-width: @rdz08_maj; }
    [zoom=9] { f/line-width: @rdz09_maj; }
    [zoom=10] { f/line-width: @rdz10_maj; }
    [zoom=11] { f/line-width: @rdz10_maj; }
    [zoom=11] { f/line-width: @rdz11_maj; }
    [zoom=12] { f/line-width: @rdz12_maj; }
    [zoom=13] { f/line-width: @rdz13_maj; }
    [zoom=14] { f/line-width: @rdz14_maj; }
    [zoom=15] { f/line-width: @rdz15_maj; }
    [zoom=16] { f/line-width: @rdz16_maj; }
    [zoom=17] { f/line-width: @rdz17_maj; }
    [zoom>17] { f/line-width: @rdz18_maj; }
  }
}

#road::bridgecase[class='motorway_link'][structure='bridge'][zoom>=9] {
  ['mapnik::geometry_type'=2] {
    line-color: @motorway_case;
    opacity: 0.12;
    [zoom=11] { line-width: @rdz11_maj / 2 + 2; }
    [zoom=12] { line-width: @rdz12_maj / 2 + 2; }
    [zoom=13] { line-width: @rdz13_maj / 2 + 2; }
    [zoom=14] { line-width: @rdz14_maj / 2 + 2; }
    [zoom=15] { line-width: @rdz15_maj / 2 + 2.5; }
    [zoom=16] { line-width: @rdz16_maj / 2 + 3; }
    [zoom=17] { line-width: @rdz17_maj / 2 + 4; }
    [zoom>17] { line-width: @rdz18_maj / 2 + 4; }
  }
}


#road::bridgefill[class='motorway_link'][structure='bridge'][zoom>=9] {
  ['mapnik::geometry_type'=2] {
    f/line-color: mix(@motorway_fill,@main_fill,50%);    
    [zoom=11] { f/line-width: @rdz11_maj / 2; }
    [zoom=12] { f/line-width: @rdz12_maj / 2; }
    [zoom=13] { f/line-width: @rdz13_maj / 2; }
    [zoom=14] { f/line-width: @rdz14_maj / 2; }
    [zoom=15] { f/line-width: @rdz15_maj / 2; }
    [zoom=16] { f/line-width: @rdz16_maj / 2; }
    [zoom=17] { f/line-width: @rdz17_maj / 2; }
    [zoom>17] { f/line-width: @rdz18_maj / 2; }
  }
}

#road::bridgecase[structure='bridge'][class='service'][zoom>=16] {
  ['mapnik::geometry_type'=2] {
    line-color: @road_case;
    line-join: round;
    line-cap: butt;
    [zoom=16] { line-width: @rdz16_min / 3 + 1; }
    [zoom=17] { line-width: @rdz17_min / 3 + 1.5; }
    [zoom>17] { line-width: @rdz18_min / 3 + 2; }
  }
  ['mapnik::geometry_type'=3] {
    line-color: @road_case;
    line-join: round;
    line-cap: round;
    line-width: 2;
    [zoom=16] { line-width: 1.5; }
    [zoom>=17] { line-width: 2; }
  }
}


#road::bridgeline[class='service'][structure='bridge'][zoom>=13] {
  ['mapnik::geometry_type'=2] {
    line-color: @road_line;
    line-smooth: 0.4;
    [zoom=13] { line-width: @rdz13_min / 3; }
    [zoom=14] { line-width: @rdz14_min / 3; }
    [zoom=15] { line-width: @rdz15_min / 3; }
    [zoom=16] { line-width: @rdz16_min / 3; }
    [zoom=17] { line-width: @rdz17_min / 3; }
    [zoom>17] { line-width: @rdz18_min / 3; }
  }
  ['mapnik::geometry_type'=3] {
    polygon-fill: @road_line;
  }
}

