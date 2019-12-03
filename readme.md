# AllRecipes webscraper

## Background/Overview

This is a web scraper class that I built in ``ruby`` to help with another project of mine.
It is simply used to compile a json file with all your search results.


### Initial Configuration

Download the repository.
In the terminal, navigate to the directory and run ``bundle install``  
to install the following gems:  
``httparty``
``nokogiri``

## Getting started

Within a new ruby file or a ruby shell, initialize the ``Recipes`` class by using ``require_relative "recipe_scrape.rb"``  
Initialize the new class with a name of the json file you want to save your results to.  


Sample query:  

```
recipes = Recipes.new('recipes')
recipes.query_results("beef")
```
The query results will save (and append) to ``recipes.json``  
Related recipe images will be saved to your /images/ folder

Note that if your query has spaces, replace the spaces with "%20".  
For example ``"chicken broth"`` => ``"chicken%20broth"``  


Sample json output:  


```
{
  "scrapeId": 1,
  "name": "Braised Corned Beef Brisket",
  "description": "Serve a tender corned beef brisket to your family for any special occasion or just because it's so tasty. The meat is slowly cooked in an oven for maximum flavor.",
  "url": "https://www.allrecipes.com/recipe/231030/braised-corned-beef-brisket/",
  "image": "https://images.media-allrecipes.com/userphotos/300x300/995620.jpg",
  "rating": 4.80999994277954,
  "author": "mauigirl",
  "ingredients": [
    "1 (5 pound) flat-cut corned beef brisket",
    "1 tablespoon browning sauce (such as Kitchen Bouquet(R)), or as desired",
    "1 tablespoon vegetable oil",
    "1 onion, sliced",
    "6 cloves garlic, sliced",
    "2 tablespoons water"
  ],
  "steps": [
    "Preheat oven to 275 degrees F (135 degrees C).",
    "Discard any flavoring packet from corned beef. Brush brisket with browning sauce on both sides. Heat vegetable oil in a large skillet over medium-high heat and brown brisket on both sides in the hot oil, 5 to 8 minutes per side.",
    "Place brisket on a rack set in a roasting pan. Scatter onion and garlic slices over brisket and add water to roasting pan. Cover pan tightly with aluminum foil.",
    "Roast in the preheated oven until meat is tender, about 6 hours."
  ]
}

```

## Attribution

https://www.allrecipes.com