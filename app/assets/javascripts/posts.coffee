# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".chosen-select").chosen({
    display_selected_options: true,
    search_contains: true,
    allow_single_deselect: true,
    max_shown_results: 10,
    single_backstroke_delete: false,
    no_results_text: "Ninguna coincidencia",
    width: "100%"
  });