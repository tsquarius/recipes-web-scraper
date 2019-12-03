require "nokogiri"
require "httparty"
require "byebug"
require "json"
require "open-uri"

class Recipes
  
  attr_reader :recipe_details, :recipe_index, :scrape_id

  def initialize(fileName)
    @name = fileName.to_s
    @recipe_index = []
    @recipe_details = {}
    @scrape_id = 1
  end

  def query_results(query)
    url="https://www.allrecipes.com/search/results/?wt=#{query}&sort=re"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)

    articles = parsed_page.css('article.fixed-recipe-card')
    
    articles.each do |article|
      data = {}

      if article.css('img.grid-col__rec-image.video-card__image').length > 0
        next
      end

      data['scrapeId'] = @scrape_id
      data['name'] = article.css('h3.fixed-recipe-card__h3').text.lstrip.rstrip
      data['description'] = article.css('div.fixed-recipe-card__description').text.lstrip.rstrip
      data['url'] = article.css('a').first.attribute('href').value
      data['image'] = article.css('img.fixed-recipe-card__img').attribute('data-original-src').value
      data['rating'] = article.css('div.fixed-recipe-card__ratings').css('span').attribute('data-ratingstars').value.to_f
      data['author'] = article.css('ul.cook-submitter-info').css('h4').children[1].text.lstrip

      instructions = query_details(data['url'])

      data.merge!(instructions)

      
      File.open("#{@name}.json", "a+") do |f|
        f.write(JSON.pretty_generate(data))
      end

      File.open("./images/#{@scrape_id}.png", "wb") do |f|
        f.write(open(data['image']).read)
      end

      @scrape_id += 1
     end
  end

  def query_details(url)
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)

    ingredients_list = []

    ingredients = parsed_page.css('li.checkList__line')
    ingredients.each do |ingredient|
      item = ingredient.children[1].attribute('title')
      if (item)
        ingredients_list << item.value
      else
        next
      end
    end

    steps_list = []
    steps = parsed_page.css('span.recipe-directions__list--item')
    steps.each do |step|
      item = step.text.rstrip.split("\n").first
      steps_list << item
    end

    steps_list.pop

    data = {}
    data['ingredients'] = ingredients_list
    data['steps'] = steps_list

    return data
  end

end