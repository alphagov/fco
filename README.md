Foreign and Commonwealth Office Travel Advice & News
==

This app forms part of the Gov UK platform. It provides FCO Travel Advice and News.

Requirements
--

* Rails 3.1
* MySQL

How to use
--

`rake api:import` synchronises with the FCO API. Run as often as you like.

About the maps
--

The map tiles were generated using [TileMill](http://mapbox.com/tilemill/), with the following stylesheet:

    @base: #95cfee;
    @land: #438214;

    Map { background-color:@base; }

    .water-poly { polygon-fill:@base; }

    #land[zoom>=0] {
      polygon-fill: @land;
      polygon-gamma:0.7;
    }

This was then exported at zoom levels 1-8 for the whole world to a MBTile file. This file was then converted into an {x}/{y}/{z} tree of PNG images, using TileStache:

    ./tilestache-seed.py --from-mbtiles coastlines.mbtiles -c tilestache_config.json --layer coastlines

With the config file:

    {
      "cache": {
        "name": "Disk",
        "path": "/tmp/stache",
        "umask": "0000",
        "dirs": "portable",
        "gzip": ["xml", "json"]
      },
      "layers": {
        "coastlines": {
          "provider": {
            "name": "mbtiles",
            "tileset": "coastlines.mbtiles"
          }
        }
      }
    }

This tree of files was then uploaded to the Amazon S3 bucket `tiles.alphagov.co.uk/coastlines`.

The country borders are provided as vector files. These were download from the [Natural Earth 50m cultural dataset](http://www.naturalearthdata.com/downloads/50m-cultural-vectors/), and converted to GeoJSON using ogr2ogr:

    ogr2ogr -f "GeoJSON" borders.json ne_50m_admin_0_countries.shp ne_50m_admin_0_countries

There's a rake task `maps:generate_border_files` that takes the `borders.json` file in `data` and converts it to separate files for each country, named by the ISO code and placed into `public/fco-assets/borders`.