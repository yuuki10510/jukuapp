// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "chart.js"

document.addEventListener("turbo:load", () => {
  if (window.Chartkick) {
    Chartkick.eachChart(chart => chart.redraw())
  }
})