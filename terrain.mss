#hillshade {
  ::0[zoom<=14],
  ::1[zoom=15],
  ::2[zoom=16],
  ::3[zoom>=17] {
    image-filters-inflate: true;
    comp-op: hard-light;
    [class='shadow'] {
      polygon-fill: rgba(0,0,0,0.075);
    }
    [class='highlight'] {
      polygon-fill: rgba(255,255,255,0.125);
    }
  }
  ::1 { image-filters: agg-stack-blur(2,2); }
  ::2 { image-filters: agg-stack-blur(4,4); }
  ::3 { image-filters: agg-stack-blur(8,8); }
}

#landcover {
  [zoom>=12] { polygon-opacity: 0.16; }
  [class='wood'] { polygon-fill: @wood; }
  [class='scrub'] { polygon-fill: mix(@wood,@crop,67%); }
  [class='grass'] { polygon-fill: mix(@wood,@crop,33%); }
  [class='crop'] { polygon-fill: @crop; }
  [class='snow'] { polygon-fill: #eff; }
}

#contour.line[index!=-1] {
  line-width: 0.5;
  line-opacity: 0.1;
  [index>=5] { line-opacity: 0.2; }
}