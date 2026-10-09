# Causals Lab website

This repository contains the public website for [Causals Lab](https://causals.org). It is a static HTML/CSS site; the graph-building system and data are not included. The [download page](https://causals.org/download/) links to versioned graph files in the public [community repository](https://github.com/causals-lab/community/tree/main/data).

The community contribution process lives in [causals-lab/community](https://github.com/causals-lab/community). Publication and reuse terms for the ontology, graph, benchmarks, and implementation are handled separately in that repository's [OPENNESS.md](https://github.com/causals-lab/community/blob/main/OPENNESS.md).

The website is intended to be served by GitHub Pages. Edit the HTML files and `styles.css` at the repository root, then review the preview before publishing. No software license has been declared for this repository yet.

## Explore viewer

`explore/viewer.html` and its local `vis-network` asset are generated from the
NewsGraph panorama frontend by `scripts/build_causals_explore_viewer.py` in the
private NewsGraph repository. They contain frontend code, not graph data. The
viewer loads at `causals.org/explore/` in English by default and requests the
seven read-only panorama API endpoints through the existing ngrok address.
Each browser request includes `ngrok-skip-browser-warning: true`; the NewsGraph
server must run the matching narrow CORS preflight middleware before this works.
The team's PC and ngrok tunnel remain the data source and can still go offline.

Do not revert to an iframe that navigates directly to the ngrok `/panorama`
page: first-time browser visitors would again see ngrok's interstitial. Do not
publish private graph candidate exports in this website repository without the
separate data-release review.
